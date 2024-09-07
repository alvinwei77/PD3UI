import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
import FluentUI
import "../PD3UI"
import "../global"

Item {
    id: root
    anchors.fill: parent
    property int space_: 20
    property double height_: 60

    Rectangle {
        anchors.fill: parent
        color: "white"
    }

    ListModel {
        id: dish_order_list
    }

    ListModel {
        id: order_list
    }

    property var header_: [
        {
            "name": "序号",
            "width": 30
        },
        {
            "name": "商品名称",
            "width": 100
        },
        {
            "name": "数量",
            "width": 100
        },
        {
            "name": "单价",
            "width": 40
        },
        {
            "name": "价格",
            "width": 40
        },
        {
            "name": "备注",
            "width": 30
        }
    ]

    ColumnLayout {
        id: layout
        anchors.fill: parent
        spacing: 10
        RowLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: 25
            spacing: 15
            Text {
                text: "订单列表:"
                Layout.alignment: Qt.AlignVCenter
            }
            ListView {
                id: orders_
                Layout.fillWidth: true
                Layout.preferredHeight: 25
                clip: true
                orientation: ListView.Horizontal
                model: 5
                spacing: 10
                currentIndex: 0
                delegate: FluButton {
                    id: area
                    width: orders_.currentIndex === index ? 48 : 24
                    height: 24
                    text: index+1
                    font.bold: true
                    font.pixelSize: 12
                    textColor: orders_.currentIndex === index ? "white": "black"
                    background: Rectangle {
                        color: orders_.currentIndex === index  ? "#1684FC": "white"
                        radius: 12
                        border.color: "lightgray"
                        border.width: 1
                    }
                    onClicked: {
                        console.log("select", orders_.currentIndex)
                        orders_.currentIndex = index
                    }

                    Behavior on width {
                        NumberAnimation {
                            duration: 300
                            easing.type: Easing.OutBack
                        }
                    }
                }
                Component.onCompleted: {
                }
            }
            FluIconButton {
                iconSource: FluentIcons.Add
                width: 24
                height: 24
                text: "新增订单"
                display: Button.TextBesideIcon
            }

        }

        ListView {
            id: order_view
            Layout.fillHeight: true
            Layout.fillWidth: true
            rightMargin: 10
            clip: true
            model: dish_order_list
            spacing: space_
            header: Item {
                width: parent.width
                height: 40
                z: 5
                Rectangle {
                    anchors.fill: parent
                    color: "lightgray"
                    border.width: 1
                    border.color: "gray"
                }
                Row {
                    id: title
                    anchors {
                        fill: parent
                        margins: 10
                    }
                    spacing: 10
                    // 序号(Text)，商品名称(Text)，数量(FluSpinBox)，单价(text)，价格(text)，备注(图标按钮)
                    Repeater {
                        model: header_
                        delegate: Item {
                            width: modelData.width
                            height: parent.height
                            Text {
                                text: qsTr(modelData.name)
                                font.bold: true
                                font.pixelSize: 12
                                anchors.centerIn: parent
                            }
                        }
                    }
                }
            }
            headerPositioning: ListView.OverlayHeader
            displaced: Transition {
                NumberAnimation { properties: "x,y"; duration: 1000 }
            }

            delegate: Item {
                width: order_view.width
                height: height_

                Rectangle {
                    anchors {
                        fill: parent
                    }
                    color: index%2===1?"ghostwhite":"white"
                }
                Row {
                    id: item
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 10
                    Item {
                        width: 30
                        height: parent.height
                        Text {
                            id: item_id
                            text: index
                            clip: true
                            font.pixelSize: 12
                            elide: Text.ElideRight
                            wrapMode: Text.NoWrap
                            anchors.centerIn: parent
                        }
                    }
                    Item {
                        width: 100
                        height: parent.height
                        Text {
                            id: item_title
                            width: parent.width
                            text: qsTr(model.name)
                            clip: true
                            font.pixelSize: 12
                            elide: Text.ElideRight
                            wrapMode: Text.NoWrap
                            horizontalAlignment: (contentWidth > width) ? Text.AlignLeft : Text.AlignHCenter
                            anchors.centerIn: parent
                        }
                    }
                    Item {
                        width: 100
                        height: parent.height
                        FluSpinBox {
                            width: 100
                            height: 40
                            value: model.qty
                            anchors.centerIn: parent
                        }
                    }
                    Item {
                        width: 40
                        height: parent.height
                        Text {
                            id: item_price
                            text: `$${model.price}`
                            clip: true
                            font.pixelSize: 12
                            elide: Text.ElideRight
                            wrapMode: Text.NoWrap
                            anchors.centerIn: parent
                        }
                    }
                    Item {
                        width: 40
                        height: parent.height
                        Text {
                            id: item_price_total
                            text: `$${model.price*model.qty}`
                            clip: true
                            font.pixelSize: 12
                            elide: Text.ElideRight
                            wrapMode: Text.NoWrap
                            anchors.centerIn: parent
                        }
                    }
                    Item {
                        width: 30
                        height: parent.height
                        FluIconButton{
                            width: 30
                            iconSource:FluentIcons.Edit
                            iconSize: 15
                            onClicked: {

                            }
                            anchors.centerIn: parent
                        }
                    }
                }
            }
            ScrollBar.vertical: ScrollBar {
                policy: ScrollBar.AsNeeded
                width: 10
                z:4
            }
        }
        RowLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: 100
            Rectangle {
                id: order_info
                color: "lightblue"
                Layout.preferredHeight: 100
                Layout.fillWidth: true
                Column {
                    anchors {
                        fill: parent
                        margins: 20
                    }
                    spacing: 10
                    Item {
                        width: parent.width
                        height: 20
                        Text {
                            text: qsTr("共8件商品")
                            color: "black"
                            font.bold: true
                            font.pixelSize: 15
                        }
                    }
                    Item {
                        width: parent.width
                        height: 30
                        Text {
                            id: left_info_btn
                            text: qsTr("合计")
                            color: "black"
                            font.bold: true
                            font.pixelSize: 25
                        }
                        Text {
                            anchors {
                                left: left_info_btn.right
                                leftMargin: 10
                            }
                            text: qsTr("£"+"1")
                            color: "red"
                            font.bold: true
                            font.pixelSize: 25
                        }
                    }
                }
            }
            Rectangle {
                id: order_btn
                color: "#4A9CE8"
                Layout.preferredHeight: 100
                Layout.fillWidth: true
                Text {
                    text: qsTr("立即下单")
                    anchors.centerIn: parent
                    color: "white"
                    font.bold: true
                    font.pixelSize: 30
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        var arr = [
                    {
                        id: 1,
                        name: "超级长的菜名1111111111",
                        qty: 1,
                        price: 23
                    },
                    {
                        id: 2,
                        name: "test2",
                        qty: 2,
                        price: 29
                    },
                    {
                        id: 3,
                        name: "test3",
                        qty: 2,
                        price: 29
                    },
                    {
                        id: 4,
                        name: "test4",
                        qty: 2,
                        price: 29
                    },
                    {
                        id: 5,
                        name: "test5",
                        qty: 2,
                        price: 29
                    },
                    {
                        id: 5,
                        name: "test5",
                        qty: 2,
                        price: 29
                    },
                    {
                        id: 5,
                        name: "test5",
                        qty: 2,
                        price: 29
                    },
                    {
                        id: 5,
                        name: "test5",
                        qty: 2,
                        price: 29
                    },
                    {
                        id: 5,
                        name: "test5",
                        qty: 2,
                        price: 29
                    },
                ];
        for (var value of arr) {
            dish_order_list.append(value)
        }
    }
}


