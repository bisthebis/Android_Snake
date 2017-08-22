import QtQuick 2.6
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1

Item {

    property var gameReference: null
    property alias gameArray: gameArray_internal
    property int cellSize: gameReference.cellSize

    SwipableArea {
        onSwipeDone: gameReference.setDirection(direction)
    }

    //Game widget
    BackgroundArray {
        anchors.centerIn: parent
        id: gameArray_internal
        array_width: gameReference.width
        array_height: gameReference.height
        cell_width: cellSize
        cell_height: cellSize
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
            onClicked: gameReference.newGame()
        }

        Button {
            text: qsTr("Options")
            onClicked: options.visible = !options.visible;
        }
    }


    Label {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 5
        text: "Score : " + score + "\nHighscore : " + game_data.highscore + (score >= game_data.highscore ? " !" : "")
    }
}
