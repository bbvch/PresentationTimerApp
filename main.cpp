#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#ifdef Q_OS_ANDROID
#include <QtAndroidExtras>
#endif

#include "PresentationTimer.h"
#include "PresentationSettings.h"

#ifdef Q_OS_ANDROID

void keepScreenOn()
{
    QAndroidJniObject activity = QtAndroid::androidActivity();
    if (activity.isValid()) {
        QAndroidJniObject window = activity.callObjectMethod("getWindow", "()Landroid/view/Window;");
        //   qDebug() << "Activity is valid";
        if (window.isValid()) {
            //qDebug() << "Window is valid";
            const int FLAG_KEEP_SCREEN_ON = 128;
            //const int FLAG_KEEP_SCREEN_ON = 1024; //1024 = make Fullscreen
            window.callObjectMethod("addFlags", "(I)Landroid/content/Intent", FLAG_KEEP_SCREEN_ON);
            qDebug() << "Set KEEPSCREENON flag";
        }
    }
}
#endif

int main(int argc, char *argv[])
{
    /* Set organization information for persistent Settings */
    QCoreApplication::setOrganizationName("bbv Software Solutions AG");
    QCoreApplication::setOrganizationDomain("com.bbvSoftwareSolutions");
    QCoreApplication::setApplicationName("PresentationTimerApp");

#ifdef Q_OS_ANDROID
    keepScreenOn();
#endif

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

