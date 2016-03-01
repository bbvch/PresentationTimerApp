import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2

Rectangle {
    id: root
    property alias title: label.text
    property alias input: textInput
    width: 80
    height: 80
    color: "transparent"

    ColumnLayout {
        id: inputColumn
        anchors.fill: parent
        Layout.alignment: Qt.AlignCenter
        Label {
            id: label
            text: qsTr("Unit")
            Layout.alignment: Qt.AlignCenter
        }

        TextInput {
            id: textInput
            text: "00"
            font.bold: true
            font.pixelSize: 28
            maximumLength:  2
            Layout.alignment:    Qt.AlignCenter
            horizontalAlignment: Text.Center
            inputMethodHints:    Qt.ImhDigitsOnly
            KeyNavigation.tab:   buttonStart
        }
    } // ColumnLayout
}

