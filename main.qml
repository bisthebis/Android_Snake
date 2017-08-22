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


    property int cellSize: 32
    property int score: 6 * game.snakeSize

    Component.onCompleted: {
        updateCellSize()
    }

    onWidthChanged: updateCellSize();
    onHeightChanged: updateCellSize();

    function updateCellSize() {
        var maxWidth = 0.8 * window.width / game.width
        var maxHeight = 0.8 * window.height / game.height
        cellSize = Math.max(Math.min(maxWidth, maxHeight), 8)
    }


    onScoreChanged: game_data.setHighscore(Math.max(score, game_data.highscore))

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



    //Game data
    GameGrid {
        id: game
        onLost: Qt.quit()
        onFailedDirectionSwitch: console.log("Failed to go backwards")
        property bool gameRunning: timer.running
        property int cellSize: window.cellSize
        onNewGameStarted: updateCellSize();
        onChanged: {
            ui.gameArray.draw(this)
        }
    }

    //Game control
    Timer {
       id: timer
       interval: 1000 / Math.floor(options.speed)
       repeat: true
       onTriggered: game.advance(game.lastDirection)
       running: false
    }

    GameUI {
        id: ui
        anchors.fill: parent
        gameReference: game
        visible: !launchButton.visible
        onVisibleChanged: if (visible) timer.start()
    }

    Button {
        anchors.centerIn: parent
        id: launchButton
        text: "Launch"
        visible: true
        onClicked: visible = false;
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
