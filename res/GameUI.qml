import QtQuick 2.6
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1

Item {

    property var gameReference: null

    onGameReferenceChanged: gameArray.draw(gameReference)

    //Game widget
    BackgroundArray {
        anchors.centerIn: parent
        id: gameArray
        cell_width: cellSize
        cell_height: cell_height
        Component.onCompleted: gameArray.draw(gameReference)
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
        text: "Score : " + score + "\nHighscore : " + game_data.highscore + (score >= game_data.highscore ? " !" : "")
    }
}
