#include <QTimer>
#include <QDebug>

#include "presentationtimer.h"


PresentationTimer::PresentationTimer(QObject *parent)
    : QObject(parent),
      mTimer(new QTimer(parent)),
      mPresentationTime(0),
      mYellowTimeValue(50),
      mRedTimeValue(25), mYellowType(false),
      mRedType(false)
{
    mTimer->setInterval(1000);
    mTimer->setSingleShot(false);

    QObject::connect( mTimer, SIGNAL(timeout()), this, SLOT(timerTick()) );
}

int PresentationTimer::getTime()
{
    return mElapsedTime;
}

int PresentationTimer::getRemainingTime()
{
    return mPresentationTime - mElapsedTime;
}

int PresentationTimer::getPresentationTime()
{
    return mPresentationTime;
}

bool PresentationTimer::isRunning()
{
    return mTimer->isActive();
}

bool PresentationTimer::setPresentationTime(int time)
{
    if(time<=0)
        return false;

    mPresentationTime = time;
    mElapsedTime = 0;

    return true;

}

bool PresentationTimer::setThresholdAlarms(double yellowTime, double redTime)
{
    if((yellowTime<redTime) || (redTime<0))
        return false;

    mYellowTimeValue = yellowTime;
    mRedTimeValue    = redTime;

    return true;
}

bool PresentationTimer::setAlarmTypes(bool yellowType, bool redType)
{
    mYellowType = yellowType;
    mRedType    = redType;

    return true;
}

bool PresentationTimer::startTimer()
{
    if(mElapsedTime>=mPresentationTime)
        return false;

    if(!mTimer->isActive()) {
        mTimer->start();
        emit runningChanged();
    }

    return true;
}

bool PresentationTimer::stopTimer()
{
    if(mElapsedTime>=mPresentationTime)
        return false;

    if( mTimer->isActive() )
    {
        mTimer->stop();
        emit runningChanged();
    }

    return true;
}

bool PresentationTimer::changeRunningState(bool)
{
    if(mTimer->isActive())
        stopTimer();
    else
        return startTimer();

    return false;
}

int PresentationTimer::timerTick()
{
    // qDebug("Timer tick");
    if( mElapsedTime < mPresentationTime)
    {
        ++mElapsedTime;
        emit presentationTimerTick();
    }
    else
    {
        mTimer->stop();
        emit runningChanged();
    }


    //if this is a time alarm
    if(mRedType)
    {
        if( getRemainingTime() <= mRedTimeValue )
        {
            emit alarmRed();
            return mElapsedTime;
        }
    }
    else
    {
        if( ((1-1.0*mElapsedTime/mPresentationTime)) <= (mRedTimeValue/100.0) )
        {
            emit alarmRed();
            return mElapsedTime;
        }
    }

    if(mYellowType)
    {
        if( getRemainingTime() <= mYellowTimeValue )
            emit alarmYellow();
    }
    else
    {
        if( (1-(1.0*mElapsedTime/mPresentationTime)) <= (mYellowTimeValue/100.0) )
            emit alarmYellow();
    }

    return mElapsedTime;

}


