#ifndef PRESENTATIONSETTINGS_H
#define PRESENTATIONSETTINGS_H

#include <QColor>
#include <QSettings>
#include <QString>

class PresentationSettings : public QSettings
{
    Q_OBJECT

public:
    explicit PresentationSettings(QObject *parent = 0);

    QColor  getNormalColor() const;
    QColor  getAttentionAlarmColor() const;
    QColor  getFinaleAlarmColor() const;
    quint32 getAttentionTime() const;
    quint32 getFinalTime() const;
    quint32 getDuration() const;

signals:
    void normalColorChanged(QColor color);
    void attentionAlarmColorChanged(QColor color);
    void finalAlarmColorChanged(QColor color);
    void attentionAlarmValueChanged(quint32 value);
    void finalAlarmValueChanged(quint32 value);
    void durationChanged(quint32 time);

public slots:
    void setNormalColor(QColor color);
    void setAttentionAlarmColor(QColor color);
    void setFinalAlarmColor(QColor color);
    void setAttentionTime(quint32 msTime);
    void setFinalTime(quint32 msTime);
    void setDuration(quint32 msTime);

private:
    enum SettingsKeys {
        SK_NORMAL_COLOR,
        SK_ATTENTION_COLOR,
        SK_FINAL_COLOR,
        SK_DURATION,
        SK_ATTENTION_TIME,
        SK_FINAL_TIME,
        __SK_COUNT
    };

    static const QString SETTING_KEYS[__SK_COUNT];
};

#endif // PRESENTATIONSETTINGS_H
