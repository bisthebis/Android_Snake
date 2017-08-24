import QtQuick 2.7
import QtQuick.Controls 2.1

Dialog {
    property int snakeSize: 0

    title: "Game Over"
    modal: true

    x: (parent.width - width) / 2
    y: (parent.height - height) / 2

    contentItem: TextArea {
        color: "navy"
        text: qsTr("Your snake was %1 cells long").arg(snakeSize)
    }

    standardButtons: Dialog.Ok

    onAccepted: console.log("Ok")

}
