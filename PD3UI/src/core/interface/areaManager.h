#ifndef AREAMANAGER_H
#define AREAMANAGER_H

#include <QObject>
#include "../server/AsyncExecutor.h"
#include "../common/QueryInterface.h"

class AreaManager: public QObject {
    Q_OBJECT

public:
    explicit AreaManager(QObject *parent = nullptr);
    Q_INVOKABLE QVariantMap fetchArea();
    Q_INVOKABLE QVariantMap fetchAreaByID(int id);

signals:
    void operationCompleted(bool success);
    void operationFailed(const QString &error);

private:
    AsyncTaskExecutor *taskExecutor;
};

#endif // AREAMANAGER_H
