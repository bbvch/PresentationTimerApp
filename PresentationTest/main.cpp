#include "testpresentationtimer.h"
#include "testsettings.h"

#include <QTest>
#include <QEventLoop>
#include <QCoreApplication>

int main(int argc, char *argv[])
{
    //QCoreApplication needed for timers to work
    QCoreApplication app(argc, argv);

    int status = 0;
    auto ASSERT_TEST = [&status, argc, argv](QObject* obj) {
      status |= QTest::qExec(obj, argc, argv);
      delete obj;
    };

    ASSERT_TEST(new TestSettings());
    ASSERT_TEST(new TestPresentationTimer());

    return status;
}
