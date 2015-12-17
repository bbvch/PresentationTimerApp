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
    Q_PROPERTY(QColor alarm1Color READ getAlarm1Color WRITE setAlarm1Color NOTIFY alarm1ColorChanged)
    Q_PROPERTY(QColor alarm2Color READ getAlarm2Color WRITE setAlarm2Color NOTIFY alarm2ColorChanged)
    Q_PROPERTY(int alarm1Value READ getAlarm1Value WRITE setAlarm1Value NOTIFY alarm1ValueChanged)
    Q_PROPERTY(int alarm2Value READ getAlarm2Value WRITE setAlarm2Value NOTIFY alarm2ValueChanged)
    Q_PROPERTY(int presentationTime READ getPresentationTime WRITE setPresentationTime NOTIFY presentationTimeChanged)

public:
    explicit Settings(QObject *parent = 0);

signals:
    void alarm1TypeChanged(bool type);
    void alarm2TypeChanged(bool type);
    void alarm1ColorChanged(QColor color);
    void alarm2ColorChanged(QColor color);
    void alarm1ValueChanged(int value);
    void alarm2ValueChanged(int value);
    void presentationTimeChanged(int time);

public slots:
//    bool setThresholdAlarms(double alarm1, double alarm2);
//    bool setAlarmTypes(bool alarm1, bool alarm2);
//    bool setAlarmColors(QColor alarm1, QColor alarm2);
    void setAlarm1Type(bool);
    void setAlarm2Type(bool);
    void setAlarm1Color(QColor color);
    void setAlarm2Color(QColor color);
    void setAlarm1Value(int value);
    void setAlarm2Value(int value);
    void setPresentationTime(int time);
public:
    bool    getAlarm1Type();
    bool    getAlarm2Type();
    QColor  getAlarm1Color();
    QColor  getAlarm2Color();
    int     getAlarm1Value();
    int     getAlarm2Value();
    int     getPresentationTime();

private:
    QSettings* mSettings;
};

#endif // SETTINGS_H
