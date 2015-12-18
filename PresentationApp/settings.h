#ifndef SETTINGS_H
#define SETTINGS_H

#include <QColor>
#include <QObject>

class QSettings;

class Settings : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool alarm1Type READ getAlarm1Type WRITE setAlarm1Type NOTIFY alarm1TypeChanged)
    Q_PROPERTY(bool alarm2Type READ getAlarm2Type WRITE setAlarm2Type NOTIFY alarm2TypeChanged)
    Q_PROPERTY(QColor firstAlarmColor READ getFirstAlarmColor WRITE setFirstAlarmColor NOTIFY firstAlarmColorChanged)
    Q_PROPERTY(QColor secondAlarmColor READ getSecondAlarmColor WRITE setSecondAlarmColor NOTIFY secondAlarmColorChanged)
    Q_PROPERTY(int firstAlarmValue READ getFirstAlarmValue WRITE setFirstAlarmValue NOTIFY firstAlarmValueChanged)
    Q_PROPERTY(int secondAlarmValue READ getSecondAlarmValue WRITE setSecondAlarmValue NOTIFY secondAlarmValueChanged)
    Q_PROPERTY(int presentationTime READ getPresentationTime WRITE setPresentationTime NOTIFY presentationTimeChanged)

public:
    explicit Settings(QObject *parent = 0);

    bool    getAlarm1Type();
    bool    getAlarm2Type();
    QColor  getFirstAlarmColor();
    QColor  getSecondAlarmColor();
    int     getFirstAlarmValue();
    int     getSecondAlarmValue();
    int     getPresentationTime();

signals:
    void alarm1TypeChanged(bool type);
    void alarm2TypeChanged(bool type);
    void firstAlarmColorChanged(QColor color);
    void secondAlarmColorChanged(QColor color);
    void firstAlarmValueChanged(int value);
    void secondAlarmValueChanged(int value);
    void presentationTimeChanged(int time);

public slots:
    void setAlarm1Type(bool);
    void setAlarm2Type(bool);
    void setFirstAlarmColor(QColor color);
    void setSecondAlarmColor(QColor color);
    void setFirstAlarmValue(int value);
    void setSecondAlarmValue(int value);
    void setPresentationTime(int time);

private:
    QSettings* mSettings;
};

#endif // SETTINGS_H
