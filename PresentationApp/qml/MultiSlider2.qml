import QtQuick 2.0

Rectangle {
    id: sliderRoot
    property int sliderLowerValue: 120000  // in ms
    property int sliderUpperValue: 600000  // in ms
    property int duration:         3665000 // in ms
    property int resolution:       10000   // stepwith

    width:  60
    height: 600
    color: "transparent"

    signal lowerSliderValueChanged(int value)
    signal upperSliderValueChanged(int value)

    //////////////////////////////
    ////////Button Up/////////////
    //////////////////////////////
    Rectangle {
        id:arrowTop
        width:  40
        height: 40
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        color: "transparent"
        z:1

        Image {
            id: arrowTopImage
            source: "images/triangle_top.png"
            anchors.fill: parent
        }

        MouseArea {
            id: arrowUpMouseArea
            anchors.centerIn: parent
            width: 60
            height: 60
            signal myPressAndHold()

            onPressed: {
                arrowTopImage.source = "images/triangle_top_pressed.png"
                pressAndHoldTimer.start()
                moveUp()
            }

            onMyPressAndHold: {
                moveUp()
            }

            onReleased: {
                arrowTopImage.source = "images/triangle_top.png"
                pressAndHoldTimer.stop()
                pressAndHoldTimer.interval = 1000
            }

            Timer {
                id: pressAndHoldTimer

                interval: 1000 //your press-and-hold interval here
                repeat:  true
                running: false

                onTriggered: {
                    interval = 100
                    parent.myPressAndHold()
                }
            }

            function moveUp() {
                if(upperHandle.state === "selected") {
                    if(sliderUpperValue < duration)
                        sliderUpperValue += resolution // plus 1min
                    if(sliderUpperValue > duration)
                        sliderUpperValue = duration
                    upperHandle.updateUpperSliderPos()
                }
                else if(lowerHandle.state === "selected") {
                    if(sliderLowerValue < sliderUpperValue)
                        sliderLowerValue += resolution // plus 1min
                    if(sliderLowerValue > sliderUpperValue)
                        sliderLowerValue = sliderUpperValue
                    lowerHandle.updateLowerSliderPos()
                }
            }
        }
    }
    //////////////////////////////
    ////////Button Down///////////
    //////////////////////////////
    Rectangle {
        id:arrowBottom
        width:  40
        height: 40
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        color: "transparent"
        z:1

        Image {
            id: arrowBottomImage
            source: "images/triangle_bottom.png"
            anchors.fill: parent
        }

        MouseArea {
            anchors.centerIn: parent
            width: 60
            height: 60
            signal myPressAndHold()

            onPressed: {
                arrowBottomImage.source = "images/triangle_bottom_pressed.png"
                pressAndHoldTimer2.start()
                moveDown()
            }

            onMyPressAndHold: {
                moveDown()
            }

            onReleased: {
                arrowBottomImage.source = "images/triangle_bottom.png"
                pressAndHoldTimer2.stop()
                pressAndHoldTimer2.interval = 1000
            }

            Timer {
                id: pressAndHoldTimer2

                interval: 1000 //your press-and-hold interval here
                repeat:  true
                running: false

                onTriggered: {
                    interval = 100
                    parent.myPressAndHold()
                }
            }

            function moveDown() {
                if(upperHandle.state === "selected") {
                    if(sliderUpperValue > sliderLowerValue)
                        sliderUpperValue -= resolution
                    if(sliderUpperValue < sliderLowerValue)
                        sliderUpperValue = sliderLowerValue
                    upperHandle.updateUpperSliderPos()
                }
                else if(lowerHandle.state = "selected") {
                    if(sliderLowerValue > 0)
                        sliderLowerValue -= resolution;
                    if(sliderLowerValue < 0)
                        sliderLowerValue = 0
                    lowerHandle.updateLowerSliderPos()

                }
            }
        }
    }
    //////////////////////////////
    ///////// Slider /////////////
    //////////////////////////////
    Rectangle {
        id: multiSlider

        anchors.horizontalCenter:  parent.horizontalCenter
        anchors.top: arrowTop.bottom
        anchors.bottom: arrowBottom.top
        anchors.topMargin:  10
        anchors.bottomMargin: 10
        width: arrowTop.width
        color: "transparent"
        z:1

        MouseArea {
            anchors.fill: parent

            onReleased: {
                lowerHandle.state = ""
                upperHandle.state = ""
                lowerHandle.z = 0
                upperHandle.z = 0
            }
        }


        Rectangle {
            id: groove
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top:  parent.top
            anchors.bottom: parent.bottom
            anchors.topMargin:    0
            anchors.bottomMargin: 0
            width:10
            smooth: true
            color: "lightblue"
            radius: 5
            border.width: 1
            border.color: "darkgrey"

            MouseArea {
                anchors.fill: parent

                onReleased: {
                    lowerHandle.state = ""
                    upperHandle.state = ""
                    lowerHandle.z = 0
                    upperHandle.z = 0
                }
            }
        }

        Text {
            id:maxTextValue
            text: hms_Formater(duration)
            anchors.left: groove.right
            anchors.leftMargin: 20
            anchors.top: groove.top
            font.pointSize: 15
        }

        Text {
            id:minTextValue
            text: "00:00:00"
            anchors.left: groove.right
            anchors.leftMargin: 20
            anchors.bottom: groove.bottom
            font.pointSize: 15
        }

        //////////////////////////////
        //////// Upper Handle ////////
        //////////////////////////////
        Rectangle {
            id: upperHandle

            property bool hover: false
            property bool init: true
            color: "yellow"
            x: groove.x
            y: groove.height/2
            width: 50
            height: 30
            anchors.horizontalCenter: groove.horizontalCenter
            smooth: true
            border.color: "dimgrey"
            border.width: 0
            radius: 5

            states: [
                State {
                    name: "selected"
                    PropertyChanges {
                        target: upperHandle
                        border.width: 2
                    }
                }
            ]

            Text {
                id: maxValueText
                text: "00:00:00"
                color: "black"
                font.pointSize: 20

                anchors.right: upperHandle.left
                anchors.rightMargin: 5
                anchors.verticalCenter: upperHandle.verticalCenter
            }

            MouseArea {
                id: maxMouseArea

                width:  80
                height: 40
                anchors.centerIn: parent
                hoverEnabled: true
                drag.axis: Drag.YAxis
                drag.target: upperHandle
                drag.minimumY: groove.y
                drag.maximumY: lowerHandle.y

                onPressed: {
                    lowerHandle.state = ""
                    upperHandle.state = "selected"
                    lowerHandle.z = 0
                    upperHandle.z = 1
                }
            }

            onYChanged: {
                if(init === false){
                    sliderUpperValue = Math.round((duration*(1 - upperHandle.y/(groove.height-upperHandle.height)))/resolution)*resolution
                    maxValueText.text = hms_Formater(sliderUpperValue)
                    upperSliderValueChanged(sliderUpperValue)
                }
            }

            Component.onCompleted: {
                upperHandle.y = (groove.height-upperHandle.height) * (1 - sliderUpperValue/duration)
                init = false
                maxValueText.text = hms_Formater(sliderUpperValue)
                upperSliderValueChanged(sliderUpperValue)
            }

            function updateUpperSliderPos() {
                upperHandle.y = (groove.height-upperHandle.height) * (1 - sliderUpperValue/duration)
                upperSliderValueChanged(sliderUpperValue)
            }
        }

        //////////////////////////////
        //////// Lower Handle ////////
        //////////////////////////////
        Rectangle {
            id: lowerHandle

            property bool hover: false
            property bool init: true
            color: "red"
            border.color: "dimgrey"
            border.width: 0
            x: groove.x+groove.width-lowerHandle.width
            y: (groove.height-lowerHandle.height)
            width: 50
            height: 30
            anchors.horizontalCenter: groove.horizontalCenter
            smooth: true
            radius: 5

            states: [
                State {
                    name: "selected"
                    PropertyChanges {
                        target: lowerHandle
                        border.width: 2
                    }
                }
            ]

            Text {
                id: lowerValueText
                text: "00:00:00"
                color: "black"
                font.pointSize: 20
                smooth: true

                anchors.right: lowerHandle.left
                anchors.rightMargin: 5
                anchors.verticalCenter: lowerHandle.verticalCenter
            }

            MouseArea {
                id: lowerMouseArea

                width:  80
                height: 40
                anchors.centerIn: parent
                hoverEnabled: true
                drag.axis: Drag.YAxis
                drag.target: lowerHandle
                drag.minimumY: upperHandle.y
                drag.maximumY: groove.y+groove.height-lowerHandle.height

                onPressed: {
                    upperHandle.state = ""
                    lowerHandle.state = "selected"
                    lowerHandle.z = 1
                    upperHandle.z = 0
                }
            } // MouseArea

            onYChanged: {
                if(init === false){
                    sliderLowerValue = Math.round( (duration*(1 - lowerHandle.y/(groove.height-lowerHandle.height)))/resolution ) * resolution
                    lowerValueText.text = hms_Formater(sliderLowerValue)
                    lowerSliderValueChanged(sliderLowerValue)
                }
            }

            Component.onCompleted: {
                lowerHandle.y = (groove.height-lowerHandle.height) * (1 - sliderLowerValue/duration)
                init = false
                lowerValueText.text = hms_Formater(sliderLowerValue)
                lowerSliderValueChanged(sliderLowerValue)
                lowerHandle.updateLowerSliderPos()
            }

            function updateLowerSliderPos() {
                lowerHandle.y = (groove.height-lowerHandle.height) * (1 - sliderLowerValue/duration)
                lowerSliderValueChanged(sliderLowerValue)
            }
        } //Rectangle minHandler
    } // Rectangle multislider

    function hms_Formater(value)
    {
        var remainigTime = Math.floor(value/1000)
        var hour = Math.floor(remainigTime/3600)
        var second = remainigTime % 3600;
        var minute = Math.floor(second/60)
        second %= 60;
        return zeroFill(hour) + ":" + zeroFill(minute) + ":" + zeroFill(second)
    }

    function zeroFill(value) {
        var zerofilled = ('00'+value).slice(-2);
        return zerofilled;
    }
}
