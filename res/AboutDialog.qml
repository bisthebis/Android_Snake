import QtQuick 2.7
import QtQuick.Controls 2.1

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
            text: qsTr("<h1>About this app</h1><p>Lorem ipsum dolor sit amet</p> <p>Quisque interdum bibendum ex, eleifend imperdiet est cursus a. Maecenas neque felis, facilisis eget est in, sagittis vulputate tortor. Nullam sodales lectus in pretium cursus. Duis eleifend mauris sed finibus dapibus. Donec sed fringilla metus. Fusce id risus ullamcorper libero fringilla mollis. Phasellus lobortis pharetra eleifend. Donec elit velit, ultricies vel eros non, accumsan malesuada lacus. Nulla vitae ullamcorper dolor. Nulla iaculis consequat nisi in porta. Nam congue vehicula ante a blandit.</p>
        <p>Sed mi metus, sollicitudin vel massa non, dictum consectetur risus. Ut dictum auctor egestas. Curabitur eleifend sed eros at sollicitudin. Nulla lobortis, purus at placerat pharetra, lacus sem interdum purus, vitae dictum orci dolor ut lectus. Etiam accumsan leo dolor. In vestibulum euismod dictum. Nam iaculis id metus vel maximus. Sed ut erat vestibulum, malesuada nunc consectetur, rhoncus nisi. Integer dignissim volutpat velit, ut sodales nibh fringilla eu. Duis sed luctus odio. Nam placerat urna enim, a imperdiet neque sodales in. Sed non placerat libero. Nullam sit amet massa at ligula ultrices dictum vitae id erat. Duis sagittis eros quis arcu sodales, eget mollis nibh molestie. In fringilla tellus eu turpis vestibulum condimentum.</p>")
            }
    }

    standardButtons: Dialog.Ok

    onAccepted: console.log("Ok")

}
