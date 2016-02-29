import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1

RowLayout {
    id:rowLayout
    property alias startBtn: startButton
    layoutDirection: Qt.RightToLeft

    signal clicked

    Button {
        id: startButton
        text: "Start"

        Layout.fillWidth: true
        Layout.preferredHeight: parent.height


        onClicked: {
            if(resetButton.visible) {
                startButton.text = "Start"
                resetButton.visible = false
            }
            else {
                startButton.text = "Pause"
                resetButton.visible = true
            }

            rowLayout.clicked()
        }
    } // Button

    Button {
        id: resetButton
        text: "Reset"
        visible: false
        Layout.fillWidth: true
        Layout.preferredHeight: parent.height

    } // Button
}


