TEMPLATE = app

QT += qml quick

SOURCES += main.cpp \
    presentationtimer.cpp \
    settings.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

DISTFILES += \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat \
    AlarmSettings.qml \
    resources/btn_time.png \
    resources/btn_percentage.png \
    ToggleButtonAlarmType.qml

contains(ANDROID_TARGET_ARCH,armeabi-v7a) {
QT += androidextras
ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
}


HEADERS += \
    presentationtimer.h \
    settings.h
