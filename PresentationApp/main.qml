import QtQuick 2.4
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2


Window {
    visible: true
    id: mainWindow
    property int currentTime
    property int presentationTime
    property int dpi: Screen.pixelDensity*25.4
    width: 400
    height: 400
    StackView {
        id:stack
        anchors.fill: parent
        width: parent.width
        focus: true
        property string searchResultsTitle
        /*Keys.onReleased: if ((event.key === Qt.Key_F1 || event.key === Qt.Key_Back) && stack.depth > 1) {
                             event.accepted = true;
                             mainWindow.goBack()
                         }*/

        initialItem: RootView {
            id: rootView
        }
        onCurrentItemChanged: {
            if(stack.currentItem!=null)
                if(stack.currentItem.state==="showingRoot")
                    toolbar_text.text = qsTr("PropertyCross")
                else if(stack.currentItem.state==="showingFavourites")
                    toolbar_text.text = qsTr("Favourites")
                else if(stack.currentItem.state==="showingProperty")
                    toolbar_text.text = qsTr("Property Details")
                else if(stack.currentItem.state==="showingResults")
                    toolbar_text.text = stack.searchResultsTitle

        }



    //Keys.onMenuPressed:
    Keys.onReleased:
    {
    if((event.key==Qt.Key_Menu)||(event.key==Qt.Key_1)) {
        console.log("Menu pressed")
        stack.push("qrc:///MenuView.qml")
    }
    //if(event.key==Qt.Key_1)
       // stack.push("qrc:///MenuView.qml")
    }
}
    Menu {
        title: "test"
        MenuItem {
            text: "Cut"
            shortcut: "Ctrl+X"
        }
    }
}
