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
    QCOMPARE(timer->setPresentationTime(10),true);
    QCOMPARE(timer->startTimer(),true);
    QTest::qWait(1200);
    //timer should have decreased/increased by one
    QCOMPARE(timer->getRemainingTime(),9);
    QCOMPARE(timer->getTime(),1);
    QCOMPARE(timer->stopTimer(),true);
    QTest::qWait(1200);
    //timer should have stopped
    QCOMPARE(timer->getRemainingTime(),9);
    QCOMPARE(timer->getTime(),1);
    QCOMPARE(timer->startTimer(),true);
    QTest::qWait(1200);
    //timer should have stopped
    QCOMPARE(timer->getRemainingTime(),8);
    QCOMPARE(timer->getTime(),2);
}

QTEST_MAIN(TestPresentationTimer)
//#include "testpresentationtimer.moc"

//#include "moc_testpresentationtimer.o"
