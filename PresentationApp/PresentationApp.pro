TEMPLATE = app

QT += qml quick
CONFIG += c++11

SOURCES += main.cpp \
    PresentationTimer.cpp \
    PresentationSettings.cpp

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
	android/gradlew.bat


contains(ANDROID_TARGET_ARCH,armeabi-v7a) {
QT += androidextras
ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
}


HEADERS += \
    PresentationTimer.h \
    PresentationSettings.h

