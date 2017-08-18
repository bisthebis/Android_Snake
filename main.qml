import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.1
import QtQuick.Dialogs 1.2

import be.martin.boris 1.0
import "./res"

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")
    Component.onCompleted: console.log(width + "x" + height)

    GameGrid {
        id: grid
        onLost: lost.visible = true
        onFailedDirectionSwitch: console.log("Failed to go backwards")
    }

    Column {
        visible: false
        Button {
            id: show
            text: qsTr("Print game to stdout")
            onClicked: grid.toStdOut()
        }

        Button {
            id: left
            text: "Left"
            onClicked: {
                grid.advance(GameGrid.LEFT)
                console.log("Left")
                grid.toStdOut()
            }
        }
        Button {
            id: right
            text: "Right"
            onClicked: {
                grid.advance(GameGrid.RIGHT)
                console.log("Right")
                grid.toStdOut()
            }
        }
        Button {
            id: up
            text: "Up"
            onClicked: {
                grid.advance(GameGrid.UP)
                console.log("Up")
                grid.toStdOut()
            }
        }
        Button {
            id: down
            text: "Bottom"
            onClicked: {
                grid.advance(GameGrid.BOTTOM)
                console.log("Bottom")
                grid.toStdOut()
            }
        }
    }

    Slider {
        id: size
        from: 1
        to: 32
        value: 12
    }

    BackgroundArray {
        id: bg_array
        anchors.centerIn: parent
        cell_width: size.value
        cell_height: cell_height
        Component.onCompleted: bg_array.draw(grid)
    }

}
