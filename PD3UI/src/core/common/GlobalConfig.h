#ifndef GLOBALCONFIG_H
#define GLOBALCONFIG_H

#include <QString>
#include <QVariant>
#include "../utils/ConfigManager.h"

class GlobalConfig {
public:
    static void loadConfig();

    static QString appName();
    static QString version();
    static bool isDebug();

private:
    static QString m_appName;
    static QString m_version;
    static bool m_isDebug;
};

#endif // GLOBALCONFIG_H
