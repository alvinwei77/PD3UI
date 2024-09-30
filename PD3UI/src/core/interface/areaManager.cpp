#include "areaManager.h"
#include "../common/GlobalSqls.h"

AreaManager::AreaManager(QObject *parent) : QObject(parent) {
    taskExecutor = new AsyncTaskExecutor(this);
    connect(taskExecutor, &AsyncTaskExecutor::operationCompleted, this, &AreaManager::operationCompleted);
    connect(taskExecutor, &AsyncTaskExecutor::operationFailed, this, &AreaManager::operationFailed);
}

QVariantMap AreaManager::fetchArea(){
    QueryResult res = taskExecutor->execute([this](QSqlDatabase &db) -> QueryResult {
        QString queryStr = globalSqls::SELECT_TEST();
        return pgpool::instance()->executeQuery(queryStr, db);
    });
    return toVariantMap(res);
}
QVariantMap AreaManager::fetchAreaByID(int id){
    QueryResult res = taskExecutor->execute([this](QSqlDatabase &db) -> QueryResult {
        QString queryStr = globalSqls::SELECT_TEST();
        return pgpool::instance()->executeQuery(queryStr, db);
    });
    return toVariantMap(res);
}
