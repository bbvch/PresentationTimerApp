import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1

Window {
    id: rootWindow
    visible: true
    minimumHeight: 800
    minimumWidth:  480

    TimerView {
        id: timerView
        anchors.fill: parent
        durationValue: 10
    }
}

