import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1

Window {
    id: rootWindow
    visible: true
    minimumHeight: 800
    minimumWidth:  480

    ColumnLayout {
        id: colLayout
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        Rectangle {
            id: backgroundRect
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "green"
            radius: 10
        }

        ButtonControl {
            id: buttonControl
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height/12

            onClicked: {
                backgroundRect.color = "red"
            }
        }
    } // ColumnLayout
}

