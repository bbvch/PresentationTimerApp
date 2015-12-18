#include <QtTest>
#include "settings.h"
#include "testsettings.h"


TestSettings::TestSettings(QObject *parent)
{
    Q_UNUSED(parent)
}

/* NOTE: This test function does directly use the methods and does not create an
 * Qtobject, while this is possible it is, in our opinion, inferior the the approach used
 * in the Presentationtimer test, as this bypasses the property methods and thus does not test
 * if the wrong functions were declared to be used by the property.
 */
void TestSettings::can_set_and_read_variables()
{
    Settings settings;
    settings.setPresentationTime(50);
    //QCOMPARE(settings.setThresholdAlarms(50,25),true);
    //QCOMPARE(settings.setAlarmTypes(true,false),true);
    settings.setAlarm1Type(true);
    settings.setAlarm2Type(true);
    settings.setFirstAlarmColor("blue");
    settings.setSecondAlarmColor("green");
    settings.setFirstAlarmValue(3621);
    settings.setSecondAlarmValue(3621);
    //QCOMPARE(settings.setAlarmColors("red","yellow"),true);

    QCOMPARE(settings.getPresentationTime(),50);
    //QCOMPARE(settings.getThresholdAlarms(),true);
    QCOMPARE(settings.getAlarm1Type(),true);
    QCOMPARE(settings.getAlarm2Type(),true);
    QCOMPARE(settings.getFirstAlarmColor(),QColor("blue"));
    QCOMPARE(settings.getSecondAlarmColor(),QColor("green"));
    QCOMPARE(settings.getFirstAlarmValue(),3621);
    QCOMPARE(settings.getSecondAlarmValue(),3621);
    //QCOMPARE(settings.getAlarmColors(),true);
}
//QTEST_MAIN(TestSettings)
