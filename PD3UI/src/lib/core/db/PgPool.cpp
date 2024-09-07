#include "pgpool.h"
#include <QDebug>
#include <QSqlError>
#include <QSqlQuery>
#include <QSqlRecord>

QList<QSqlDatabase> pgpool::freeConnections;
QList<QSqlDatabase> pgpool::usedConnections;
QMutex pgpool::mutex;
int pgpool::lastConnectionId = 0;
pgpool* pgpool::m_instance = nullptr;

QString pgpool::host = "127.0.0.1";
int pgpool::port = 5432;
QString pgpool::dbName = "PD3UI";
QString pgpool::user = "postgres";
QString pgpool::password = "PD3tech";

pgpool::pgpool() {
    loadConfiguration();
}

pgpool* pgpool::instance() {
    if (!m_instance) {
        QMutexLocker locker(&mutex);
        if (!m_instance) {
            m_instance = new pgpool();
        }
    }
    return m_instance;
}

void pgpool::loadConfiguration() {
    ConfigManager* config = ConfigManager::instance();

    // 从配置文件中读取数据库配置信息
    host = config->getValue("Database", "Host", "127.0.0.1").toString();
    port = config->getValue("Database", "Port", 5432).toInt();
    dbName = config->getValue("Database", "dbName", "PD3UI").toString();
    user = config->getValue("Database", "User", "postgres").toString();
    password = config->getValue("Database", "Password", "PD3tech").toString();

    // 如果读取失败或使用默认值，写回配置文件
    config->setValue("Database", "Host", host);
    config->setValue("Database", "Port", port);
    config->setValue("Database", "dbName", dbName);
    config->setValue("Database", "User", user);
    config->setValue("Database", "Password", password);
}

QSqlDatabase pgpool::getConnection() {
    QMutexLocker locker(&mutex);
    if (!freeConnections.isEmpty()) {
        auto db = freeConnections.takeFirst();
        usedConnections.append(db);
        return db;
    }
    QString connectionName = QString("Connection_%1").arg(++lastConnectionId);
    auto db = QSqlDatabase::addDatabase("QPSQL", connectionName);
    db.setHostName(host);
    db.setPort(port);
    db.setDatabaseName(dbName);
    db.setUserName(user);
    db.setPassword(password);
    if (!db.open()) {
        qDebug() << "Database connection failed: " << db.lastError().text();
        return QSqlDatabase();
    }
    usedConnections.append(db);
    qDebug() << "Database connection succeeded!";
    return db;
}

void pgpool::releaseConnection(const QSqlDatabase& db) {
    QMutexLocker locker(&mutex);
    for (int i = 0; i < usedConnections.size(); ++i) {
        if (usedConnections.at(i).connectionName() == db.connectionName()) {
            usedConnections.removeAt(i);
            break;
        }
    }
    freeConnections.append(db);
}

bool pgpool::testConnectionAsync() {
    QSqlDatabase testDb = getConnection();
    if (testDb.isValid() && testDb.isOpen()) {
        releaseConnection(testDb);
        qDebug() << "Database connection test succeeded!";
        return true;
    } else {
        qDebug() << "Database connection test failed: " << testDb.lastError().text();
        return false;
    }
}

QueryResult pgpool::executeQuery(const QString &queryStrOriginal, QSqlDatabase db) {
    QString queryStr = queryStrOriginal.trimmed().toLower();
    QSqlQuery query(db);
    QueryResult result;
    result.success = true;

    if (queryStr.startsWith("insert") || queryStr.startsWith("update") || queryStr.startsWith("delete")) {
        if (!queryStr.contains("returning")) {
            queryStr.append(" RETURNING *");
        }
    }
    if (!query.prepare(queryStr)) {
        db.rollback();
        result.success = false;
        result.error = "Failed to prepare statement: " + query.lastError().text();
        return result;
    }
    if (!query.exec()) {
        db.rollback();
        result.success = false;
        result.error = "Execution failed: " + query.lastError().text();
        return result;
    }

    if (queryStr.startsWith("select")) {
        while (query.next()) {
            QSqlRecord rec = query.record();
            QVariantMap row;
            for (int i = 0; i < rec.count(); i++) {
                row[rec.fieldName(i)] = query.value(i);
            }
            result.records.append(row);
        }
    } else {
        if (query.next()) {
            QVariantMap row;
            row["id"] = query.value(0);
            result.records.append(row);
        }
    }
    return result;
}

QueryResult pgpool::executeTransaction(const std::function<QueryResult(QSqlDatabase&)>& action) {
    QSqlDatabase db = getConnection();
    QueryResult result;
    result.success = true;
    if (!db.transaction()) {
        result.success = false;
        result.error = "Failed to start transaction.";
        return result;
    }
    try {
        result = action(db);
        if (!db.commit()) {
            throw std::runtime_error("Failed to commit transaction.");
        }
    } catch (const std::exception &e) {
        db.rollback();
        qDebug() << e.what();
        result.success = false;
        result.error = e.what();
    }

    releaseConnection(db);
    return result;
}
