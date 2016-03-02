import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2

Rectangle {
    id: root
    property alias title: label.text
    property alias validator: textInput.validator
    property int   value

    width:  80
    height: 80
    color: "transparent"
    signal cursorPosChanged()
    signal changedByUser()

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
            inputMask: "00"

            onCursorPositionChanged: {
                if(cursorPosition==2) {
                    cursorPosition = 0
                    cursorPosChanged()
                }
            }

            onTextChanged: {
                if(focus) {
                    value = parseInt(text, 10)
                    changedByUser()
                }
            }

            onFocusChanged: {
                cursorVisible = false
                if(focus) {
                    cursorPosition = 0
                    color = "blue"
                }
                else
                    color = "black"
            }
        }
    } // ColumnLayout

    onValueChanged: {
        if(!focus)
            textInput.text = zeroFill(root.value)
    }

    function setInputFocus() {
        textInput.focus = true
    }

    function zeroFill(value) {
        var zerofilled = ('00'+value).slice(-2);
        return zerofilled;
    }
}
