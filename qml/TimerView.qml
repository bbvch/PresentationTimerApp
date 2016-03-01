import QtQuick 2.5
import QtQuick.Layouts 1.1

Rectangle {
    id: timerWindow
    property  int durationValue: 0

    ColumnLayout {
        id: colLayout
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20

        TimerRect {
            id: timerRect
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "green"
            radius: 10

            LoadCircle {
                id: circleItem
                anchors.centerIn: parent
            }

            Component.onCompleted: secItem = timeValue;
        }

        ButtonControl {
            id: buttonControl
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height/12

            onStartClicked: {
                circleItem.animation.restart()
                presentationTimer.start()
            }

            onPauseClicked: {
                circleItem.animation.pause()
                presentationTimer.stop()
            }

            onResumeClicked: {
                circleItem.animation.resume()
                presentationTimer.start()
            }

            onResetClicked: {
                circleItem.animation.stop()
                circleItem.reset()
                presentationTimer.stop()
                timeValue = 4
                timerRect.secItem =  timeValue
                buttonControl.reset()
            }
        }
    } // ColumnLayout

    Timer {
        id: presentationTimer
        interval: 1000 //ms
        repeat: true

        onTriggered: {
            if(timeValue > 0) {
                --timeValue
                timerRect.secItem =  timeValue
            }
            else {
                presentationTimer.stop()
                timeValue = 4
                timerRect.secItem =  timeValue
                circleItem.reset()
                buttonControl.reset()
            }
        }
    }
}

