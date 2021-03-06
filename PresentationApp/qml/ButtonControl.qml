import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1

RowLayout {
    id:rowLayout
    property alias startBtn: startButton
    layoutDirection: Qt.RightToLeft

    signal startClicked
    signal pauseClicked
    signal resumeClicked
    signal resetClicked

    function reset() {
        startButton.text = "Start"
        startButton.pauseVisible = false
        resetButton.visible = false
    }

    Button {
        id: startButton
        property bool pauseVisible: false
        text: "Start"

        Layout.fillWidth: true
        Layout.preferredHeight: parent.height


        onClicked: {
            if(resetButton.visible) {

                if(startButton.pauseVisible === true) {
                    pauseClicked()
                    startButton.text = "Resume"
                     startButton.pauseVisible = false
                }
                else {
                    resumeClicked()
                    startButton.text = "Pause"
                    startButton.pauseVisible = true
                }
            }
            else {
                startButton.text = "Pause"
                startButton.pauseVisible = true
                resetButton.visible = true
                startClicked()
            }
        }
    } // Button

    Button {
        id: resetButton
        text: "Reset"
        visible: false
        Layout.fillWidth: true
        Layout.preferredHeight: parent.height

        onClicked: {
            reset()
            resetClicked()
        }
    } // Button

    function updateButtons() {
        if(resetButton.visible) {

            if(startButton.pauseVisible === true) {
                startButton.text = "Resume"
                 startButton.pauseVisible = false
            }
        }
    }
}


