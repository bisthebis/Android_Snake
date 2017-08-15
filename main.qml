import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.1
import QtQuick.Dialogs 1.2

import be.martin.boris 1.0

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    MouseArea {
        anchors.fill: parent
        onClicked: {
            console.log(qsTr('Clicked on background. Text: "' + textEdit.text + '"'))
        }
    }

    MessageDialog {
        id: lost
        text: "You lost !"
        onAccepted: {
                Qt.quit()
            }
    }

    GameGrid {
        id: grid
        onLost: lost.visible = true
        onFailedDirectionSwitch: console.log("Failed to go backwards")
    }

    Column {
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

    TextEdit {
        id: textEdit
        text: qsTr("Enter some text...")
        verticalAlignment: Text.AlignVCenter
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 20
        Rectangle {
            anchors.fill: parent
            anchors.margins: -10
            color: "transparent"
            border.width: 1
        }
    }
}
