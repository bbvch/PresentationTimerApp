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
    minimumWidth:  400
    minimumHeight: 600

    StackView {
        id: stack
        property string searchResultsTitle
        anchors.fill: parent
        focus:        true

        Keys.onReleased: {
            if ((event.key === Qt.Key_F2 || event.key === Qt.Key_Back) && stack.depth > 1) {
                             event.accepted = true;
                             stack.pop()
            }

            if(((event.key===Qt.Key_Menu)||(event.key===Qt.Key_F1))&&(stack.currentItem==rootView)) {
                console.log("Menu pressed")
                rootView.pausePresentation()
                stack.push("qrc:///MenuView.qml")
                console.log(stack.currentItem)
            }
        }

        initialItem: RootView {
            id: rootView
        }

        onCurrentItemChanged:  {
            if(stack.currentItem==rootView)
                rootView.stopWatchValue(cppSettings.presentationTime)
        }
    } // StackView
} // Window
