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

            onChangedByUser: {
                inputValuesChanged()
            }
        }

        InputWithLabel {
            id: minInput
            title: qsTr("Minutes")
            validator: IntValidator{bottom: 0; top: 59;}

            onCursorPosChanged: {
                secInput.setInputFocus(true)
            }

            onChangedByUser: {
                inputValuesChanged()
            }
        }

        InputWithLabel {
            id: secInput
            title: qsTr("Seconds")
            validator: IntValidator{bottom: 0; top: 59;}

            onChangedByUser: {
                inputValuesChanged()
            }
        }
    }

    function deselectAll() {
        hourInput.setInputFocus(false)
        minInput.setInputFocus(false)
        secInput.setInputFocus(false)
    }

    function inputValuesChanged() {
        var value = (hourInput.value*3600 + minInput.value*60 + secInput.value)*1000
        cppSettings.duration = value
        cppPresentationTimer.duration = cppSettings.duration

        if(cppSettings.duration < cppSettings.attentionAlarmValue) {
            cppSettings.attentionTime = 0
            cppPresentationTimer.attentionTime = 0
        }

        if(cppSettings.duration < cppSettings.finalTime) {
            cppSettings.finalTime = 0
            cppPresentationTimer.finalTime = 0
        }
    }
} // Rectangle

