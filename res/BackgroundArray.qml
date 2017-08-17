import QtQuick 2.0


Item {

    property int array_width: 12 //Number of cells. Default value
    property int array_height: 8

    property int cell_width: 12
    property int cell_height: 12

    anchors.centerIn: parent


    Column {
        Repeater {
            model: array_height

            Row {

                Repeater {
                    model: array_width
                    Rectangle {
                        id: cell
                        color: "#25e617"
                        border.color: "black"
                        width: cell_width
                        height: cell_width
                    }
                }
            }
        }
    }







}
