#include "settings.h"

#include <QColor>
#include <QString>

#include <QDebug>

const QString ALARM1TYPE("ALARM1TYPE");
const QString ALARM2TYPE("ALARM2TYPE");
const QString ALARM1COLOR("ALARM1COLOR");
const QString ALARM2COLOR("ALARM2COLOR");
const QString ALARM1VALUE("ALARM1VALUE");
const QString ALARM2VALUE("ALARM2VALUE");
const QString ALARM1THRESHOLD("ALARM1THRESHOLD");
const QString ALARM2THRESHOLD("ALARM2THRESHOLD");
const QString PRESENTATIONTIME("PRESENTATIONTIME");

Settings::Settings(QObject *parent) : QObject(parent)
{
    mSettings = new QSettings();
}

Settings::~Settings()
{
    delete mSettings;
}

void Settings::setAlarm1Color(QColor color)
{
    mSettings->setValue(ALARM1COLOR,color);
}

void Settings::setAlarm2Color(QColor color)
{
    mSettings->setValue(ALARM2COLOR,color);
}

void Settings::setAlarm1Value(int value)
{
qDebug() << "Setting alarm value"+value;
    mSettings->setValue(ALARM1VALUE,value);
}

void Settings::setAlarm2Value(int value)
{
    mSettings->setValue(ALARM2VALUE,value);
}

void Settings::setPresentationTime(int time)
{
    mSettings->setValue(PRESENTATIONTIME,time);
    qDebug() << "Settings: presentation time changed";
}


QColor Settings::getAlarm1Color()
{
    return mSettings->value(ALARM1COLOR).value<QColor>();
}

QColor Settings::getAlarm2Color()
{
    return mSettings->value(ALARM2COLOR).value<QColor>();
}

int Settings::getAlarm1Value()
{
    return mSettings->value(ALARM1VALUE).toInt();
}

int Settings::getAlarm2Value()
{
    return mSettings->value(ALARM2VALUE).toInt();
}

/*bool Settings::setThresholdAlarms(double alarm1, double alarm2)
{
return true;
}

bool Settings::setAlarmTypes(bool alarm1, bool alarm2)
{
mSettings->setValue(ALARM1TYPE,alarm1);
mSettings->setValue(ALARM2TYPE,alarm2);
}

bool Settings::setAlarmColors(QColor alarm1, QColor alarm2)
{
    mSettings->setValue(ALARM1COLOR,alarm1);
    mSettings->setValue(ALARM2COLOR,alarm2);
     }
*/
bool Settings::getAlarm1Type()
{
return mSettings->value(ALARM1TYPE).toBool();
}

void Settings::setAlarm1Type(bool type)
{
    mSettings->setValue(ALARM1TYPE,type);
}

bool Settings::getAlarm2Type()
{
return mSettings->value(ALARM2TYPE).toBool();
}

void Settings::setAlarm2Type(bool type)
{
    mSettings->setValue(ALARM2TYPE,type);
}

int Settings::getPresentationTime()
{
return mSettings->value(PRESENTATIONTIME).toInt();
}

