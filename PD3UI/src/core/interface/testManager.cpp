#include "testManager.h"
#include "../db/pgpool.h"
#include "../common/GlobalSqls.h"

TestManager::TestManager(QObject *parent) : QObject(parent) {
    taskExecutor = new AsyncTaskExecutor(this);
    connect(taskExecutor, &AsyncTaskExecutor::operationCompleted, this, &TestManager::operationCompleted);
    connect(taskExecutor, &AsyncTaskExecutor::operationFailed, this, &TestManager::operationFailed);
}

QVariantMap TestManager::fetchData() {
    QueryResult res = taskExecutor->execute([this](QSqlDatabase &db) -> QueryResult {
        QString queryStr = globalSqls::SELECT_TEST();
        QueryResult res= pgpool::instance()->executeQuery(queryStr, db);
        return res;
    });
    return toVariantMap(res);
}

QVariantMap TestManager::fetchData(const QString &text, const int id) {
    QueryResult res = taskExecutor->execute([=](QSqlDatabase &db) -> QueryResult {
        QString queryStr = globalSqls::SELECT_TEST_BY_ID(id);
        QueryResult res= pgpool::instance()->executeQuery(queryStr, db);
        return res;
    });
    return toVariantMap(res);
}

QVariantMap TestManager::insertData(const QString &text, const int id){
    QueryResult res = taskExecutor->execute([=](QSqlDatabase &db) -> QueryResult {
        QString queryStr = globalSqls::INSERT_TEST(text, id);
        QueryResult res= pgpool::instance()->executeQuery(queryStr, db);
        return res;
    });
    return toVariantMap(res);
}

QVariantMap TestManager::testData(const QString &text, const int id) {
    QueryResult res = taskExecutor->execute([=](QSqlDatabase &db) -> QueryResult {
        QString queryStr = globalSqls::INSERT_TEST(text, id);
        QueryResult res= pgpool::instance()->executeQuery(queryStr, db);
        return res;
    });
    return toVariantMap(res);
}

QVariantMap TestManager::initData() {
    QueryResult res = taskExecutor->execute([=](QSqlDatabase &db) -> QueryResult {
        QString queryStr = globalSqls::INIT_DB();
        QueryResult res= pgpool::instance()->executeQuery(queryStr, db);
        return res;
    });
    return toVariantMap(res);
}


