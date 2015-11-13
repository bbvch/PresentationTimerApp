#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include <QQmlContext>

#include <QDebug>

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

    QCoreApplication::setOrganizationName("bbv Software Solutions AG");
    QCoreApplication::setOrganizationDomain("com.bbvSoftwareSolutions");
    QCoreApplication::setApplicationName("PresentationTimerApp");

#ifdef Q_OS_ANDROID
    keepScreenOn();
#endif
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    PresentationTimer presentationTimer;
    Settings settings;
    engine.rootContext()->setContextProperty("cppPresentationTimer", &presentationTimer);
    engine.rootContext()->setContextProperty("cppSettings", &settings);
//qDebug() << "Now color is: "+settings.getAlarm1Color();
    if(settings.getAlarm1Color()==QColor(""))
    {
        settings.setAlarm1Color(QColor("yellow"));
        settings.setAlarm1Type(false);
        settings.setAlarm1Value(50);
        settings.setAlarm2Color(QColor("red"));
        settings.setAlarm2Type(false);
        settings.setAlarm2Value(25);
        settings.setPresentationTime(10);
    }

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();

}
