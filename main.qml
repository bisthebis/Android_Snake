import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.1
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1

import be.martin.boris 1.0
import "./res"

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")
    onWidthChanged: updateCellSize();
    onHeightChanged: updateCellSize();

    Component.onCompleted: timer.start()

    function updateCellSize() {
        var maxWidth = 0.8 * width / grid.width
        var maxHeight = 0.8 * height / grid.heigth
        cellSize = Math.max(Math.min(maxWidth, maxHeight), 8)
    }


    property int cellSize: 32
    property int speed: 5 //Cells per second

    SwipableArea {
        onSwipeDone: grid.setDirection(direction)
    }

    //Game data
    GameGrid {
        id: grid
        onLost: Qt.quit()
        onFailedDirectionSwitch: console.log("Failed to go backwards")
        onChanged: bg_array.draw(this)
    }

    //Game control
    Timer {
       id: timer
       interval: 1000 / speed
       repeat: true
       onTriggered: grid.advance(grid.lastDirection)
       running: false
    }


    //Game widget
    BackgroundArray {
        anchors.centerIn: parent
        id: bg_array
        cell_width: cellSize
        cell_height: cell_height
        Component.onCompleted: bg_array.draw(grid)
    }

    RowLayout {

        Button {
            text: "Pause"
        }

        Button {
            text: "Options"
        }

        Label {
            text: "Score : " + "TODO"
        }
    }




}
