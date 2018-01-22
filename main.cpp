#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "Gesture.h"
#include "PostSignature.h"

int main(int argc, char *argv[])
{
#if defined(Q_OS_WIN)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    qmlRegisterType<Gesture>("com.swhitley.classes", 1, 0, "Gesture");

    QQmlApplicationEngine engine;
    PostSignature postSignature;

    engine.rootContext()->setContextProperty("postSignature", &postSignature);
    engine.load(QUrl(QStringLiteral("qrc:/QML/main.qml")));

    if(engine.rootObjects().isEmpty())
    {
        return -1;
    }

    return app.exec();
}
