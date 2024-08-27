#ifndef ASYNCTASKEXECUTOR_H
#define ASYNCTASKEXECUTOR_H

#include <QObject>
#include <QFuture>
#include <QFutureWatcher>
#include <QEventLoop>
#include <QtConcurrent/QtConcurrentRun>
#include "../db/pgpool.h"

class AsyncTaskExecutor : public QObject {
    Q_OBJECT
public:
    AsyncTaskExecutor(QObject *parent = nullptr);
    template<typename Func>
    static QueryResult execute(Func function);

// private:
//     AsyncTaskExecutor() = delete; // 禁止实例化

signals:
    void operationCompleted(bool success);
    void operationFailed(const QString &error);
};

// 模板方法定义在头文件中
template<typename Func>
QueryResult AsyncTaskExecutor::execute(Func function) {
    QFuture<QueryResult> future = QtConcurrent::run([function]() -> QueryResult {
        return pgpool::instance()->executeTransaction(function);
    });

    QFutureWatcher<QueryResult> watcher;
    QEventLoop loop;

    connect(&watcher, &QFutureWatcher<QueryResult>::finished, &loop, &QEventLoop::quit);
    watcher.setFuture(future);
    loop.exec();

    QueryResult result = future.result();
    return result;
}

#endif // ASYNCTASKEXECUTOR_H
