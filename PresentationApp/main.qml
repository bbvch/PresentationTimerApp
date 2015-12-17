import QtQuick 2.4
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2


Window {
    id: mainWindow
    property int currentTime
    property int presentationTime
    property int dpi: Screen.pixelDensity*25.4
    visible: true
    width:  400
    height: 400

    StackView {
        id: stack
        property string searchResultsTitle
        anchors.fill: parent
        width: parent.width
        focus: true

        Keys.onReleased: {
            if ((event.key === Qt.Key_F2 || event.key === Qt.Key_Back) && stack.depth > 1) {
                             event.accepted = true;
                             stack.pop()
            }

            if(((event.key===Qt.Key_Menu)||(event.key===Qt.Key_F1))&&(stack.currentItem==rootView)) {
                console.log("Menu pressed")
                stack.push("qrc:///MenuView.qml")
                console.log(stack.currentItem)
            }
        }

        initialItem: RootView {
            id: rootView
        }
        onCurrentItemChanged:  {
            if(stack.currentItem==rootView)
                rootView.stopwatchValue(cppSettings.presentationTime)
        }

        /*onCurrentItemChanged: {
            if(stack.currentItem!=null)
                if(stack.currentItem.state==="showingRoot")
                    toolbar_text.text = qsTr("PropertyCross")
                else if(stack.currentItem.state==="showingFavourites")
                    toolbar_text.text = qsTr("Favourites")
                else if(stack.currentItem.state==="showingProperty")
                    toolbar_text.text = qsTr("Property Details")
                else if(stack.currentItem.state==="showingResults")
                    toolbar_text.text = stack.searchResultsTitle
        }*/

    } // StackView
} // Window
