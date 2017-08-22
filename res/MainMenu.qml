import QtQuick 2.6
import QtQuick.Controls 2.1

Item {
    anchors.fill: parent
    id: menu
    property var gameReference

    Button {
        text: qsTr("Play")
        anchors.centerIn: parent
        id: launchButton
        visible: true
        onClicked: {
            gameReference.newGame()
            menu.visible = false;
        }
    }
}
