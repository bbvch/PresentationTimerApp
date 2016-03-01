#include <QString>
#include "PresentationSettings.h"

const QString PresentationSettings::SETTING_KEYS[6] = {"NORMAL_COLOR", "ATTENTION_COLOR", "FINAL_COLOR", "DURATION", "ATTENTION_TIME", "FINAL_TIME"};

PresentationSettings::PresentationSettings(QObject* parent):
    QSettings(parent)
{}

QColor PresentationSettings::getNormalColor() const
{
    return value(SETTING_KEYS[SK_NORMAL_COLOR], QColor("limegreen")).value<QColor>();
}

QColor PresentationSettings::getAttentionAlarmColor() const
{
    return value(SETTING_KEYS[SK_ATTENTION_COLOR], QColor("yellow")).value<QColor>();
}

QColor PresentationSettings::getFinaleAlarmColor() const
{
    return value(SETTING_KEYS[SK_FINAL_COLOR], QColor("red")).value<QColor>();
}

quint32 PresentationSettings::getAttentionTime() const
{
    return value(SETTING_KEYS[SK_ATTENTION_TIME], 600000).toUInt(); // 10min in ms
}

quint32 PresentationSettings::getFinalTime() const
{
    return value(SETTING_KEYS[SK_FINAL_TIME], 300000).toUInt(); // 5min in ms
}

quint32 PresentationSettings::getDuration() const
{
    return value(SETTING_KEYS[SK_DURATION], 2100000).toUInt(); // 35min in ms
}

void PresentationSettings::setNormalColor(QColor color)
{
    setValue(SETTING_KEYS[SK_NORMAL_COLOR], color);
}

void PresentationSettings::setAttentionAlarmColor(QColor color)
{
    setValue(SETTING_KEYS[SK_ATTENTION_COLOR], color);
}

void PresentationSettings::setFinalAlarmColor(QColor color)
{
    setValue(SETTING_KEYS[SK_FINAL_COLOR], color);
}

void PresentationSettings::setAttentionTime(quint32 msTime)
{
    setValue(SETTING_KEYS[SK_ATTENTION_TIME], msTime);
}

void PresentationSettings::setFinalTime(quint32 msTime)
{
    setValue(SETTING_KEYS[SK_FINAL_TIME], msTime);
}

void PresentationSettings::setDuration(quint32 msTime)
{
    setValue(SETTING_KEYS[SK_DURATION], msTime);
}

