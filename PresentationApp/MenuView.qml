import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import QtQuick.Dialogs 1.2

Rectangle {
    id: settingsView
//    anchors.fill: parent
    anchors.margins: 10

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
        anchors.top:    labelDefaultTime.bottom
        width:          parent.width/6
        minimumValue:   0
        value:          Math.floor(cppSettings.presentationTime/3600)

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
        anchors.top:  labelDefaultTime.bottom
        anchors.left: labelDefaultHours.right
        width:        parent.width/6
        maximumValue: 59
        minimumValue: 0
        value:        Math.floor(cppSettings.presentationTime/60)%60

        onValueChanged: defaultPresentationTimeChanged()
    }

    Label {
        id: labelDefaultMinutes
        text: qsTr("Minutes")
        anchors.bottom: spinBoxDefaultHours.bottom
        anchors.left:   spinBoxDefaultMinutes.right
    }

    SpinBox {
        id: spinBoxDefaultSeconds
        anchors.top:  labelDefaultTime.bottom
        anchors.left: labelDefaultMinutes.right
        width:        parent.width/6
        maximumValue: 59
        minimumValue: 0
        value:          cppSettings.presentationTime%60

        onValueChanged: defaultPresentationTimeChanged()
    }

    Label {
        id: labelDefaultSeconds
        text: qsTr("Seconds")
        anchors.bottom: spinBoxDefaultHours.bottom
        anchors.left:   spinBoxDefaultSeconds.right
    }

    AlarmSettings {
        id: firstAlarmSettings
        anchors.top: labelDefaultSeconds.bottom
        anchors.topMargin: 10
        alarmNr: 1
        alarmType:           cppSettings.alarm1Type
        alarmColor:          cppSettings.firstAlarmColor
        alarmValue:          cppSettings.firstAlarmValue

        onAlarmTypeChanged:  cppSettings.alarm1Type      = alarmType
        onAlarmColorChanged: cppSettings.firstAlarmColor = alarmColor
        onAlarmValueChanged: cppSettings.firstAlarmValue = alarmValue
    }

    AlarmSettings {
        id: secondAlarmSettings
        anchors.top: firstAlarmSettings.bottom
        alarmNr: 2
        alarmType:           cppSettings.alarm2Type
        alarmColor:          cppSettings.secondAlarmColor
        alarmValue:          cppSettings.secondAlarmValue

        onAlarmTypeChanged:  cppSettings.alarm2Type       = alarmType
        onAlarmColorChanged: cppSettings.secondAlarmColor = alarmColor
        onAlarmValueChanged: {
            console.log("Alarm value changed"+alarmValue)
            cppSettings.secondAlarmValue = alarmValue
        }
    }

    Button {
        id: buttonBack
        text: "Back"
        anchors.top: secondAlarmSettings.bottom
        anchors.topMargin: 10

        onClicked: stack.pop()
    }

    function defaultPresentationTimeChanged() {
        cppSettings.presentationTime = ((spinBoxDefaultHours.value*60)+spinBoxDefaultMinutes.value*60)+spinBoxDefaultSeconds.value
    }
}

