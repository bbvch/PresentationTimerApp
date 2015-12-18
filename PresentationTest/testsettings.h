#ifndef TESTSETTINGS_H
#define TESTSETTINGS_H

#include <QObject>

class TestSettings : public QObject
{
    Q_OBJECT
public:
    explicit TestSettings(QObject *parent = 0);

private slots:
    //! Test if we can set and read variables from the persistent settings
    void can_set_and_read_variables();
};

#endif // TESTSETTINGS_H
