#include "GlobalConfig.h"

QString GlobalConfig::m_appName;
QString GlobalConfig::m_version;
bool GlobalConfig::m_isDebug;

void GlobalConfig::loadConfig() {
    ConfigManager* config = ConfigManager::instance();

    m_appName = config->getValue("General", "appName", "DefaultApp").toString();
    m_version = config->getValue("General", "version", "1.0.0").toString();
    m_isDebug = config->getValue("General", "isDebug", false).toBool();
}

QString GlobalConfig::appName() {
    return m_appName;
}

QString GlobalConfig::version() {
    return m_version;
}

bool GlobalConfig::isDebug() {
    return m_isDebug;
}
