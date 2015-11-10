#include "presentationtimer.h"
#include <QTimer>
#include <QDebug>

PresentationTimer::PresentationTimer(QObject *parent) : QObject(parent), mPresentationTime(0), mYellow(50), mRed(25)
{
    mTimer = new QTimer(parent);
    mTimer->setInterval(1000);
    mTimer->setSingleShot(false);
    QObject::connect(mTimer,SIGNAL(timeout()),this,SLOT(timerTick()));
}

PresentationTimer::~PresentationTimer()
{
    delete mTimer;
}

bool PresentationTimer::setPresentationTime(int time)
{
    if(time<=0)
        return false;

    mPresentationTime=time;
    mTime=0;

    return true;

}

bool PresentationTimer::setThresholdAlarms(double yellow, double red)
{
    if((yellow<red)||(red<0))
        return false;
    mYellow=yellow;
    mRed=red;
    return true;
}

bool PresentationTimer::startTimer()
{
    if(mTime>=mPresentationTime)
        return false;
if(!mTimer->isActive()) {
    mTimer->start();
    emit runningChanged();
}
    return true;
}

bool PresentationTimer::stopTimer()
{
    if(mTime>=mPresentationTime)
        return false;
    if(mTimer->isActive()) {
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
        if(startTimer())
            return true;

    return false;
}

int PresentationTimer::timerTick()
{
    // qDebug("Timer tick");
    if(mTime<mPresentationTime) {
        mTime+=1;
        emit presentationTimerTick();
    }
    else {
        mTimer->stop();
        emit runningChanged();
    }
   // qDebug() << "Internal timer tick";

    if(((1-1.0*mTime/mPresentationTime))<=(mRed/100.0))
        emit alarmRed();
    else     if((1-(1.0*mTime/mPresentationTime))<=(mYellow/100.0))
        emit alarmYellow();

    return mTime;

}

int PresentationTimer::getTime()
{
    return mTime;
}

int PresentationTimer::getRemainingTime()
{
    return mPresentationTime-mTime;
}

int PresentationTimer::getPresentationTime()
{
    return mPresentationTime;
}

bool PresentationTimer::isRunning()
{
    return mTimer->isActive();
}

