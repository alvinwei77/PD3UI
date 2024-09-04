import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
import FluentUI

Item {
    id: root
    anchors.fill: parent

    Rectangle {
        anchors.fill: parent
        color: "lightgray"
    }

    ListModel {
        id: table_list
    }

    GridView {
        id: gridview
        height: parent.height * 0.8
        anchors {
            top: parent.top
            right: parent.right
            left: parent.left
            margins: 30
        }

        cellWidth: 160
        cellHeight: 160

        model: table_list
        delegate: Rectangle {
            id: table
            width: 140
            height: 140
            radius: 25
            color: "green"
            border.color: "gray"
            border.width: 1

            Text {
                id: space
                text: `(${model.tspacetaken}/${model.tspace})`
                font.bold: true
                font.pixelSize: 16
                color: "white"
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    bottom: tableID.top
                    bottomMargin: 10
                }
            }
            Text {
                id: tableID
                text: model.tid
                font.bold: true
                font.pixelSize: 39
                color: "white"
                anchors {
                    centerIn: parent
                    topMargin: 5
                }
            }
        }
    }

    ListView {
        id: pg
        width: contentItem.width
        anchors {
            top: gridview.bottom
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
        }
        orientation: Qt.Horizontal
        currentIndex: 0
        spacing: 20
        model: 3

        delegate: FluRadioButton {
            id: pg_button
            checked: pg.currentIndex === index
            anchors {
                verticalCenter: parent.verticalCenter
            }
            onClicked: {
                pg.currentIndex = index
            }
            clickListener: function() {}
        }
    }

    Component.onCompleted: {
        // req table list by area id
        var arr = ["A11", "A12"];
        for (var value of arr) {
            table_list.append({"tid": value, "tspace": 4, "tspacetaken": 3})
        }
    }
}
