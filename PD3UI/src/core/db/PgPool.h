#ifndef PGPOOL_H
#define PGPOOL_H

#include <QList>
#include <QMutex>
#include <QSqlDatabase>
#include <QMap>
#include <QObject>
#include <functional>
#include "../common/queryInterface.h"
#include "../utils/ConfigManager.h"

class pgpool : public QObject {
    Q_OBJECT

public:
    static pgpool* instance();
    Q_INVOKABLE bool testConnectionAsync();
    QueryResult executeQuery(const QString &queryStrOriginal, QSqlDatabase db);
    QueryResult executeTransaction(const std::function<QueryResult(QSqlDatabase&)>& action);
    static QSqlDatabase getConnection();
    static void releaseConnection(const QSqlDatabase& db);

private:
    pgpool(); // 构造函数私有化
    static pgpool *m_instance;
    static QList<QSqlDatabase> freeConnections;
    static QList<QSqlDatabase> usedConnections;
    static QMutex mutex;
    static int lastConnectionId;

    static QString host;
    static int port;
    static QString dbName;
    static QString user;
    static QString password;

    void loadConfiguration();

signals:
    void dbConnecting(bool success);
};

#endif // PGPOOL_H
