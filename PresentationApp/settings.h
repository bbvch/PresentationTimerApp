#ifndef SETTINGS_H
#define SETTINGS_H

#include <QColor>
#include <QObject>
#include <QSettings>

class Settings : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool alarm1Type READ getAlarm1Type WRITE setAlarm1Type NOTIFY alarm1TypeChanged)
    Q_PROPERTY(bool alarm2Type READ getAlarm2Type WRITE setAlarm2Type NOTIFY alarm2TypeChanged)

public:
    explicit Settings(QObject *parent = 0);
    ~Settings();

signals:
    void alarm1TypeChanged(bool type);
    void alarm2TypeChanged(bool type);

public slots:
    bool setPresentationTime(int time);
    bool setThresholdAlarms(double alarm1, double alarm2);
    bool setAlarmTypes(bool alarm1, bool alarm2);
    bool setAlarmColors(QColor alarm1, QColor alarm2);
public:
    bool getAlarm1Type();
    void setAlarm1Type(bool);
    bool getAlarm2Type();
    void setAlarm2Type(bool);

private:
    QSettings* mSettings;
};

#endif // SETTINGS_H
