import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import QtQuick.Dialogs 1.2
Item {
    property int alarmNr: 1
    property bool alarmType: false
    property int alarmValue: 50
    property color alarmColor: "red"
    height: childrenRect.height
    width: childrenRect.width
Label {
    id: labelAlarm
    text: qsTr("Alarm "+alarmNr)
    font.bold: true
}
Label {
    id: labelAlarmType
    anchors.top: labelAlarm.bottom
        text: qsTr("Please choose a type of alarm"+alarmNr)
}
Switch {
id: switchAlarmType
anchors.top: labelAlarmType.bottom
checked: alarmType
}
Label {
id: labelValueAlarm
anchors.top: switchAlarmType.bottom
    text: qsTr("Please choose a value for alarm"+alarmNr)
}
Slider {
id: sliderValueAlarm
//anchors.fill: width
//width: 100
width: 2.0*parent.width/3
value: valueAlarm.value
minimumValue: 0
maximumValue: 100
anchors.top: labelValueAlarm.bottom
//anchors.left: parent.left
//anchors.right: valueAlarm.left
onValueChanged: {
    if(valueAlarm.value != sliderValueAlarm.value)
        valueAlarm.value = sliderValueAlarm.value
    alarmValue = valueAlarm.value
}
}
SpinBox {
id: valueAlarm
anchors.top: labelValueAlarm.bottom
anchors.left: sliderValueAlarm.right
value: alarmValue
width: parent.width/3
decimals: 0
//onValueChanged: sliderValueAlarm.value = valueAlarm
//value: sliderValueAlarm.value*100
//text: sliderValueAlarm.value
//inputMethodHints: Qt.ImhPreferNumbers|Qt.ImhDigitsOnly
onValueChanged:  {
    if(sliderValueAlarm.value != valueAlarm.value)
    sliderValueAlarm.value = valueAlarm.value
    alarmValue = valueAlarm.value
}
}

Label {
    id: labelColorAlarm
    anchors.top: valueAlarm.bottom
    text: qsTr("Please choose a color for the alarm"+alarmNr)
}

Button {
    text: qsTr("Pick color")
    id: buttonColorPickAlarm
   // anchors.top:
    onClicked: {
        colorDialogAlarm.visible = true
    }
    anchors.top: labelColorAlarm.bottom
}
Rectangle {
    id: rectColorShowAlarm
    color: alarmColor
    anchors.top: labelColorAlarm.bottom
    anchors.left: buttonColorPickAlarm.right
    width: parent.width/4
    height: buttonColorPickAlarm.height
    anchors.leftMargin: 10
    MouseArea {
        width: parent.width
        height: parent.height
        onClicked: {
            colorDialogAlarm.visible = true
        }
    }
}

ColorDialog {
    id: colorDialogAlarm
    visible: false
    title: "Please choose a color"
    //Component.onCompleted: visible = true
    onColorChanged: {
        rectColorShowAlarm.color = color
        alarmColor = color
    }

}
}
