#include <QColor>
#include <QDebug>
#include <QSettings>
#include <QString>

#include "settings.h"

const QString ALARM1TYPE("ALARM1TYPE");
const QString ALARM2TYPE("ALARM2TYPE");
const QString ALARM1COLOR("ALARM1COLOR");
const QString ALARM2COLOR("ALARM2COLOR");
const QString ALARM1VALUE("ALARM1VALUE");
const QString ALARM2VALUE("ALARM2VALUE");
const QString ALARM1THRESHOLD("ALARM1THRESHOLD");
const QString ALARM2THRESHOLD("ALARM2THRESHOLD");
const QString PRESENTATIONTIME("PRESENTATIONTIME");

Settings::Settings(QObject *parent)
    : QObject(parent),
      mSettings(new QSettings)
{ }

void Settings::setFirstAlarmColor(QColor color)
{
    mSettings->setValue(ALARM1COLOR, color);
}

void Settings::setSecondAlarmColor(QColor color)
{
    mSettings->setValue(ALARM2COLOR, color);
}

void Settings::setFirstAlarmValue(int value)
{
    qDebug() << "Setting alarm value" + value;
    mSettings->setValue(ALARM1VALUE, value);
}

void Settings::setSecondAlarmValue(int value)
{
    mSettings->setValue(ALARM2VALUE, value);
}

void Settings::setPresentationTime(int time)
{
    mSettings->setValue(PRESENTATIONTIME, time);
    qDebug() << "Settings: presentation time changed";
}


QColor Settings::getFirstAlarmColor()
{
    return mSettings->value(ALARM1COLOR).value<QColor>();
}

QColor Settings::getSecondAlarmColor()
{
    return mSettings->value(ALARM2COLOR).value<QColor>();
}

int Settings::getFirstAlarmValue()
{
    return mSettings->value(ALARM1VALUE).toInt();
}

int Settings::getSecondAlarmValue()
{
    return mSettings->value(ALARM2VALUE).toInt();
}

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

