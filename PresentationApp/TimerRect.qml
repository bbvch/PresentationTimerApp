import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2

Rectangle {
    id: backgroundColorRect
    property alias hourItem: hourInput.input
    property alias minItem:  minInput.input
    property alias secItem:  secInput.input
    property alias background: backgroundColorRect.color
    color: "green"
    radius: 10

    RowLayout {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.centerIn: parent

        LabelTextInput {
            id: hourInput
            title: qsTr("Hours")
//            Layout.preferredWidth: 50
//            Layout.preferredHeight: 50
        }

        LabelTextInput {
            id: minInput
            title: qsTr("Minutes")
//            Layout.preferredWidth: 50
//            Layout.preferredHeight: 50
        }

        LabelTextInput {
            id: secInput
            title: qsTr("Seconds")
//            Layout.preferredWidth: 50
//            Layout.preferredHeight: 50
        }
    }




    Connections {
        target: cppPresentationTimer

        onAlarmYellow: {
            // console.log("Timer tick")
            backgroundColorRect.color = cppSettings.firstAlarmColor
        }
        onAlarmRed: {
            // console.log("Timer tick")
            if(cppPresentationTimer.isRunning)
            backgroundColorRect.color = cppSettings.secondAlarmColor
        }
    } // Connections
} // Rectangle

