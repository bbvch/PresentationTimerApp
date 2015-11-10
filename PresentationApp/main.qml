import QtQuick 2.4
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2


Window {
    visible: true
    id: mainWindow
    property int currentTime
    property int presentationTime
    width: 400
    height: 400

    property int dpi: Screen.pixelDensity*25.4
    Item {
        id: mainDisplay
        anchors.fill: parent
        anchors.margins: 10


        Text {
            id: stopwatch
            text: "00:00:00"
            //Layout.fillWidth: true
            // anchors.centerIn: parent
            // anchors.left: parent
            // anchors.right: parent
            // width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.Center
            //horizontalAlignment: Label.AlignHCenter
            //anchors.top: mainWindow.
            // anchors.bottom: rectangle.top
            // anchors.fill: parent
        }
        Rectangle {
            color: "green"
            id: rectangle
            //anchors.fill: width
            anchors.top: stopwatch.bottom
            anchors.bottom: timeMin.top
            anchors.left: parent.left
            anchors.right: parent.right
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
                rectangle.color = "red"
            }
            }
        }
        TextInput {
            id: timeMin
            width: parent.width
            //height: mainWindow.height/10
            text: qsTr("0")
            //font.pixelSize: 12
            anchors.right: labelMin.left
            anchors.bottom: buttonStart.top
            horizontalAlignment: TextInput.AlignRight

        }

        Label {
            text: "Min"
            id: labelMin
            anchors.bottom: buttonStart.top
            anchors.right: timeSeconds.left
        }
        TextInput {
            id: timeSeconds
            width: mainWindow.width/4
            //height: mainWindow.height/10
            text: qsTr("10")
            //font.pixelSize: 12
            anchors.right: labelSec.left
            anchors.bottom: buttonStart.top
            horizontalAlignment: TextInput.AlignRight

        }

        Label {
            text: "sec"
            id: labelSec
            anchors.right: parent.right
            anchors.bottom: buttonStart.top
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

    }

    function startPresentation() {
        cppPresentationTimer.presentationTime = parseInt(timeMin.text)*60+parseInt(timeSeconds.text)
        cppPresentationTimer.startTimer()
        console.log("Pr time"+cppPresentationTimer.presentationTime)
        //cppPresentationTimer.isRunning = true;
        rectangle.color = "green"
        buttonStart.text = "Stop"
    }

    function stopPresentation() {

        cppPresentationTimer.stopTimer()
        rectangle.color = "green"
        buttonStart.text = "Start"
        timeSeconds.text = cppPresentationTimer.presentationTime%60
        timeMin.text=Math.floor(cppPresentationTimer.presentationTime/60)
    }
 Connections {
     target: cppPresentationTimer
 onPresentationTimerTick: {
    // console.log("Timer tick")
     timeMin.text = Math.floor(cppPresentationTimer.remainingTime/60)
     timeSeconds.text = cppPresentationTimer.remainingTime%60
     stopwatch.text = Math.floor(cppPresentationTimer.time/60)+":"+cppPresentationTimer.time%60
 }
 onRunningChanged: {
     if(!cppPresentationTimer.isRunning)
         stopPresentation()
 }
 }

 Keys.onMenuPressed:
 {
     console.log("Menu pressed")
 }

}
