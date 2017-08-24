import QtQuick 2.7
import QtQuick.Controls 2.1

import be.martin.boris 1.0

Dialog {
    title: "About"
    modal: true
    id: dialog

    x: (parent.width - width) / 2
    y: (parent.height - height) / 2

    contentItem: Flickable {
        width: dialog.width
        contentHeight: content.height
        boundsBehavior: Flickable.DragAndOvershootBounds
        clip: true
        Text {
            id: content
            width: dialog.width
            wrapMode: Text.Wrap
            color: "navy"
            text: "Error"
            Component.onCompleted: getAboutContent()
            }
    }

    standardButtons: Dialog.Ok

    FileReader {
        id: reader
        onFailure: content.text = "Failed to load"
        onTextLoaded: content.text = fileContent;
    }


    function getAboutContent() {
        reader.loadFile(":/res/aboutContent.html")
    }

}
