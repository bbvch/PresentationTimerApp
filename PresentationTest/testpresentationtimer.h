#ifndef TESTPRESENTATIONTIMER_H
#define TESTPRESENTATIONTIMER_H

#include <QtTest/QtTest>
#include <QObject>
#include "PresentationTimer.h"



class TestPresentationTimer : public QObject
{
    Q_OBJECT
public:
    explicit TestPresentationTimer(QObject *parent = 0);

private slots:
    //! Test if we can create and configure a timer
    void can_successfully_create_and_configure_Timer();
    void start_and_stop_a_timer_will_do_so();
    void percentage_alarms_are_being_signaled();
    void time_alarms_are_being_signaled();
};



#endif // TESTPRESENTATIONTIMER_H
