#ifndef PRESENTATIONTIMER_H
#define PRESENTATIONTIMER_H

#include <QObject>

class QTimer;

class PresentationTimer : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isRunning READ isRunning WRITE changeRunningState NOTIFY runningChanged)
    Q_PROPERTY(int presentationTime READ getPresentationTime WRITE setPresentationTime NOTIFY presentationTimeChanged)
    Q_PROPERTY(int time READ getTime NOTIFY presentationTimerTick)
    Q_PROPERTY(int remainingTime READ getRemainingTime() NOTIFY presentationTimerTick)

public:
    explicit PresentationTimer(QObject *parent = 0);

signals:
    /** Signals a Yellow Alarm */
    void alarmYellow();
    /** Signals a Red Alarm */
    void alarmRed();
    /** Signals a timer tick (aka. one Second) */
//    void tick();
    /** Signals that the state of the presentation changed*/
    void runningChanged();
    /** Signals that the presentation time has changed */
    int presentationTimeChanged();
    /** Signals a Timer tick (aka. one Second */
    void presentationTimerTick();

public slots:
    /** Set time in seconds */
    bool setPresentationTime(int time);
    bool setThresholdAlarms(double yellowTime, double red);
    bool setAlarmTypes(bool yellowType, bool redType);
    bool startTimer();
    bool stopTimer();
    /** change Running state, returns true if the Timer has now been started, false otherwise */
    bool changeRunningState(bool);

private slots:
    /** The slot for the internally used timer */
    int timerTick();

public:
    /** get Current Time */
    int getTime();
    int getRemainingTime();
    int getPresentationTime();
    bool isRunning();

private:
    QTimer* mTimer;
    int     mPresentationTime;  /// the presentation time
    int     mElapsedTime;       /// the already elapsed time
    double  mYellowTimeValue;   /// threshold/time at which to trigger yellow Alarm
    double  mRedTimeValue;      /// threshold/time at which to trigger red Alarm
    bool    mYellowType;        /// is a time threshold alarm? false=no, percentage, true=yes
    bool    mRedType;           /// is a time threshold alarm? false=no, percentage, true=yes
};

#endif // PRESENTATIONTIMER_H
