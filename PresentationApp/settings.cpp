#include "settings.h"

#include <QColor>
#include <QString>

const QString ALARM1TYPE("ALARM1TYPE");
const QString ALARM2TYPE("ALARM2TYPE");
const QString ALARM1COLOR("ALARM1COLOR");
const QString ALARM2COLOR("ALARM2COLOR");
const QString ALARM1THRESHOLD("ALARM1THRESHOLD");
const QString ALARM2THRESHOLD("ALARM2THRESHOLD");

Settings::Settings(QObject *parent) : QObject(parent)
{
    mSettings = new QSettings();
}

Settings::~Settings()
{
    delete mSettings;
}

bool Settings::setPresentationTime(int time)
{
return true;
}

bool Settings::setThresholdAlarms(double alarm1, double alarm2)
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

bool Settings::getAlarm1Type()
{
return mSettings->value(ALARM1TYPE).toBool();
}

void Settings::setAlarm1Type(bool value)
{
    mSettings->setValue(ALARM1TYPE,value);
}

bool Settings::getAlarm2Type()
{
return mSettings->value(ALARM2TYPE).toBool();
}

void Settings::setAlarm2Type(bool)
{
mSettings->setValue(ALARM2TYPE,value);
}

//Refactor to class ALARM
