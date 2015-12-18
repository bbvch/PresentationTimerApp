import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import QtQml 2.2

Rectangle {
    id: rootView
    //we are detecting states: stopped, running, paused
    state: "stopped"

    onStateChanged: console.log("New State:"+state)

    Rectangle {
        id: marginRect
        anchors.fill: parent
        anchors.margins: 10

        TimerRect {
            id: timeRect
            anchors.top:    parent.top
            anchors.bottom: layoutButtons.top
            anchors.left:   parent.left
            anchors.right:  parent.right
            anchors.bottomMargin: 10
        }

        RowLayout {
            id: layoutButtons
            anchors.bottom:  parent.bottom
            anchors.left:    parent.left
            anchors.right:   parent.right
            layoutDirection: Qt.RightToLeft

            Button {
                text: "start"
                id: buttonStart
                Layout.fillWidth: true
                KeyNavigation.tab: timeRect.hourItem

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
                id: buttonReset
                text: "Reset"
                visible: false
                Layout.fillWidth: true

                onClicked: {
                        stopPresentation()
                }
            } // Button
        } // RowLayout

    } // Rectangle

    Connections {
        target: cppPresentationTimer
        onPresentationTimerTick: {
            stopWatchValue(cppPresentationTimer.remainingTime)
        }
        onRunningChanged: {
            if((!cppPresentationTimer.isRunning)&&(cppPresentationTimer.remainingTime==0))
                stopPresentation()
        }
    }

    function startPresentation() {
        cppPresentationTimer.presentationTime = parseInt(timeRect.hourItem.text)*60*60+parseInt(timeRect.minItem.text)*60+parseInt(timeRect.secItem.text)
        cppPresentationTimer.setThresholdAlarms(cppSettings.firstAlarmValue, cppSettings.secondAlarmValue)
        cppPresentationTimer.setAlarmTypes(cppSettings.alarm1Type ,cppSettings.alarm2Type)
        startCountdown()
    }

    function startCountdown() {
        if(cppPresentationTimer.startTimer()) {
            buttonStart.text      = "Pause"
            buttonReset.visible   = true
            Qt.inputMethod.hide();
            timeRect.hourItem.focus   = false
            timeRect.hourItem.enabled = false
            timeRect.minItem.focus    = false
            timeRect.minItem.enabled  = false
            timeRect.secItem.focus    = false
            timeRect.secItem.enabled  = false
            rootView.state        = "running"
        }
    }

    function stopPresentation() {
        cppPresentationTimer.stopTimer()
        timeRect.background   = "green"
        buttonStart.text      = "Start"
        buttonReset.visible   = false
        stopWatchValue(cppPresentationTimer.presentationTime)
        timeRect.hourItem.enabled = true
        timeRect.minItem.enabled  = true
        timeRect.secItem.enabled  = true
        rootView.state        = "stopped"
    }

    function pausePresentation() {
        cppPresentationTimer.stopTimer()
        buttonStart.text = "Resume"
        rootView.state   = "paused"
    }

    function stopWatchValue(value) {
        timeRect.hourItem.text = Math.floor(value/3600.0)
        timeRect.minItem.text  = Math.floor(value/60.0)%60
        timeRect.secItem.text  = value%60
    }
}
