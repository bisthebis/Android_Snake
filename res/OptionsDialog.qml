import QtQuick 2.6
import QtQuick.Layouts 1.1
import QtQuick.Window 2.2
import QtQuick.Controls 2.1

Item {
    anchors.fill: parent
    id: rect
    property int speed: speed_spinbox.value

    visible: false
    focus: visible //Get focus only when options are shown
    Keys.onReleased: {
        if (event.key === Qt.Key_Back || event.key === Qt.Key_Backspace) {
            rect.visible = false
            event.accepted = true
            console.log("Left options with back button")
        }
    }

    ColumnLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top

        RowLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            Label {
                text: qsTr("Speed : ")
            }

            SpinBox {
                id: speed_spinbox
                from: 1
                to: 10

                onValueChanged: game_data.setLastSpeed(value)
                Component.onCompleted: value = game_data.lastSpeed

            }
        }

        RowLayout {
            Label {
                text: qsTr("Size : ")
            }
        }

        Button {
            text: qsTr("Done")
            onClicked: rect.visible = false
        }
    }



}
