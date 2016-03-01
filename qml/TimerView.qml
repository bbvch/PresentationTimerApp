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
            color: cppSettings.normalColor
            radius: 10

            LoadCircle {
                id: circleItem
                anchors.centerIn: parent
                loadtimer: durationValue
            }

            Component.onCompleted: secItem = durationValue;
        }

        ButtonControl {
            id: buttonControl
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height/12

            onStartClicked: {
                timerRect.deselectAll()
                circleItem.animation.restart()
                presentationTimer.start()
            }

            onPauseClicked: {
                timerRect.deselectAll()
                if(circleItem.running)
                    circleItem.animation.pause()
                presentationTimer.stop()
            }

            onResumeClicked: {
                timerRect.deselectAll()
                circleItem.animation.resume()
                presentationTimer.start()
            }

            onResetClicked: {
                timerRect.deselectAll()
                circleItem.reset()
                timerRect.background = cppSettings.normalColor
                presentationTimer.stop()
                presentationTimer.timeValue = durationValue
                timerRect.secItem =  presentationTimer.timeValue
                buttonControl.reset()
            }
        }
    } // ColumnLayout

    Timer {
        id: presentationTimer
        property int timeValue: 0
        interval: 1000 //ms
        repeat: true

        onTriggered: {
            if(timeValue > 0) {
                --timeValue
                timerRect.secItem =  timeValue
            }
            else {
                presentationTimer.stop()
                timeValue = durationValue
                timerRect.secItem =  timeValue
                circleItem.reset()
                buttonControl.reset()
            }
        }
    }

    onDurationValueChanged: {
        presentationTimer.timeValue = durationValue
        circleItem.loadtimer = durationValue*1000 // in ms
    }
}

