
#include <QDateTime>
#include <QTime>
#include <QTimer>
#include <QDebug>

#include "PresentationTimer.h"

const int HOUR_IN_SEC = 3600;
const int MIN_IN_SEC  = 60;

PresentationTimer::PresentationTimer(QObject *parent)
    :QObject(parent),
    mTimer(new QTimer(parent)),
    mDuration(10000),
    mElapsedTime(0),
    mAttentionTimeValue(5000),
    mFinalTimeValue(2000)
{
    mTimer->setInterval(100);
    mTimer->setSingleShot(false);

    QObject::connect( mTimer, SIGNAL(timeout()), this, SLOT(timerTick()) );
}

quint32 PresentationTimer::getElapsedTime() const
{
    return mElapsedTime;
}

quint32 PresentationTimer::getRemainingTime() const
{
    return mDuration - mElapsedTime;
}

quint8 PresentationTimer::getRemainingSec() const
{
    int remainigTime = getRemainingTime()/1000;
    int second=remainigTime % HOUR_IN_SEC;
    second %= MIN_IN_SEC;

    return second;
}

quint8 PresentationTimer::getRemainingMin() const
{
    int remainigTime = getRemainingTime()/1000;
    int second=remainigTime % HOUR_IN_SEC;
    int minute=second/MIN_IN_SEC;

    return minute;
}

quint8 PresentationTimer::getRemainingHour() const
{
    int remainigTime = getRemainingTime()/1000;
    int hour=remainigTime/HOUR_IN_SEC;

    return hour;
}

quint32 PresentationTimer::getDuration() const
{
    return mDuration;
}

quint32 PresentationTimer::getAttentionTime() const
{
    return mAttentionTimeValue;
}

quint32 PresentationTimer::getFinalTime() const
{
    return mFinalTimeValue;
}

bool PresentationTimer::setDuration(quint32 msTime )
{
    mDuration    = msTime;
    mElapsedTime = 0;

    if(mAttentionTimeValue > mDuration)
        mAttentionTimeValue = 0;

    if(mFinalTimeValue > mDuration)
        mFinalTimeValue = 0;

    return true;
}

bool PresentationTimer::setAttentionTime(quint32 msTime)
{
    if( msTime < mFinalTimeValue )
        return false;

    mAttentionTimeValue = msTime;
    return true;
}

bool PresentationTimer::setFinalTime(quint32 msTime)
{
    if(msTime > mAttentionTimeValue)
        return false;

    mFinalTimeValue     = msTime;
    return true;
}

bool PresentationTimer::setThresholdAlarms(quint32 attentionTime, quint32 finalTime)
{
    if(attentionTime < finalTime)
        return false;

    mAttentionTimeValue = attentionTime;
    mFinalTimeValue     = finalTime;

    return true;
}

void PresentationTimer::start()
{
    if(!mTimer->isActive()) {
        mTimer->start();
        emit sigRunningChanged();
    }
}

void PresentationTimer::stop()
{
    if( mTimer->isActive() )
    {
        mTimer->stop();
        emit sigRunningChanged();
    }
}

void PresentationTimer::reset()
{
    if(mTimer->isActive())
    {
        mTimer->stop();
        emit sigRunningChanged();
    }

    mElapsedTime = 0;
}

bool PresentationTimer::isRunning() const
{
    return mTimer->isActive();
}

bool PresentationTimer::changeRunningState(bool)
{
    if(mTimer->isActive())
        stop();
    else
        start();

    return false;
}

quint32 PresentationTimer::timerTick()
{
    quint32 remainingTime = getRemainingTime();

    if( mElapsedTime < mDuration)
    {
        mElapsedTime += 100;

        if(mElapsedTime % 1000 == 0)
            emit sigSecondsTick();
    }
    else
    {
        mTimer->stop();
        emit sigRunningChanged();
    }

    if( remainingTime <= mAttentionTimeValue && remainingTime > mFinalTimeValue)
    {
        emit sigAlarmAttention();
    }
    else if( remainingTime <= mFinalTimeValue )
    {
        emit sigAlarmFinal();
    }

    return mElapsedTime;
}
