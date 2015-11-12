import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import QtQuick.Dialogs 1.2

Rectangle {
    id: "settingsView"
    //anchors.fill: parent
    Label {
        id: labelSettings
        text: qsTr("Change the settings of the app")
    }

    Label {
        id: labelDefaultTime
        anchors.top: labelSettings.bottom
        text: qsTr("Default presentation time")
    }
    SpinBox {
        id: spinBoxDefaultHours
        anchors.top: labelDefaultTime.bottom
        minimumValue: 0

    }
    Label {
        id: labelDefaultHours
        text: qsTr("Hours")
        anchors.top: labelDefaultTime.bottom
        anchors.left: spinBoxDefaultHours.right
    }
    SpinBox {
        id: spinBoxDefaultMinutes
        anchors.top: labelDefaultTime.bottom
        anchors.left: labelDefaultHours.right
        maximumValue: 59
        minimumValue: 0
    }
    Label {
        id: labelDefaultMinutes
        text: qsTr("Minutes")
        anchors.top: labelDefaultTime.bottom
        anchors.left: spinBoxDefaultMinutes.right
    }
    SpinBox {
        id: spinBoxDefaultSeconds
        anchors.top: labelDefaultTime.bottom
        anchors.left: labelDefaultMinutes.right
        maximumValue: 59
        minimumValue: 0
    }
    Label {
        id: labelDefaultSeconds
        text: qsTr("Seconds")
        anchors.top: labelDefaultTime.bottom
        anchors.left: spinBoxDefaultSeconds.right
    }

    AlarmSettings {
        id: alarmSettings1
        anchors.top: labelDefaultSeconds.bottom
        alarmNr: 1
    }

    AlarmSettings {
        id: alarmSettings2
        anchors.top: alarmSettings1.bottom
        alarmNr: 2
        alarmType: true
        alarmColor: "yellow"
        alarmValue: 25
    }
Button {
    id: buttonBack
    //onClicked:
    onClicked: stack.pop()
    text: "Back"
    anchors.top: alarmSettings2.bottom
}




}

