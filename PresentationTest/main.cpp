#include "testpresentationtimer.h"
#include "testsettings.h"

#include <QTest>
#include <QEventLoop>
#include <QCoreApplication>

int main(int argc, char *argv[])
{
    //These variables are needed for the persistent storage to work
    QCoreApplication::setOrganizationName("bbv Software Solutions AG");
    QCoreApplication::setOrganizationDomain("com.bbvSoftwareSolutions");
    QCoreApplication::setApplicationName("PresentationTimerAppTest");

    //QCoreApplication needed for timers to work
    QCoreApplication app(argc, argv);

    /*Execute the tests according to parameters
      This layout of using the tests is needed as the timers them selves need a proper
      context to run in, without this layout the timers will fail to run!
      If you don't have timers in your application the test setup can be easier. */
    int status = 0;
    auto ASSERT_TEST = [&status, argc, argv](QObject* obj) {
      status |= QTest::qExec(obj, argc, argv);
      delete obj;
    };

    /* List all test classes */
    ASSERT_TEST(new TestPresentationTimer());
    //ASSERT_TEST(new TestSettings());


    //Return overall success/failure
    return status;
}
