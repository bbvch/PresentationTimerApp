import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2

Item {
    id: rootView
    anchors.fill: parent
    anchors.margins: 10
    /*Rectangle {
        id: spacingRectangle
        anchors.top: parent.top
        anchors.bottom: rootView.verticalCenter
    }*/
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
        anchors.left: parent.left
        anchors.right: parent.right
        inputMethodHints:Qt.ImhDigitsOnly
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
        anchors.left: parent.left
        anchors.right: parent.right
        inputMethodHints:Qt.ImhDigitsOnly
    }
    }
ColumnLayout {
    id: inputSeconds
            anchors.leftMargin: 20
    anchors.left: inputMinutes.right
    anchors.top: inputMinutes.top
    z:1
    Label {
        id: labelSec
        text: qsTr("Seconds")
}
    TextInput {
        id: stopwatchSec
        text: "00"
        horizontalAlignment: Text.Center
        inputMethodHints:Qt.ImhDigitsOnly
        maximumLength: 2
        anchors.left: parent.left
        anchors.right: parent.right
    }
    }

}
    Rectangle {
        color: "green"
        id: rectangle
        //anchors.fill: width
        anchors.top: parent.top
        anchors.bottom: buttonStart.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottomMargin: 10

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
                rectangle.color = "yellow"
            }
            onAlarmRed: {
                // console.log("Timer tick")
                if(cppPresentationTimer.isRunning)
                rectangle.color = "red"
            }
        }
    }

    Button {
        text: "start"
        id: buttonStart
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.left: parent.left
        onClicked: {
            if(!cppPresentationTimer.isRunning){
                startPresentation()
            }
            else
            {
                stopPresentation()
            }
        }
    }

    Button {
        text: "start"
        visible: false
        id: buttonReset
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.left: parent.left
        onClicked: {
            if(!cppPresentationTimer.isRunning){
                startPresentation()
            }
            else
            {
                stopPresentation()
            }
        }
    }



    function startPresentation() {
        cppPresentationTimer.presentationTime = parseInt(stopwatchHour.text)*60*60+parseInt(stopwatchMin.text)*60+parseInt(stopwatchSec.text)
        if(cppPresentationTimer.startTimer()) {
        console.log("Pr time"+cppPresentationTimer.presentationTime)
        //cppPresentationTimer.isRunning = true;
        rectangle.color = "green"
        buttonStart.text = "Stop"
            Qt.inputMethod.hide();
        }
    }

    function stopPresentation() {

        cppPresentationTimer.stopTimer()
        rectangle.color = "green"
        buttonStart.text = "Start"
        stopwatchSec.text = cppPresentationTimer.presentationTime%60
        stopwatchMin.text=Math.floor(cppPresentationTimer.presentationTime/60)%60
        stopwatchHour.text=Math.floor(cppPresentationTimer.presentationTime/3600)
    }
    Connections {
        target: cppPresentationTimer
        onPresentationTimerTick: {
            // console.log("Timer tick")
            //timeMin.text = Math.floor(cppPresentationTimer.remainingTime/60)
            //timeSeconds.text = cppPresentationTimer.remainingTime%60
            stopwatchHour.text = Math.floor(cppPresentationTimer.remainingTime/3600.0)
            stopwatchMin.text = Math.floor(cppPresentationTimer.remainingTime/60.0)%60
            stopwatchSec.text = cppPresentationTimer.remainingTime%60
        }
        onRunningChanged: {
            if(!cppPresentationTimer.isRunning)
                stopPresentation()
        }
    }


}
