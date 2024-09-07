import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
import FluentUI
import "../PD3UI"
import "../global"

Item {
    anchors.fill: parent
    ListModel {
        id: dish_type_list
    }

    // Rectangle {
    //     anchors.fill: parent
    //     color: "lightgray"
    // }

    ListView {
        id: dish_type_view
        anchors.fill: parent
        clip: true
        model: dish_type_list
        delegate: Rectangle {
            id: menu_delegate_
            width: dish_type_view.width
            height: 60
            color: "white"
            Rectangle {
                width: 5
                height: parent.height/2
                anchors.verticalCenter: parent.verticalCenter
                color: dish_type_view.currentIndex === index ? "#4A9CE8" : "white"
            }
            Text {
                text: qsTr(model.text)
                anchors.centerIn: parent
                color: dish_type_view.currentIndex === index ? "#4A9CE8" : "black"
                font.bold: true
                font.pixelSize: 22
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    dish_type_view.currentIndex = index
                }
            }
            onFocusChanged: {
                // update
            }
        }
        Component.onCompleted: {
            // fetch...()
            // forceActiveFocus()

            var arr = ["主食", "热门", "推荐", "酒水", "小菜"]

            for (var value of arr) {
                dish_type_list.append({"text": value})
            }
        }
    }

}
