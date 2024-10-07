import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
import FluentUI
import "../global"

Item {
    id: root
    anchors.fill: parent
    property int id: 0
    Rectangle {
        anchors.fill: parent
        color: "white"
    }

    ListModel {
        id: area_list
    }

    Text {
        text: "桌號" + root.id
    }

    ListView {
        id: area_lv
        width: parent.width
        anchors {
            verticalCenter: parent.verticalCenter
        }
        height: parent.height
        clip: true
        orientation: ListView.Vertical
        model: area_list
        spacing: 0
        currentIndex: 0

        delegate: FluButton {
            id: area
            width: parent.width
            height: 50
            text: model.name + " " + model.price + " " + model.count + "(" + model.unit + ")"
            font.bold: true
            font.pixelSize: 15
            textColor: "black"
            background: Rectangle {
                color: index % 2 == 0 ? "white" : "grey"
                border.color: "lightgray"
                border.width: 0
            }
            onClicked: {
                console.log("select", area_lv.currentIndex)
                area_lv.currentIndex = index
                SignalManager.tablep_area_focus_(area_lv.id) //调用发送器发送信号
            }
        }
        Component.onCompleted: {
        }
    }

    Component.onCompleted: {
        // reqeust area list
        var arr = [{"name":"油燜大蝦","price":30,"count":1,"unit":"份"},
                {"name":"數量不是整數","price":45,"count":5.5,"unit":"斤"},
                {"name":"價格是小數","price":15.99,"count":1,"unit":"份"},
                {"name":"名字很長很長的燙燙燙錕斤拷燙燙燙錕斤拷燙燙燙錕斤拷燙燙燙錕斤拷","price":1,"count":10000,"unit":"份"}];
        for (var defaultValue of arr) {
            area_list.append(defaultValue)
        }
        /*var res = areaManager.fetchArea()
        if (res.success){
            for (var value of res.records) {
                area_list.append({"name": value.name, id: value.id})
            }
        } else {
            for (var defaultValue of arr) {
                area_list.append(defaultValue)
            }

            showError(res.error);
        }*/
    }
}
