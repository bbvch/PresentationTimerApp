TEMPLATE = app

QT += testlib qml
SOURCES += \
    ../PresentationApp/presentationtimer.cpp \
    testpresentationtimer.cpp


#RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
#QML_IMPORT_PATH =

# Default rules for deployment.
#include(deployment.pri)

HEADERS += \
    ../PresentationApp/presentationtimer.h \
    testpresentationtimer.h

INCLUDEPATH += ../PresentationApp/

# install
#target.path = ./presentationtest
#INSTALLS += target
