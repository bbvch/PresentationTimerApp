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
    text: "Alarm "+alarmNr
    font.bold: true
}
Label {
    id: labelAlarmType
    anchors.top: labelAlarm.bottom
        text: "Please choose a type of alarm"+alarmNr
}
Switch {
id: switchAlarmType
anchors.top: labelAlarmType.bottom
checked: alarmType
}
Label {
id: labelValueAlarm
anchors.top: switchAlarmType.bottom
    text: "Please choose a value for alarm"+alarmNr
}
Slider {
id: sliderValueAlarm
//anchors.fill: width
width: 100
value: valueAlarm.value
minimumValue: 0
maximumValue: 100
anchors.top: labelValueAlarm.bottom
onValueChanged: {
    if(valueAlarm.value != sliderValueAlarm.value)
        valueAlarm.value = sliderValueAlarm.value
}
}
SpinBox {
id: valueAlarm
anchors.top: labelValueAlarm.bottom
anchors.left: sliderValueAlarm.right
value: alarmValue
decimals: 0
//onValueChanged: sliderValueAlarm.value = valueAlarm
//value: sliderValueAlarm.value*100
//text: sliderValueAlarm.value
//inputMethodHints: Qt.ImhPreferNumbers|Qt.ImhDigitsOnly
onValueChanged:  {
    if(sliderValueAlarm.value != valueAlarm.value)
    sliderValueAlarm.value = valueAlarm.value
}
}

Label {
    id: labelColorAlarm
    anchors.top: valueAlarm.bottom
    text: "Please choose a Value for the alarm"+alarmNr
}

Button {
    text: "Pick color"
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
    width: 20
    height: 20
}

ColorDialog {
    id: colorDialogAlarm
    visible: false
    title: "Please choose a color"
    //Component.onCompleted: visible = true

}
}
