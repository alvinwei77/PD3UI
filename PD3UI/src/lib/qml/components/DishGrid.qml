import QtQuick 2.15

Item {
    id: root
    anchors.fill: parent
    Rectangle {
        anchors.fill: parent
        color: "lightgray"
    }

    ListModel {
        id: dish_list
    }

    property int cols: 4

    GridView {
        id: gridview
        anchors.fill: parent
        anchors.margins: 30
        cellWidth: gridview.width / cols
        cellHeight: gridview.width / cols
        model: dish_list

        delegate: Rectangle {
            id: table
            width: gridview.cellWidth - 30
            height: gridview.cellWidth - 30
            color: gridview.currentIndex === index ? "#4A9CE8" : "white"
            Text {
                id: dish_id
                text: `#${model.id}`
                font.bold: true
                font.pixelSize: 20
                font.weight: 10
                color: gridview.currentIndex === index ? "white" : "black"
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    bottom: dish_name.top
                    bottomMargin: 10
                }
            }
            Text {
                id: dish_name
                text: model.name
                font.bold: true
                font.pixelSize: 20
                color: gridview.currentIndex === index ? "white" : "black"
                anchors {
                    centerIn: parent
                    verticalCenterOffset: 5
                }
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    gridview.currentIndex = index
                }
            }
        }
    }

    Component.onCompleted: {
        var arr = [
                    {
                        id: 1,
                        name: "油焖大虾"
                    },
                    {
                        id: 1,
                        name: "油焖大虾"
                    },
                    {
                        id: 1,
                        name: "油焖大虾"
                    },
                    {
                        id: 1,
                        name: "油焖大虾"
                    },
                    {
                        id: 1,
                        name: "油焖大虾"
                    },
                    {
                        id: 1,
                        name: "油焖大虾"
                    },
                    {
                        id: 1,
                        name: "油焖大虾"
                    },
                    {
                        id: 1,
                        name: "油焖大虾"
                    },
                ]
        for (var value of arr) {
            dish_list.append(value)
        }
    }
}