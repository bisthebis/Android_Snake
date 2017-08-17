import QtQuick 2.0


Item {

    property int array_width: 12 //Number of cells. Default value
    property int array_height: 8

    property int cell_width: 12
    property int cell_height: 12

    anchors.centerIn: parent

    Grid {
        id: grid
        columns: array_width
        Repeater {
            model: array_width * array_height
            Rectangle {
                id: cell
                color: "#25e617"
                border.color: "black"
                width: cell_width
                height: cell_width
            }

        }

        function getElement(x, y) {
            console.assert(x >= 0 && x <= array_width)
            console.assert(y >= 0 && y <= array_height)
            var key = x + array_width * y
            return grid.children[key]
        }

    }







}
