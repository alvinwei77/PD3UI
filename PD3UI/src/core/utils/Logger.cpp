#include "Logger.h"

Logger* Logger::m_instance = nullptr;
QFile Logger::logFile;

const QString Logger::DEFAULT_LOG_FILE_PATH = "pd3log.txt";  // 默认日志文件路径
const QString Logger::CONFIG_GROUP = "Log";                  // 配置组名
const QString Logger::CONFIG_KEY_LOG_FILE = "FilePath";      // 配置键名

Logger::Logger() {
    loadConfiguration();  // 加载配置
    if (!logFile.open(QIODevice::WriteOnly | QIODevice::Append)) {
        qDebug() << "无法打开日志文件：" << logFile.fileName();
    }
    qInstallMessageHandler(Logger::messageHandler);
}

Logger::~Logger() {
    if (logFile.isOpen()) {
        logFile.close();
    }
}

Logger* Logger::instance() {
    if (!m_instance) {
        m_instance = new Logger();  // 创建单例实例
    }
    return m_instance;
}

void Logger::messageHandler(QtMsgType type, const QMessageLogContext &context, const QString &msg) {
    QTextStream out(&logFile);
    out << QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm:ss.zzz ");

    switch (type) {
    case QtDebugMsg:
        out << "DEBUG: ";
        break;
    case QtInfoMsg:
        out << "INFO: ";
        break;
    case QtWarningMsg:
        out << "WARNING: ";
        break;
    case QtCriticalMsg:
        out << "CRITICAL: ";
        break;
    case QtFatalMsg:
        out << "FATAL: ";
        out << msg;
        abort();
    }

    out << context.category << ": " << msg << "\n";
    out.flush();
}

void Logger::loadConfiguration() {
    ConfigManager* config = ConfigManager::instance();

    // 从配置文件中读取日志文件路径，如果读取失败则使用默认值
    QString logFilePath = config->getValue(CONFIG_GROUP, CONFIG_KEY_LOG_FILE, DEFAULT_LOG_FILE_PATH).toString();

    // 设置日志文件路径
    logFile.setFileName(logFilePath);

    // 如果读取失败或使用默认值，写回配置文件
    config->setValue(CONFIG_GROUP, CONFIG_KEY_LOG_FILE, logFilePath);
}
