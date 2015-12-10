import QtQuick 2.0
import QtQuick.Controls 1.4

Rectangle {
    width: mainWindow.width/3
    height: mainWindow.height/10
    property bool checked: false
    //style:

    //onClicked: checked = !checked
    Image {
        source: checked ? "resources/btn_time.png" : "resources/btn_percentage.png"
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
    }
    MouseArea {
        anchors.fill: parent
        onClicked: checked = !checked
    }
}

