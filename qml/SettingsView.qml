import QtQuick 2.0

Rectangle {
    id: settingsView

    Rectangle {
        id: frame
        anchors.fill: parent
        anchors.margins: 20
        radius: 10
        color: "lightgrey"

        Text {
            id: title
            anchors.left: parent.left
            anchors.leftMargin: parent.width/20
            anchors.top: parent.top
            anchors.topMargin: parent.width/20

            text: "Settings:"
            font.pointSize: 30
        }

        MultiSlider {
            id: timeValueSlider
            anchors.centerIn: parent
            duration:         cppSettings.duration
            sliderUpperValue: cppSettings.attentionTime
            sliderLowerValue: cppSettings.finalTime

            onUpperSliderValueChanged: {
                cppSettings.attentionTime = timeValueSlider.sliderUpperValue
                cppPresentationTimer.setThresholdAlarms(timeValueSlider.sliderUpperValue, timeValueSlider.sliderLowerValue)
            }

            onLowerSliderValueChanged: {
                cppSettings.finalTime = timeValueSlider.sliderLowerValue
                cppPresentationTimer.setThresholdAlarms(timeValueSlider.sliderUpperValue, timeValueSlider.sliderLowerValue)
            }
        }
    }

    Component.onCompleted: {
        timeValueSlider.duration         = cppSettings.duration
        timeValueSlider.sliderUpperValue = cppSettings.duration > cppSettings.attentionTime ? cppSettings.attentionTime : 1000
        timeValueSlider.sliderLowerValue = cppSettings.duration > cppSettings.finalTime     ? cppSettings.finalTime : 0
    }
}
