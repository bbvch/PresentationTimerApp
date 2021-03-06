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
    minimumWidth:  480
    minimumHeight: 800

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

            if(((event.key===Qt.Key_Menu) || (event.key===Qt.Key_F1)) && (stack.currentItem==timerView)) {
                timerView.pause()
                stack.push("qrc:/SettingsView.qml")
            }
        } // Keys.onReleased

        initialItem: TimerView {
            id: timerView
        }
    } // StackView

    Component.onCompleted: {
        cppPresentationTimer.duration      = cppSettings.duration
        cppPresentationTimer.attentionTime = cppSettings.duration > cppSettings.attentionTime ? cppSettings.attentionTime : 1000
        cppPresentationTimer.finalTime     = cppSettings.duration > cppSettings.finalTime     ? cppSettings.finalTime : 0

        timerView.durationValue = cppPresentationTimer.duration
        timerView.setTimeLabels()
    }

} // Window
