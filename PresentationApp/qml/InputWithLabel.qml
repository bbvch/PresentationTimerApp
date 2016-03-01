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

            onTextChanged: {
                if(focus)
                    changedByUser()
            }

            onFocusChanged: {
                if(focus)
                    textInput.selectAll()
                else
                    textInput.deselect()
            }
        }
    } // ColumnLayout

    onValueChanged: {
        textInput.text = zeroFill(root.value)
    }

    function deselect() {
        textInput.deselect()
        textInput.focus = false
    }

    function zeroFill(value) {
        var zerofilled = ('00'+value).slice(-2);
        return zerofilled;
    }
}
