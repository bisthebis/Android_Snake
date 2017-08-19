import QtQuick 2.0
import be.martin.boris 1.0

MouseArea {
    anchors.fill: parent

    signal swipeDone(var direction);

    property vector2d origin: Qt.vector2d(0,0)
    property vector2d destination: Qt.vector2d(0,0)

    onPressed: origin = Qt.vector2d(mouse.x, mouse.y)
    onReleased: {
        destination = Qt.vector2d(mouse.x, mouse.y)
        var difference = destination.minus(origin)
        var x = difference.x
        var y = difference.y
        if (difference.length() > 25) {
            //lateral move
            if (Math.abs(x) >= Math.abs(y)) {
                if (x > 0) {
                    swipeDone(GameGrid.RIGHT);
                }
                else
                    swipeDone(GameGrid.LEFT)
            }//Vertical move
            else {
                if (y > 0)
                    swipeDone(GameGrid.BOTTOM)
                else
                    swipeDone(GameGrid.UP)
            }
        }
    }
}
