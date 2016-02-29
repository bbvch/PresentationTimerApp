#include "testpresentationtimer.h"
#include <QtTest>

TestPresentationTimer::TestPresentationTimer(QObject *parent) : QObject(parent)
{

}

/* HINT: use QSignalSpy to check if the signals are generated correctly,
 * e.g. QSignalSpy mySpy(object, SIGNAL(mySignal))
 *
 * HINT: Use QTest::qWait to time things
 */
void TestPresentationTimer::can_successfully_create_and_configure_Timer()
{
    PresentationTimer* timer = new PresentationTimer(this);
    QCOMPARE(timer->setDuration(10),true);
//    QCOMPARE(timer->getTime(),0);
    QCOMPARE(timer->getRemainingTime(), (quint32)10);
    QCOMPARE(timer->setDuration(-10),false);
    QCOMPARE(timer->setDuration(0),false);
    //Try setting some alarms
    QCOMPARE(timer->setThresholdAlarms(50,25),true);
    QCOMPARE(timer->setThresholdAlarms(50,50),true);
    QCOMPARE(timer->setThresholdAlarms(25,50),false);
    QCOMPARE(timer->setThresholdAlarms(0,0),true);
    QCOMPARE(timer->setThresholdAlarms(0,-1),false);
}

void TestPresentationTimer::start_and_stop_a_timer_will_do_so()
{
    PresentationTimer* timer = new PresentationTimer(this);
    QSignalSpy spyTick(timer, SIGNAL(presentationTimerTick()));
    QSignalSpy spyRunning(timer, SIGNAL(runningChanged()));
    QCOMPARE(timer->setDuration(10),true);
    QCOMPARE(timer->getDuration(), (quint32)10);
    timer->start();
    QTest::qWait(1200);
    //timer should have decreased/increased by one
    QCOMPARE(timer->getRemainingTime(), (quint32)9);
//    QCOMPARE(timer->getTime(),1);
    QCOMPARE(spyRunning.count(),1);
    QCOMPARE(timer->isRunning(),true);
    timer->stop();
    QCOMPARE(timer->isRunning(),false);
    QCOMPARE(spyTick.count(),1);
    QTest::qWait(1200);
    //timer should have stopped
    QCOMPARE(timer->getRemainingTime(), (quint32)9);
//    QCOMPARE(timer->getTime(),1);
    QCOMPARE(spyRunning.count(),2);
    //use change Running state this time to START the timer again
    QCOMPARE(timer->changeRunningState(true),true);
    QCOMPARE(timer->isRunning(),true);
    QCOMPARE(spyTick.count(),1);
    QTest::qWait(1200);
    //timer should have started again
    QCOMPARE(timer->getRemainingTime(), (quint32)8);
//    QCOMPARE(timer->getTime(),2);
    QCOMPARE(spyRunning.count(),3);
    QCOMPARE(spyTick.count(),2);
}

void TestPresentationTimer::percentage_alarms_are_being_signaled()
{
    PresentationTimer* timer = new PresentationTimer(this);
    QCOMPARE(timer->setDuration(4),true);
    QCOMPARE(timer->setThresholdAlarms(50,25),true);
    QSignalSpy spyYellow(timer, SIGNAL(alarmYellow()));
    QSignalSpy spyRed(timer, SIGNAL(alarmRed()));
    timer->start();
    QTest::qWait(1200);
    //no Alarms should have been triggered
    QCOMPARE(spyYellow.count(),0);
    QCOMPARE(spyRed.count(),0);
    //below 50% -> yellow
    QTest::qWait(1200);
    QCOMPARE(spyYellow.count(),1);
    QCOMPARE(spyRed.count(),0);
    spyYellow.clear();
    spyRed.clear();
    //below 25% -> red
    QTest::qWait(1200);
    QCOMPARE(spyYellow.count(),0);
    QCOMPARE(spyRed.count(),1);
}

void TestPresentationTimer::time_alarms_are_being_signaled()
{
    PresentationTimer* timer = new PresentationTimer(this);
    QCOMPARE(timer->setDuration(4),true);
    QCOMPARE(timer->setThresholdAlarms(2,1),true);
    QSignalSpy spyYellow(timer, SIGNAL(alarmYellow()));
    QSignalSpy spyRed(timer, SIGNAL(alarmRed()));
    timer->start();
    QTest::qWait(1200);
    //three seconds left -> no Alarms
    QCOMPARE(spyYellow.count(),0);
    QCOMPARE(spyRed.count(),0);
    QTest::qWait(1200);
    //two seconds left -> yellow
    QCOMPARE(spyYellow.count(),1);
    QCOMPARE(spyRed.count(),0);
    spyYellow.clear();
    spyRed.clear();
    QTest::qWait(1200);
    //one second left -> red
    QCOMPARE(spyYellow.count(),0);
    QCOMPARE(spyRed.count(),1);
}

