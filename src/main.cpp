#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QIcon>

#include "theme.h"
#include "session.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    app.setWindowIcon(QIcon("/usr/share/pixmaps/russiannationalanthem.png"));

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    qmlRegisterType<Theme>("Theme", 1, 0, "Theme");
    qmlRegisterType<Session>("Session", 1, 0, "Session");

    engine.load(url);
    return app.exec();
}
