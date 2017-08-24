import QtQuick 2.6
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1

Item {
    anchors.fill: parent
    id: menu
    property var gameReference
    signal optionsAsked()
    signal aboutAsked()

    ColumnLayout {
        anchors.centerIn: parent
        width: parent.width * 0.75
        spacing: 20
        Button {
            anchors.left: parent.left
            anchors.right: parent.right
            text: qsTr("Play")
            id: launchButton
            visible: true
            onClicked: {
                gameReference.newGame()
                menu.visible = false;
            }
        }

        Button {
            anchors.left: parent.left
            anchors.right: parent.right
            text: qsTr("Options")
            onClicked: optionsAsked()
        }

        Button {
            anchors.left: parent.left
            anchors.right: parent.right
            text: qsTr("About")
            onClicked: aboutAsked()
        }
    }
}
