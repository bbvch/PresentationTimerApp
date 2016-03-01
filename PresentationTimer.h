#ifndef PRESENTATIONTIMER_H
#define PRESENTATIONTIMER_H

#include <QObject>

class QTimer;

class PresentationTimer : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isRunning     READ isRunning WRITE changeRunningState NOTIFY sigRunningChanged)
    Q_PROPERTY(int  duration      READ getDuration WRITE setDuration NOTIFY sigDurationChanged)
    Q_PROPERTY(int  attentionTime READ getAttentionTime WRITE setAttentionTime NOTIFY sigAttentionTimeChanged)
    Q_PROPERTY(int  finalTime     READ getFinalTime WRITE setFinalTime NOTIFY sigFinalTimeChanged)
    Q_PROPERTY(int  elapsedTime   READ getElapsedTime NOTIFY sigSecondsTick)
    Q_PROPERTY(int  remainingTime READ getRemainingTime() NOTIFY sigSecondsTick)
    Q_PROPERTY(int  remainingSec  READ getRemainingSec())
    Q_PROPERTY(int  remainingMin  READ getRemainingMin())
    Q_PROPERTY(int  remainingHour READ getRemainingHour())

public:
    explicit PresentationTimer(QObject *parent = 0);

signals:
    /** Signals a Yellow Alarm */
    void sigAlarmAttention();
    /** Signals a Red Alarm */
    void sigAlarmFinal();
    /** Signals that the state of the presentation changed*/
    void sigRunningChanged();
    /** Signals that the presentation time has changed */
    int sigDurationChanged();

    int sigAttentionTimeChanged();
    int sigFinalTimeChanged();

    /** Signals a Timer tick (aka. one Second */
    void sigSecondsTick();

public slots:
    /** Set time in seconds */
    bool setDuration(quint32 msTime);
    bool setAttentionTime(quint32 msTime);
    bool setFinalTime(quint32 msTime);
    bool setThresholdAlarms(quint32 attentionTime, quint32 finalTime);
    void start();
    void stop();
    void reset();

    /** change Running state, returns true if the Timer has now been started, false otherwise */
    bool changeRunningState(bool);

private slots:
    /** The slot for the internally used timer */
    quint32 timerTick();

public:
    /** get Current Time */
    quint32 getElapsedTime()   const;
    quint32 getRemainingTime() const;
    quint8  getRemainingSec()  const;
    quint8  getRemainingMin()  const;
    quint8  getRemainingHour() const;
    quint32 getDuration()      const;
    quint32 getAttentionTime() const;
    quint32 getFinalTime()     const;
    bool    isRunning() const;

private:
    QTimer* mTimer;
    quint32 mDuration;            /// the presentation time
    quint32 mElapsedTime;         /// the already elapsed time in 0.1s
    quint32 mAttentionTimeValue;  /// threshold/time at which to trigger yellow Alarm
    quint32 mFinalTimeValue;      /// threshold/time at which to trigger red Alarm
};

#endif // PRESENTATIONTIMER_H
