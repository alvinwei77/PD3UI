#include "ConfigManager.h"

ConfigManager* ConfigManager::m_instance = nullptr;
QMutex ConfigManager::m_mutex;

ConfigManager::ConfigManager() {
    m_settings = new QSettings("config.ini", QSettings::IniFormat);
}

ConfigManager::~ConfigManager() {
    delete m_settings;
}

ConfigManager* ConfigManager::instance() {
    if (!m_instance) {
        QMutexLocker locker(&m_mutex);
        if (!m_instance) {
            m_instance = new ConfigManager();
        }
    }
    return m_instance;
}

QVariant ConfigManager::getValue(const QString &group, const QString &key, const QVariant &defaultValue) const {
    m_settings->beginGroup(group);
    QVariant value = m_settings->value(key, defaultValue);
    m_settings->endGroup();
    return value;
}

void ConfigManager::setValue(const QString &group, const QString &key, const QVariant &value) {
    m_settings->beginGroup(group);
    m_settings->setValue(key, value);
    m_settings->endGroup();
    m_settings->sync();  // 强制写入到配置文件
}
