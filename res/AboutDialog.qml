import QtQuick 2.7
import QtQuick.Controls 2.1

import be.martin.boris 1.0

Dialog {
    title: "About"
    modal: true
    id: dialog

    x: (parent.width - width) * 0.6
    y: (parent.height - height) * 0.6

    contentItem: Flickable {
        width: dialog.width * 0.8
        contentHeight: content.height
        boundsBehavior: Flickable.DragAndOvershootBounds
        clip: true
        Text {
            id: content
            width: dialog.width * 0.8
            wrapMode: Text.Wrap
            color: "navy"
            text: "Text hasn't been loaded."
            Component.onCompleted: getAboutContent()
            }
    }

    standardButtons: Dialog.Ok

    FileReader {
        id: reader
        onFailure: {
            content.text = "Failed to load : " + err
        }

        onTextLoaded: content.text = fileContent;
    }


    function getAboutContent() {
        reader.loadFile(":/res/aboutContent.html")
    }

}
