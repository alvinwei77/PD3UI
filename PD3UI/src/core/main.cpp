#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QTranslator>
#include <QQmlContext>
#include "ServiceLocator.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    ServiceLocator::initializeApplication();
    Logger* logger = ServiceLocator::logger();

    if (!ServiceLocator::dbPool()->testConnectionAsync()) {
        // 数据库连接失败
        emit ServiceLocator::dbPool()->dbConnecting(false);
    }

    QCoreApplication::setOrganizationName("PD3");
    QCoreApplication::setApplicationName("PD3UI");
    QCoreApplication::setOrganizationDomain("pd3tech.com");
    

    QTranslator translator;
    const QStringList uiLanguages = QLocale::system().uiLanguages();
    for (const QString &locale : uiLanguages) {
        const QString baseName = "PD3UI_" + QLocale(locale).name();
        if (translator.load("./i18n/"+ baseName)) {
            app.installTranslator(&translator);
            break;
        }
    }

    QQmlApplicationEngine engine;
    // 将服务实例传递给 QML
    engine.rootContext()->setContextProperty("dbService", ServiceLocator::dbPool());


    const QUrl url(QStringLiteral("qrc:/App.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
