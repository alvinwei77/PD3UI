#include "AsyncExecutor.h"
#include <QDebug>

AsyncTaskExecutor::AsyncTaskExecutor(QObject *parent) : QObject(parent) {
    connect(this, &AsyncTaskExecutor::operationCompleted, this, [](bool success) {
        if (success) {
            qDebug() << "Operation completed successfully.";
        } else {
            qDebug() << "Operation failed.";
        }
    });
}
