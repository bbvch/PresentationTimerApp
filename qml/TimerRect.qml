import QtQuick 2.0
import QtQuick.Layouts  1.2

Rectangle {
    id: backgroundColorRect
    property alias hourItem: hourInput.value
    property alias minItem:  minInput.value
    property alias secItem:  secInput.value
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
            validator: IntValidator{bottom: 0; top: 99;}

            onCursorPosChanged: {
                minInput.setInputFocus(true)
            }
        }

        InputWithLabel {
            id: minInput
            title: qsTr("Minutes")
            validator: IntValidator{bottom: 0; top: 59;}

            onCursorPosChanged: {
                secInput.setInputFocus(true)
            }
        }

        InputWithLabel {
            id: secInput
            title: qsTr("Seconds")
            validator: IntValidator{bottom: 0; top: 59;}
        }
    }
} // Rectangle

