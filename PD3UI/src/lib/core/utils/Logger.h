#ifndef LOGGER_H
#define LOGGER_H

#include <QFile>
#include <QTextStream>
#include <QDebug>
#include <QDateTime>
#include "./ConfigManager.h"

class Logger {
public:
    static Logger* instance();  // 获取单例实例
    ~Logger();

    static void messageHandler(QtMsgType type, const QMessageLogContext &context, const QString &msg);

private:
    Logger();  // 构造函数私有化
    static Logger* m_instance;  // 静态单例实例
    static QFile logFile;

    static const QString DEFAULT_LOG_FILE_PATH;  // 默认日志文件路径
    static const QString CONFIG_GROUP;           // 配置组名
    static const QString CONFIG_KEY_LOG_FILE;    // 配置键名

    void loadConfiguration();  // 加载配置
};

#endif // LOGGER_H
