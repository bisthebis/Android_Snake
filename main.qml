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
    onWidthChanged: updateCellSize();
    onHeightChanged: updateCellSize();

    function updateCellSize() {
        var maxWidth = 0.8 * width / grid.width
        var maxHeight = 0.8 * height / grid.heigth
        cellSize = Math.max(Math.min(maxWidth, maxHeight), 8)
    }

    property int cellSize: 32

    SwipableArea {
        onSwipeDone: grid.setDirection(direction)
    }


    GameGrid {
        id: grid
        onLost: Qt.quit()
        onFailedDirectionSwitch: console.log("Failed to go backwards")
        onChanged: bg_array.draw(this)
    }

    Timer {
       interval: 1000 / speed.value
       repeat: true
       onTriggered: grid.advance(grid.lastDirection)
       running: true
    }

    Slider {
        id: speed
        from: 1
        to: 20
        value: 5
    }

    BackgroundArray {
        id: bg_array
        anchors.centerIn: parent
        cell_width: cellSize
        cell_height: cell_height
        Component.onCompleted: bg_array.draw(grid)
    }

}
