#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "Gesture.h"
#include "SignTimer.h"
#include "PostSignature.h"

int main(int argc, char *argv[])
{
#if defined(Q_OS_WIN)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    qmlRegisterType<Gesture>("com.swhitley.classes", 1, 0, "Gesture");
    qmlRegisterType<SignTimer>("com.swhitley.classes", 1, 0, "SignTimer");
    qmlRegisterType<PostSignature>("com.swhitley.classes", 1, 0, "PostSignature");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/QML/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
