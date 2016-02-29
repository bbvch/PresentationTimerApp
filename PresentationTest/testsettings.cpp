#include <QtTest>
#include "PresentationSettings.h"
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
    PresentationSettings settings;
    settings.setDuration(50);
    //QCOMPARE(settings.setThresholdAlarms(50,25),true);
    //QCOMPARE(settings.setAlarmTypes(true,false),true);
    settings.setAttentionAlarmColor("blue");
    settings.setFinalAlarmColor("green");
    settings.setAttentionTime(3621);
    settings.setFinalTime(3621);
    //QCOMPARE(settings.setAlarmColors("red","yellow"),true);

    QCOMPARE(settings.getDuration(), (quint32)50);
    //QCOMPARE(settings.getThresholdAlarms(),true);
    QCOMPARE(settings.getAttentionAlarmColor(),QColor("blue"));
    QCOMPARE(settings.getFinaleAlarmColor(),QColor("green"));
    QCOMPARE(settings.getAttentionTime(), (quint32)3621);
    QCOMPARE(settings.getFinalTime(), (quint32)3621);
    //QCOMPARE(settings.getAlarmColors(),true);
}
//QTEST_MAIN(TestSettings)
