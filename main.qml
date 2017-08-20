import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.1
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1

import be.martin.boris 1.0
import "./res"

Window {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("Snake")
    onWidthChanged: updateCellSize();
    onHeightChanged: updateCellSize();

    Component.onCompleted: timer.start()

    Item {
        id: keyboard_input
        focus: true

        //Android specific
        Keys.onReleased: {
            if (event.key === Qt.Key_Back || event.key === Qt.Key_Backspace) {
                console.log("No return allowed !")
                event.accepted = true
            }
        }
    }

    function updateCellSize() {
        var maxWidth = 0.8 * width / grid.width
        var maxHeight = 0.8 * height / grid.heigth
        cellSize = Math.max(Math.min(maxWidth, maxHeight), 8)
    }


    property int cellSize: 32
    property int speed: options.speed //Cells per second

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
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        Button {
            text: timer.running ? qsTr("Pause") : qsTr("Unpause")
            onClicked: timer.running = !timer.running
        }

        Button {
            text: qsTr("Restart")
        }

        Button {
            text: qsTr("Options")
            onClicked: options.visible = true;
        }
    }


    Label {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 5
        text: "Score : " + 6 * grid.snakeSize
    }

    //Options dialog
    OptionsDialog {
        anchors.fill: parent
        id: options
        onVisibleChanged: {
            timer.stop()
            keyboard_input.forceActiveFocus()
        }
    }




}
