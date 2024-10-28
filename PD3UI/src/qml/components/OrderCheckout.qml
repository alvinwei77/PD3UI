import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
import FluentUI
import "../global"
import "mockData.js" as MockData

Item {
    id: root
    anchors.fill: parent
    property int id_: 0
    property string defaultDiningOption: "堂食"

    Rectangle {
        anchors.fill: parent
        color: "white"
    }

    ListModel {
        id: orderList
        ListElement { text: "订单1" }
        ListElement { text: "订单2" }
        ListElement { text: "+" }
    }

    ListModel {
        id: area_list
    }

    Column {
        anchors.fill: parent

        // 顶部订单栏和添加按钮
        ListView {
            id: orderListView
            width: parent.width
            height: 50
            clip: true
            orientation: ListView.Horizontal
            model: orderList
            spacing: 10
            currentIndex: 0

            delegate: FluButton {
                id: orderButton
                width: index === orderList.count - 1 ? 40 : 80
                height: 40
                font.bold: true
                font.pixelSize: 12

                // 设置按钮文本和样式
                text: model.text
                textColor: orderListView.currentIndex === index ? "white" : index === orderList.count - 1 ? "white" : "black"
                background: Rectangle {
                    color: index === orderList.count - 1 ? "blue" : (orderListView.currentIndex === index ? "#1684FC" : "white")
                    radius: index === orderList.count - 1 ? 20 : 10
                    border.color: "lightgray"
                    border.width: 1
                }

                // 点击事件
                onClicked: {
                    if (index === orderList.count - 1) {
                        // 添加新订单项在添加按钮之前
                        let newOrderNumber = orderList.count;
                        orderList.insert(orderList.count - 1, { "text": "订单" + newOrderNumber });
                        console.log("新订单添加: 订单" + newOrderNumber);
                    } else {
                        // 设置当前选择的订单
                        orderListView.currentIndex = index
                        console.log("选择了订单:", orderButton.text)
                    }
                }
            }
        }

        // 顶部选择栏和搜索框
        RowLayout {
            width: parent.width
            height: 50
            spacing: 20
            anchors.margins: 10

            // 左侧选择器部分
            ColumnLayout {
                width: parent.width * 0.6

                // 桌号选择
                RowLayout {
                    spacing: 5
                    Text {
                        text: "桌号"
                        font.bold: true
                        font.pixelSize: 15
                    }
                    ComboBox {
                        id: tableComboBox
                        width: 200
                        model: ["A1", "A2", "A3", "A4", "A5", "A6", "A7", "A8", "A9", "A10",
                                "A11", "A12", "A13", "A14", "A15", "A16", "A17", "A18", "A19", "A20", "A21", "A22"]
                        currentIndex: root.id_  // 设置初始选项为桌号对应索引
                        onCurrentIndexChanged: console.log("桌号选择为：" + currentText)
                        /*
                        // 自定义下拉按钮样式
                        background: Rectangle {
                            color: "white"
                            border.color: "gray"
                            border.width: 1
                            radius: 5
                        }
                        down: Rectangle {
                            width: 30
                            height: parent.height
                            color: "blue"
                            radius: 5
                            Text {
                                anchors.centerIn: parent
                                text: "▼"
                                color: "white"
                                font.bold: true
                            }
                        }*/
                    }
                }

                // 用餐方式选择
                RowLayout {
                    spacing: 5
                    Text {
                        text: "用餐方式"
                        font.bold: true
                        font.pixelSize: 15
                    }
                    ComboBox {
                        id: diningComboBox
                        width: 200
                        model: ["堂食", "自提", "外送", "其他"]
                        currentIndex: model.indexOf(defaultDiningOption)  // 设置初始选项为“堂食”
                        onCurrentIndexChanged: console.log("用餐方式选择为：" + currentText)

                        // 自定义下拉按钮样式
                        /*
                        background: Rectangle {
                            color: "white"
                            border.color: "gray"
                            border.width: 1
                            radius: 5
                        }
                        down: Rectangle {
                            width: 30
                            height: parent.height
                            color: "blue"
                            radius: 5
                            Text {
                                anchors.centerIn: parent
                                text: "▼"
                                color: "white"
                                font.bold: true
                            }
                        }*/
                    }
                }
            }

        // 右侧搜索框
        TextField {
            id: searchField
            width: parent.width * 0.35
            placeholderText: "搜索..."
            font.pixelSize: 15
        }
    }

        // 表头部分
        Rectangle {
            width: parent.width
            height: 50
            color: "lightgray"

            RowLayout {
                anchors.fill: parent
                anchors.margins: 10

                Text {
                    text: "序号"
                    font.bold: true
                    font.pixelSize: 15
                    color: "black"
                    elide: Text.ElideRight
                    Layout.preferredWidth: parent.width / 6
                }

                Text {
                    text: "商品名称"
                    font.bold: true
                    font.pixelSize: 15
                    color: "black"
                    elide: Text.ElideRight
                    Layout.preferredWidth: parent.width / 6
                }

                Text {
                    text: "数量"
                    font.bold: true
                    font.pixelSize: 15
                    color: "black"
                    elide: Text.ElideRight
                    Layout.preferredWidth: parent.width / 6
                }

                Text {
                    text: "单价"
                    font.bold: true
                    font.pixelSize: 15
                    color: "black"
                    elide: Text.ElideRight
                    Layout.preferredWidth: parent.width / 6
                }

                Text {
                    text: "价格"
                    font.bold: true
                    font.pixelSize: 15
                    color: "black"
                    elide: Text.ElideRight
                    Layout.preferredWidth: parent.width / 6
                }

                Text {
                    text: "状态"
                    font.bold: true
                    font.pixelSize: 15
                    color: "black"
                    elide: Text.ElideRight
                    Layout.preferredWidth: parent.width / 6
                }
            }
        }

        ListView {
            id: listView
            width: parent.width
            height: parent.height - 200
            model: area_list

            delegate: Rectangle {
                id: area
                width: listView.width
                height: 50
                color: index % 2 === 0 ? "grey" : "white"

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 10

                    Text {
                        text: index + 1
                        font.bold: true
                        font.pixelSize: 15
                        color: "black"
                        elide: Text.ElideRight
                        Layout.preferredWidth: area.width / 6
                    }

                    Text {
                        text: model.name
                        font.bold: true
                        font.pixelSize: 15
                        color: "black"
                        elide: Text.ElideRight
                        Layout.preferredWidth: area.width / 6
                    }

                    Text {
                        text: model.count
                        font.bold: true
                        font.pixelSize: 15
                        color: "black"
                        elide: Text.ElideRight
                        Layout.preferredWidth: area.width / 6
                    }

                    Text {
                        text: model.price
                        font.bold: true
                        font.pixelSize: 15
                        color: "black"
                        elide: Text.ElideRight
                        Layout.preferredWidth: area.width / 6
                    }

                    Text {
                        text: model.price * model.count
                        font.bold: true
                        font.pixelSize: 15
                        color: "black"
                        elide: Text.ElideRight
                        Layout.preferredWidth: area.width / 6
                    }

                    Text {
                        text: model.status
                        font.bold: true
                        font.pixelSize: 15
                        color: "black"
                        elide: Text.ElideRight
                        Layout.preferredWidth: area.width / 6
                    }
                }
            }
        }

        // 底栏：总价显示和按钮
        Rectangle {
            width: parent.width
            height: 50
            color: "lightblue"

            RowLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 20

                // 总价模块
                RowLayout {
                    Layout.alignment: Qt.AlignLeft
                    spacing: 5
                    Text {
                        text: "总价"
                        color: "black"
                        font.bold: true
                        font.pixelSize: 15
                    }
                    Text {
                        text: "£"
                        color: "red"
                        font.bold: true
                        font.pixelSize: 18
                    }
                    Text {
                        text: calculateTotal()  // 总价计算
                        color: "black"
                        font.bold: true
                        font.pixelSize: 15
                    }
                }

                // 将按钮区域放在右侧
                Item {
                    Layout.alignment: Qt.AlignRight
                    width: 160
                    height: parent.height

                    RowLayout {
                        anchors.fill: parent
                        spacing: 0  // 按钮之间无间隙

                        // 加菜按钮
                        FluButton {
                            id: addDishButton
                            width: 80
                            height: parent.height  // 与底栏高度一致
                            text: "加菜"
                            font.bold: true
                            textColor: "white"
                            background: Rectangle {
                                color: "blue"
                                radius: 5
                            }
                            onClicked: {
                                showError("加菜按钮被点击");
                                SignalManager.updateOrderPage_(root.id_);
                                showError("信号传输为" + root.id_);
                                FluRouter.navigate("/order");
                                showError("router good");//实际上没有正常导航到对应页面
                            }
                        }

                        // 埋单按钮
                        FluButton {
                            id: checkoutButton
                            width: 80
                            height: parent.height  // 与底栏高度一致
                            text: "埋单"
                            font.bold: true
                            textColor: "white"
                            background: Rectangle {
                                color: "blue"
                                radius: 5
                            }
                            onClicked: {
                                showError("埋单按钮被点击");
                            }
                        }
                    }
                }
            }
        }

    }
    // 计算总价
    function calculateTotal() {
        var total = 0;
        for (var i = 0; i < area_list.count; i++) {
            var item = area_list.get(i);
            total += item.price * item.count;
        }
        return total;
    }


    Connections {
        target: SignalManager
        function onCheckoutp_show(id) {
            root.id_ = id
        }
    }

    Component.onCompleted: {
        // 调用模拟请求并获取响应
        var response = MockData.getAreaList();

        if (response.success) {
            // 请求成功，填充数据
            for (var i = 0; i < response.data.length; i++) {
                area_list.append(response.data[i]);
            }
        } else {
            // 请求失败，打印错误信息
            showError("请求失败，错误信息: " + response.error);
        }
    }
}
