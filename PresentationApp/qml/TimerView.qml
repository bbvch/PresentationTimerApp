import QtQuick 2.5
import QtQuick.Layouts 1.1

Rectangle {
    id: timerWindow
    property  int durationValue: 0
    visible: true


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
        }

        ButtonControl {
            id: buttonControl
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height/12

            onStartClicked: {
                timerRect.deselectAll()
                circleItem.animation.restart()
                cppPresentationTimer.start()
            }

            onPauseClicked: {
                timerRect.deselectAll()
                if(circleItem.running)
                    circleItem.animation.pause()
                cppPresentationTimer.stop()
            }

            onResumeClicked: {
                timerRect.deselectAll()
                circleItem.animation.resume()
                cppPresentationTimer.start()
            }

            onResetClicked: {
                timerRect.deselectAll()
                circleItem.reset()
                timerRect.background = cppSettings.normalColor
                cppPresentationTimer.reset()
                setTimeLabels()
                buttonControl.reset()
            }
        }
    } // ColumnLayout

    Connections {
        target: cppPresentationTimer

        onSigSecondsTick: {
            setTimeLabels()
        }

        onSigAlarmAttention: {
            if(cppPresentationTimer.isRunning)
                timerRect.background = cppSettings.attentionColor
        }

        onSigAlarmFinal: {
            if(cppPresentationTimer.isRunning)
                timerRect.background= cppSettings.finalColor
        }
    } // Connections

    function setTimeLabels()
    {
        timerRect.secItem    = cppPresentationTimer.remainingSec
        timerRect.minItem    = cppPresentationTimer.remainingMin
        timerRect.hourItem   = cppPresentationTimer.remainingHour
    }

    function pause()
    {
        buttonControl.pauseClicked()
        buttonControl.updateButtons()
    }
}

