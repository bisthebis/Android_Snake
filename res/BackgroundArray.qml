import QtQuick 2.0


Item {

    property int array_width: 12 //Number of cells. Default value
    property int array_height: 8

    property int cell_width: 12
    property int cell_height: 12

    anchors.centerIn: parent
    anchors.horizontalCenterOffset: - array_width * cell_width / 2
    anchors.verticalCenterOffset: - array_height * cell_height / 2

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

                state: "empty"

                Image {
                    z: 1
                    id: tile
                    state: parent.state
                    anchors.centerIn: parent
                    fillMode: Image.Stretch
                    width: parent.width * 0.8
                    height: parent.height * 0.8
                    states: [
                        State {
                            name: "food"
                            PropertyChanges {
                                target: tile
                                source: "qrc:/res/food.png"
                                visible: true
                            }
                        },
                        State {
                            name: "empty"
                            PropertyChanges {
                                target: tile
                                visible: false
                            }
                        },
                        State {
                            name: "snake"
                            PropertyChanges {
                                target: tile
                                source: "qrc:/res/snake_part.png"
                                visible: true
                            }
                        }

                    ]
                }
            }



        }

        function getElement(x, y) {
            console.assert(x >= 0 && x <= array_width)
            console.assert(y >= 0 && y <= array_height)
            var key = x + array_width * y
            return grid.children[key]
        }

        Component.onCompleted: {
            console.log("Hi")
            getElement(0,0).state = "snake"
            getElement(4,7).state = "food"
        }

    }







}
