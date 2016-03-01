import QtQuick 2.0

Row{
    id: circle

    property int   loadtimer:   4000
    property color circleColor: "transparent"
    property color borderColor: "grey"
    property int   pathWidth:   20
    property alias running:     circleAnimation.running
    property bool  finished:    false;

    function start(){
        circlePart1.rotation = 0
        circlePart2.rotation = 0
        circleAnimation.start()
    }

    function stop(){
        circleAnimation.stop()
    }

    width:  parent.width * 0.8
    height: width

    Item{
        width:  parent.width/2
        height: parent.height
        clip:   true

        Item{
            id:       circlePart1
            width:    parent.width
            height:   parent.height
            clip:     true
            rotation: 0
            transformOrigin: Item.Right

            Rectangle{
                width:        circle.width  - (pathWidth*2)
                height:       circle.height - (pathWidth*2)
                radius:       width/2
                x:            pathWidth
                y:            pathWidth
                color:        circleColor
                border.color: borderColor
                border.width: pathWidth
                smooth:       true
            }
        }
    }

    Item{
        width:  parent.width/2
        height: parent.height
        clip:   true

        Item{
            id:       circlePart2
            width:    parent.width
            height:   parent.height
            clip:     true
            rotation: 0
            transformOrigin: Item.Left

            Rectangle{
                width:        circle.width  - (pathWidth*2)
                height:       circle.height - (pathWidth*2)
                radius:       width/2
                x:           -width/2
                y:            pathWidth
                color:        circleColor
                border.color: borderColor
                border.width: pathWidth
                smooth:       true
            }
        }
    }

    SequentialAnimation{
        id: circleAnimation
        PropertyAnimation{ target: circlePart2; property: "rotation"; to: 180; duration:loadtimer/2 }
        PropertyAnimation{ target: circlePart1; property: "rotation"; to: 180; duration:loadtimer/2 }

        onStopped: finished = true;
    }
}
