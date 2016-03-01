#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "PresentationSettings.h"
#include "PresentationTimer.h"

int main(int argc, char *argv[])
{
    /* Set organization information for persistent Settings */
    QCoreApplication::setOrganizationName("bbv Software Solutions AG");
    QCoreApplication::setOrganizationDomain("com.bbvSoftwareSolutions");
    QCoreApplication::setApplicationName("PresentationTimerApp");


    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    //Create some objects that we're gonna use for the app
    PresentationSettings settings;
    PresentationTimer presentationTimer;

    //Let the qml know about our cpp-Objects
    engine.rootContext()->setContextProperty("cppSettings", &settings);
    engine.rootContext()->setContextProperty("cppPresentationTimer", &presentationTimer);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}

