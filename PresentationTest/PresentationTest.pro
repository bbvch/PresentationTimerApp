TEMPLATE = app

QT += testlib qml
CONFIG   += C++11
SOURCES += \
    ../PresentationApp/presentationtimer.cpp \
../PresentationApp/settings.cpp \
    testpresentationtimer.cpp \
    testsettings.cpp \
    main.cpp


#RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
#QML_IMPORT_PATH =

# Default rules for deployment.
#include(deployment.pri)

HEADERS += \
    ../PresentationApp/presentationtimer.h \
../PresentationApp/settings.h \
    testpresentationtimer.h \
    testsettings.h

INCLUDEPATH += ../PresentationApp/

# install
#target.path = ./presentationtest
#INSTALLS += target
