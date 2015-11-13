#include "testpresentationtimer.h"
#include <QtTest>

TestPresentationTimer::TestPresentationTimer(QObject *parent) : QObject(parent)
{

}

void TestPresentationTimer::can_successfully_create_and_configure_Timer()
{
    PresentationTimer* timer = new PresentationTimer(this);
    QCOMPARE(timer->setPresentationTime(10),true);
    QCOMPARE(timer->getTime(),0);
    QCOMPARE(timer->getRemainingTime(),10);
    QCOMPARE(timer->setPresentationTime(-10),false);
    QCOMPARE(timer->setPresentationTime(0),false);
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
    QCOMPARE(timer->setPresentationTime(10),true);
    QCOMPARE(timer->getPresentationTime(),10);
    QCOMPARE(timer->startTimer(),true);
    QTest::qWait(1200);
    //timer should have decreased/increased by one
    QCOMPARE(timer->getRemainingTime(),9);
    QCOMPARE(timer->getTime(),1);
    QCOMPARE(spyRunning.count(),1);
    QCOMPARE(timer->isRunning(),true);
    QCOMPARE(timer->stopTimer(),true);
    QCOMPARE(timer->isRunning(),false);
    QCOMPARE(spyTick.count(),1);
    QTest::qWait(1200);
    //timer should have stopped
    QCOMPARE(timer->getRemainingTime(),9);
    QCOMPARE(timer->getTime(),1);
    QCOMPARE(spyRunning.count(),2);
    //use change Running state this time to START the timer again
    QCOMPARE(timer->changeRunningState(true),true);
    QCOMPARE(timer->isRunning(),true);
    QCOMPARE(spyTick.count(),1);
    QTest::qWait(1200);
    //timer should have started again
    QCOMPARE(timer->getRemainingTime(),8);
    QCOMPARE(timer->getTime(),2);
    QCOMPARE(spyRunning.count(),3);
    QCOMPARE(spyTick.count(),2);
}

void TestPresentationTimer::alarms_are_being_signaled()
{
    PresentationTimer* timer = new PresentationTimer(this);
    QCOMPARE(timer->setPresentationTime(4),true);
    QCOMPARE(timer->setThresholdAlarms(50,25),true);
    QSignalSpy spyYellow(timer, SIGNAL(alarmYellow()));
    QSignalSpy spyRed(timer, SIGNAL(alarmRed()));
    QCOMPARE(timer->startTimer(),true);
    QTest::qWait(2200);
    QCOMPARE(spyYellow.count(),1);
    QCOMPARE(spyRed.count(),0);
    spyYellow.clear();
    spyRed.clear();
    QTest::qWait(1200);
    QCOMPARE(spyYellow.count(),0);
    QCOMPARE(spyRed.count(),1);
}

//QTEST_MAIN(TestPresentationTimer)
//#include "testpresentationtimer.moc"

//#include "moc_testpresentationtimer.o"