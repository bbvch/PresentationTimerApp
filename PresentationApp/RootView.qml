import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import QtQml 2.2

Item {
    id: rootView
    //anchors.fill: parent
    anchors.margins: 10
    //we are detecting states: stopped, running, paused
    state: "stopped"

    /*Rectangle {
        id: spacingRectangle
        anchors.top: parent.top
        anchors.bottom: rootView.verticalCenter
    }*/

    onStateChanged: console.log("New State:"+state)

    Item {
        id: timeInputs
       // anchors.centerIn: rootView
        z:1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.verticalCenter: rectangle.verticalCenter
        width: childrenRect.width
        anchors.centerIn: parent

        ColumnLayout {
            id: inputHours
            anchors.top: parent.verticalCenter
            z:1
            Label {
                id: labelHour
                text: qsTr("Hours")
               // anchors.top: parent.top
               // anchors.left: parent.left
            }

            TextInput {
                id: stopwatchHour
                text: "00"
                maximumLength: 2
                horizontalAlignment: Text.Center
                anchors.left:      parent.left
                anchors.right:     parent.right
                inputMethodHints:  Qt.ImhDigitsOnly
                KeyNavigation.tab: stopwatchMin
            }
        }

        ColumnLayout {
            id: inputMinutes
            anchors.leftMargin: 20
            anchors.left: inputHours.right
            anchors.top: inputHours.top
            z:1

            Label {
                id: labelMin
                text: qsTr("Minutes")
            }

            TextInput {
                id: stopwatchMin
                text: "00"
                horizontalAlignment: Text.Center
                maximumLength: 2
                anchors.left:      parent.left
                anchors.right:     parent.right
                inputMethodHints:  Qt.ImhDigitsOnly
                KeyNavigation.tab: stopwatchSec
            }
        }

        ColumnLayout {
            id: inputSeconds
            anchors.leftMargin: 20
            anchors.left: inputMinutes.right
            anchors.top:  inputMinutes.top
            z:1

            Label {
                id: labelSec
                text: qsTr("Seconds")
            }

            TextInput {
                id: stopwatchSec
                text: "00"
                horizontalAlignment: Text.Center
                inputMethodHints:    Qt.ImhDigitsOnly
                maximumLength: 2
                anchors.left:       parent.left
                anchors.right:      parent.right
                KeyNavigation.tab:  buttonStart
            }
        } // ColumnLayout
    } // Item

    Rectangle {
        id: rectangle
        //anchors.fill: width
        anchors.top:    parent.top
        anchors.bottom: layoutButtons.top
        anchors.left:   parent.left
        anchors.right:  parent.right
        anchors.bottomMargin: 10
        color: "green"

        //anchors.centerIn: parent
        radius: 5//*dpi
        // width: 200
        //  height: 200
        //anchors.fill: parent
        //anchors.
        Connections {
            target: cppPresentationTimer

            onAlarmYellow: {
                // console.log("Timer tick")
                rectangle.color = cppSettings.alarm1Color
            }
            onAlarmRed: {
                // console.log("Timer tick")
                if(cppPresentationTimer.isRunning)
                rectangle.color = cppSettings.alarm2Color
            }
        } // Connections
    } // Rectangle

    RowLayout {
        id: layoutButtons
        anchors.bottom: parent.bottom
        anchors.left:   parent.left
        anchors.right:  parent.right

        Button {
            text: "start"
            id: buttonStart
            Layout.fillWidth: true
            KeyNavigation.tab: stopwatchHour
            //anchors.right: buttonReset.visible ? buttonReset.left : parent.right
            //  anchors.fill: width

            onClicked: {
                if(rootView.state=="stopped"){
                    startPresentation()
                }
                else {
                    if(rootView.state=="paused")
                        startCountdown()
                    else
                    pausePresentation()
                }
            } // onClicked
        } // Button

        Button {
            text: "Reset"
            visible: false
            id: buttonReset
            Layout.fillWidth: true
            //anchors.leftMargin: 10
           // anchors.bottom: parent.bottom
            //anchors.right: parent.right
           // anchors.left: buttonStart.right

            onClicked: {
                    stopPresentation()
            }
        } // Button
    } // RowLayout

    Connections {
        target: cppPresentationTimer
        onPresentationTimerTick: {
            // console.log("Timer tick")
            //timeMin.text = Math.floor(cppPresentationTimer.remainingTime/60)
            //timeSeconds.text = cppPresentationTimer.remainingTime%60
            stopwatchValue(cppPresentationTimer.remainingTime)
        }
        onRunningChanged: {
            if((!cppPresentationTimer.isRunning)&&(cppPresentationTimer.remainingTime==0))
                stopPresentation()
        }
    }

    function startPresentation() {
        cppPresentationTimer.presentationTime = parseInt(stopwatchHour.text)*60*60+parseInt(stopwatchMin.text)*60+parseInt(stopwatchSec.text)
        cppPresentationTimer.setThresholdAlarms(cppSettings.alarm1Value,cppSettings.alarm2Value)
        cppPresentationTimer.setAlarmTypes(cppSettings.alarm1Type,cppSettings.alarm2Type)
        startCountdown()
    }

    function startCountdown() {
        if(cppPresentationTimer.startTimer()) {
            buttonStart.text      = "Pause"
            buttonReset.visible   = true
            Qt.inputMethod.hide();
            stopwatchHour.focus   = false
            stopwatchHour.enabled = false
            stopwatchMin.focus    = false
            stopwatchMin.enabled  = false
            stopwatchSec.focus    = false
            stopwatchSec.enabled  = false
            rootView.state        = "running"
        }
    }

    function stopPresentation() {
        cppPresentationTimer.stopTimer()
        rectangle.color       = "green"
        buttonStart.text      = "Start"
        buttonReset.visible   = false
        stopwatchValue(cppPresentationTimer.presentationTime)
        stopwatchHour.enabled = true
        stopwatchMin.enabled  = true
        stopwatchSec.enabled  = true
        rootView.state        = "stopped"
    }

    function pausePresentation() {
        cppPresentationTimer.stopTimer()
        buttonStart.text = "Resume"
        rootView.state   = "paused"
    }

    function stopwatchValue(value) {
        stopwatchHour.text = Math.floor(value/3600.0)
        stopwatchMin.text  = Math.floor(value/60.0)%60
        stopwatchSec.text  = value%60
    }
}
