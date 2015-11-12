import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import QtQuick.Dialogs 1.2

Rectangle {
    id: "settingsView"
    anchors.fill: parent
    Label {
        id: labelSettings
        text: "Change the settings of the app"
    }

    AlarmSettings {
        id: alarmSettings1
        anchors.top: labelSettings.bottom
        alarmNr: 1
    }

    AlarmSettings {
        id: alarmSettings2
        anchors.top: alarmSettings1.bottom
        alarmNr: 2
    }





}

