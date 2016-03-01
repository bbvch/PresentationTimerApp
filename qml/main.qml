import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1

Window {
    id: rootWindow
    property int timeValue: 4
    visible: true
    minimumHeight: 800
    minimumWidth:  480

    TimerView {
        id: timerView
        anchors.fill: parent
    }
}

