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

    color: "lightgreen"


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

    ResultDialog {
        id: resultDialog
        width: window.width / 2
        snakeSize: game.snakeSize
        visible: false
        onVisibleChanged: {
            if (visible) {
                scoreTimer.restart()
            }
        }

        Timer {
            id: scoreTimer
            interval: 3000
            repeat: false
            onTriggered: resultDialog.visible = false
        }
    }

    Item {
        id: keyboard_input
        focus: true


        //Android specific
        Keys.onReleased: {
            if (event.key === Qt.Key_Back || event.key === Qt.Key_Backspace) {
                if (options.visible)
                {
                    options.visible = false
                    timer.running = true
                    console.log("Hiding options")
                }
                else if (ui.visible)
                {
                    menu.visible = true
                    console.log("Leaving game through back key")
                }
                else {
                    console.log("KeyPressed during menu. leaving the game")
                    Qt.quit()
                }

                event.accepted = true

            }
        }
    }



    //Game data
    GameGrid {
        id: game
        onLost: {
            //Show score then go back to menu
            console.log("Defeat")
            timer.stop()
            resultDialog.visible = true
            menu.visible = true
        }

        onFailedDirectionSwitch: console.log("Failed to go backwards")
        property bool gameRunning: timer.running
        property int cellSize: window.cellSize
        onNewGameStarted: {
            updateCellSize();
            keyboard_input.focus = true;
        }

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
        visible: !menu.visible
        onVisibleChanged: if (visible) timer.start()
    }

    MainMenu {
        id: menu
        gameReference: game
        visible: true
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
