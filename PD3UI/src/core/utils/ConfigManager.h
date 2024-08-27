#ifndef CONFIGMANAGER_H
#define CONFIGMANAGER_H

#include <QSettings>
#include <QMutex>
#include <QString>
#include <QVariant>

class ConfigManager {
public:
    static ConfigManager* instance();

    QVariant getValue(const QString &group, const QString &key, const QVariant &defaultValue = QVariant()) const;
    void setValue(const QString &group, const QString &key, const QVariant &value);

private:
    ConfigManager();  // 构造函数私有化
    ~ConfigManager();

    static ConfigManager *m_instance;
    static QMutex m_mutex;
    QSettings *m_settings;
};

#endif // CONFIGMANAGER_H
