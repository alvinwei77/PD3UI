import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
import FluentUI

Item {
    id: root
    anchors.fill: parent

    Rectangle {
        anchors.fill: parent
        color: "white"
    }

    ListModel {
        id: area_list
    }

    ListView {
        id: area_lv
        width: parent.width
        anchors {
            verticalCenter: parent.verticalCenter
        }
        height: 50
        clip: true
        orientation: ListView.Horizontal
        model: area_list
        spacing: 20
        currentIndex: 0

        delegate: FluButton {
            id: area
            width: 110
            height: 50
            text: model.text
            font.bold: true
            font.pixelSize: 15
            textColor: area_lv.currentIndex === index ? "white": "black"
            background: Rectangle {
                color: area_lv.currentIndex === index  ? "#1684FC": "white"
                radius: 15
                border.color: "lightgray"
                border.width: 1
            }
            onClicked: {
                console.log("select", area_lv.currentIndex)
                area_lv.currentIndex = index
            }
        }
        Component.onCompleted: {
        }
    }

    Component.onCompleted: {
        // reqeust area list
        var arr = ["一楼大厅", "二楼包厢", "3楼包厢", "一楼大厅", "二楼包厢", "3楼包厢", "一楼大厅", "二楼包厢", "3楼包厢", "一楼大厅", "二楼包厢", "3楼包厢"];
        for (var value of arr) {
            area_list.append({"text": value})
        }
    }
}
