#ifndef SERVICELOCATOR_H
#define SERVICELOCATOR_H

#include "./utils/Logger.h"
#include "./db/pgpool.h"
#include "./utils/ConfigManager.h"

class ServiceLocator {
public:

    static void initializeApplication() {
        ConfigManager* config = ConfigManager::instance();
        QString organizationName = config->getValue("System", "Organization", "PD3").toString();
        QString applicationName = config->getValue("System", "Application", "PD3UI").toString();
        QString Organization = config->getValue("System", "Organization", "pd3tech.com").toString();
        QCoreApplication::setOrganizationName(organizationName);
        QCoreApplication::setApplicationName(applicationName);
        QCoreApplication::setApplicationName(Organization);
    }

    static Logger* logger() {
        return Logger::instance();
    }

    static pgpool* dbPool() {
        return pgpool::instance();
    }

    static void cleanup() {
        delete Logger::instance();
        delete pgpool::instance();
    }

private:
    ConfigManager* config;
};

#endif // SERVICELOCATOR_H
