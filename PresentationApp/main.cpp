#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include <QQmlContext>

#include <QDebug>
#include <QWindow>

#ifdef Q_OS_ANDROID
#include <QtAndroidExtras>
#endif

#include "presentationtimer.h"
#include "settings.h"

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

    //Create the app engine
    QQmlApplicationEngine engine;

    //Create some objects that we're gonna use for the app
    PresentationTimer presentationTimer;
    Settings settings;

    //Let the qml know about our cpp-Objects
    engine.rootContext()->setContextProperty("cppPresentationTimer", &presentationTimer);
    engine.rootContext()->setContextProperty("cppSettings", &settings);

    //Init the settings
    if(settings.getFirstAlarmColor()==QColor(""))
    {
        settings.setFirstAlarmColor(QColor("yellow"));
        settings.setAlarm1Type(false);
        settings.setFirstAlarmValue(50);
        settings.setSecondAlarmColor(QColor("red"));
        settings.setAlarm2Type(false);
        settings.setSecondAlarmValue(25);
        settings.setPresentationTime(10);
    }

    //Load the initial qml file
    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));

    //Start the app!
    return app.exec();

}
