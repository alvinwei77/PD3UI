// testManager.h
#ifndef TESTMANAGER_H
#define TESTMANAGER_H

#include <QObject>
#include "../server/AsyncExecutor.h"
#include "../common/QueryInterface.h"

class TestManager : public QObject {
    Q_OBJECT

public:
    explicit TestManager(QObject *parent = nullptr);
    Q_INVOKABLE QVariantMap fetchData();
    Q_INVOKABLE QVariantMap fetchData(const QString &text, const int id);
    Q_INVOKABLE QVariantMap insertData(const QString &text, const int id);
    Q_INVOKABLE QVariantMap testData(const QString &text, const int id);

signals:
    void operationCompleted(bool success);
    void operationFailed(const QString &error);

private:
    AsyncTaskExecutor *taskExecutor;
};

#endif // TESTMANAGER_H
