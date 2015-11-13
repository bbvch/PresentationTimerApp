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
        width: parent.width/6
        minimumValue: 0
        value: Math.floor(cppSettings.presentationTime/3600)
        onValueChanged: defaultPresentationTimeChanged()
    }
    Label {
        id: labelDefaultHours
        text: qsTr("Hours")
        anchors.bottom: spinBoxDefaultHours.bottom
        anchors.left: spinBoxDefaultHours.right
    }
    SpinBox {
        id: spinBoxDefaultMinutes
        anchors.top: labelDefaultTime.bottom
        anchors.left: labelDefaultHours.right
        width: parent.width/6
        maximumValue: 59
        minimumValue: 0
        value: Math.floor(cppSettings.presentationTime/60)%60
        onValueChanged: defaultPresentationTimeChanged()
    }
    Label {
        id: labelDefaultMinutes
        text: qsTr("Minutes")
        anchors.bottom: spinBoxDefaultHours.bottom
        anchors.left: spinBoxDefaultMinutes.right
    }
    SpinBox {
        id: spinBoxDefaultSeconds
        anchors.top: labelDefaultTime.bottom
        anchors.left: labelDefaultMinutes.right
        width: parent.width/6
        maximumValue: 59
        minimumValue: 0
        value: cppSettings.presentationTime%60
        onValueChanged: defaultPresentationTimeChanged()
    }
    Label {
        id: labelDefaultSeconds
        text: qsTr("Seconds")
        anchors.bottom: spinBoxDefaultHours.bottom
        anchors.left: spinBoxDefaultSeconds.right
    }

    AlarmSettings {
        id: alarmSettings1
        anchors.top: labelDefaultSeconds.bottom
        anchors.topMargin: 10
        alarmNr: 1
        alarmType: cppSettings.alarm1Type
        alarmColor: cppSettings.alarm1Color
        alarmValue: cppSettings.alarm1Value
        onAlarmTypeChanged: cppSettings.alarm1Type = alarmType
        onAlarmColorChanged: cppSettings.alarm1Color = alarmColor
        onAlarmValueChanged: cppSettings.alarm1Value = alarmValue
    }

    AlarmSettings {
        id: alarmSettings2
        anchors.top: alarmSettings1.bottom
        alarmNr: 2
        alarmType: cppSettings.alarm2Type
        alarmColor: cppSettings.alarm2Color
        alarmValue: cppSettings.alarm2Value
        onAlarmTypeChanged: cppSettings.alarm2Type = alarmType
        onAlarmColorChanged: cppSettings.alarm2Color = alarmColor
        onAlarmValueChanged: {
            console.log("Alarm value changed"+alarmValue)
            cppSettings.alarm2Value = alarmValue
        }
    }
Button {
    id: buttonBack
    //onClicked:
    onClicked: stack.pop()
    text: "Back"
    anchors.top: alarmSettings2.bottom
    anchors.topMargin: 10
}

function defaultPresentationTimeChanged() {
    cppSettings.presentationTime = ((spinBoxDefaultHours.value*60)+spinBoxDefaultMinutes.value*60)+spinBoxDefaultSeconds.value
}



}

