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

        InputWithLabel {
            id: hourInput
            title: qsTr("Hours")
        }

        InputWithLabel {
            id: minInput
            title: qsTr("Minutes")
        }

        InputWithLabel {
            id: secInput
            title: qsTr("Seconds")
        }
    }
} // Rectangle

