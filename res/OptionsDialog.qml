import QtQuick 2.6
import QtQuick.Layouts 1.1
import QtQuick.Window 2.2
import QtQuick.Controls 2.1

Window {

    property int speed: speed_slider.value

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
            text: qsTr("Restart game")
        }
    }



}
