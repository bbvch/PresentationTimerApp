#include "testsettings.h"
#include "settings.h"
#include <QtTest>


TestSettings::TestSettings(QObject *parent)
{

}

void TestSettings::can_set_and_read_variables()
{
    Settings settings;
    settings.setPresentationTime(50);
    //QCOMPARE(settings.setThresholdAlarms(50,25),true);
    //QCOMPARE(settings.setAlarmTypes(true,false),true);
    settings.setAlarm1Type(true);
    settings.setAlarm2Type(true);
    settings.setAlarm1Color("blue");
    settings.setAlarm2Color("green");
    settings.setAlarm1Value(3621);
    settings.setAlarm2Value(3621);
    //QCOMPARE(settings.setAlarmColors("red","yellow"),true);

    QCOMPARE(settings.getPresentationTime(),50);
    //QCOMPARE(settings.getThresholdAlarms(),true);
    QCOMPARE(settings.getAlarm1Type(),true);
    QCOMPARE(settings.getAlarm2Type(),true);
    QCOMPARE(settings.getAlarm1Color(),QColor("blue"));
    QCOMPARE(settings.getAlarm2Color(),QColor("green"));
    QCOMPARE(settings.getAlarm1Value(),3621);
    QCOMPARE(settings.getAlarm2Value(),3621);
    //QCOMPARE(settings.getAlarmColors(),true);
}
//QTEST_MAIN(TestSettings)
