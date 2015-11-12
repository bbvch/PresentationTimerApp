#include "testsettings.h"
#include "settings.h"
#include <QtTest>


TestSettings::TestSettings(QObject *parent)
{

}

void TestSettings::can_set_and_read_variables()
{
    Settings settings;
    QCOMPARE(settings.setPresentationTime(50),true);
    QCOMPARE(settings.setThresholdAlarms(50,25),true);
    QCOMPARE(settings.setAlarmTypes(true,false),true);
    QCOMPARE(settings.setAlarmColors("red","yellow"),true);
}
//QTEST_MAIN(TestSettings)
