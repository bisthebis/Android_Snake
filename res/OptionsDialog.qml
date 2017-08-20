import QtQuick 2.6
import QtQuick.Layouts 1.1
import QtQuick.Window 2.2
import QtQuick.Controls 2.1

Rectangle {
    anchors.fill: parent
    id: rect
    property int speed: speed_slider.value

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

        RowLayout {
            Label {
                text: qsTr("Speed : ")
            }

            Slider {
                id: speed_slider
                snapMode: Slider.SnapAlways
                from: 1
                to: 10
                value: 5
                stepSize: 1
                onValueChanged: console.log("New speed : " + value)
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
