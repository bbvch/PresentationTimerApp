import QtQuick 2.0

Rectangle {
    width: 400
    height: 160
    color: "brown"

    signal valueChanged()

    Rectangle {
        id:arrowLeft
        width:  40
        height: 40
        anchors.left: parent.left
        anchors.verticalCenter:  parent.verticalCenter
        color: "transparent"
        z:1

        Image {
            id: arrowLeftImage
            source: "images/triangle_left.png"
            anchors.fill: parent
        }

        MouseArea {
            anchors.fill: parent

            onPressed: {
                arrowLeftImage.source = "images/triangle_left_pressed.png"
            }

            onReleased: {
                arrowLeftImage.source = "images/triangle_left.png"
            }
        }
    }

    Rectangle {
        id:arrowRight
        width:  40
        height: 40
        anchors.right: parent.right
        anchors.verticalCenter:  parent.verticalCenter
        color: "transparent"
        z:1

        Image {
            id: arrowRightImage
            source: "images/triangle_right.png"
            anchors.fill: parent
        }

        MouseArea {
            anchors.fill: parent

            onPressed: {
                arrowRightImage.source = "images/triangle_right_pressed.png"
            }

            onReleased: {
                arrowRightImage.source = "images/triangle_right.png"
            }
        }
    }

    Rectangle {
        id: multiSlider

        property int sliderMinValue: 0
        property int sliderMaxValue: 0
        property int sliderValue:    1000

        anchors.verticalCenter:  parent.verticalCenter
        anchors.left: arrowLeft.right
        anchors.right: arrowRight.left
        color: "green"
        border.color: "black"
        border.width: 1
        z:1

        MouseArea {
            anchors.fill: parent

            onReleased: {
                minHandle.state = ""
                maxHandle.state = ""
            }
        }


        Rectangle {
            id: groove
            anchors.verticalCenter: parent.verticalCenter
            anchors.left:  parent.left
            anchors.right: parent.right
            anchors.leftMargin:  20
            anchors.rightMargin: 20
            height:10
            smooth: true
            color: "lightblue"
            radius: 5

            MouseArea {
                anchors.fill: parent

                onReleased: {
                    minHandle.state = ""
                    maxHandle.state = ""
                }
            }
        }

        // upper slider
        Rectangle {
            id: maxHandle

            property bool hover: false
            color: "yellow"
            x: groove.x
            y: groove.y - maxHandle.height/2
            width: 30
            height: 50
            anchors.verticalCenter: groove.verticalCenter
            smooth: true
            border.color: "darkgrey"
            border.width: 0
            radius: 5

            states: [
                State {
                    name: "clicked"
                    PropertyChanges {
                        target: maxHandle
                        border.width: 2
                    }
                }
            ]

            Text {
                id: maxValueText
                text: "00:00:00"
                color: "black"

                anchors.top: maxHandle.bottom
                anchors.horizontalCenter: maxHandle.horizontalCenter
            }

            MouseArea {
                id: maxMouseArea

    //            property int imageOffset: 4 // there is an offset in the image to the bottom line
    //            property int offset: 7      // there is an offset in the image to the bottom line
    //            property int maxX: minHandle.x - minHandle.width
    //            property int baseMaxX: groove.width - maxHandle.width - offset
    //            property int baseMinX: - maxHandle.width
    //            property int deltaX: baseMaxX - baseMinX

                width:  80
                height: 80
                anchors.centerIn: parent
                hoverEnabled: true
                drag.axis: Drag.XAxis
                drag.target: maxHandle
                drag.minimumX: groove.x
                drag.maximumX: minHandle.x -maxHandle.width

    //            onEntered: {
    //                maxHandle.hover = true
    //            }
    //            onExited: {
    //                maxHandle.hover = false
    //                maxHandle.state = ""
    //            }
                onPressed: {
                    minHandle.state = ""
                    maxHandle.state = "clicked"
                }

                onXChanged: {
                    sliderMaxValue = sliderValue - (sliderValue * (maxHandle.x+maxHandle.width/2)/groove.width)
                    console.log("MinValue: "+sliderMinValue)
                }
            }
        }

        // this image defines the lower slider
        Rectangle {
            id: minHandle

            property bool hover: false
            color: "red"
            border.color: "darkgrey"
            border.width: 0
            x: groove.x+groove.width-minHandle.width //minHandle.x + sliderMinValue//minMouseArea.baseMaxX - (sliderMinValue / upperLimit * (minMouseArea.baseMaxX - minMouseArea.baseMinX))
            y: groove.y - minHandle.height/2
            width: 30
            height: 50
            anchors.verticalCenter: groove.verticalCenter
            smooth: true
            radius: 5

            states: [
                State {
                    name: "clicked"
                    PropertyChanges {
                        target: minHandle
                        border.width: 2
                    }
                }
            ]

            Text {
                id: minValueText
                text: "00:00:00"
                color: "black"

                anchors.top: minHandle.bottom
                anchors.horizontalCenter: minHandle.horizontalCenter
            }

            MouseArea {
                id: minMouseArea

    //            property int minX: maxHandle.x + maxHandle.width
    //            property int baseMinX: offset
    //            property int baseMaxX: groove.width -  minHandle.width
    //            property int deltaX: baseMaxX - baseMinX

                width:  80
                height: 80
                anchors.centerIn: parent
                hoverEnabled: true
                drag.axis: Drag.XAxis
                drag.target: minHandle
                drag.minimumX: maxHandle.x+maxHandle.width
                drag.maximumX: groove.x+groove.width-minHandle.width

    //            onEntered: {
    //                minHandle.hover = true
    //            }
    //            onExited: {
    //                minHandle.hover = false
    //                minHandle.state = ""
    //            }

                onPressed: {
                    maxHandle.state = ""
                    minHandle.state = "clicked"
                }

                onXChanged: {
                    sliderMinValue = sliderValue*(1 - (minHandle.x+minHandle.width/2)/groove.width)
                    console.log("MinValue: " + sliderMinValue)
                }
            }
        }
    }
}
