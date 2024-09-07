import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
import FluentUI
import "../global"

Item {
    id:root
    anchors.fill: parent

    property int space_: 30

    Rectangle {
        anchors.fill: parent
        color: "white"
    }

    Component.onCompleted: {
        console.log(root.width, root.height)
    }

    ColumnLayout {
        id: body
        anchors {
            fill: parent
            topMargin: space_
            bottomMargin: space_
        }
        spacing: space_

        Text {
            text: qsTr("用餐人数")
            font.bold: true
            font.pixelSize: 30
            Layout.alignment: Qt.AlignHCenter
        }

        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: 100
            FluTextBox {
                id: customerNum
                anchors {
                    fill: parent
                    margins: space_
                }
                height: 60
                // Layout.alignment: Qt.AlignHCenter
                font.pixelSize: 20
                font.bold: true
                placeholderText: qsTr("请输入用餐人数...")
            }
        }

        Rectangle {
            color: "#E8E9EA"
            Layout.fillWidth: true
            Layout.fillHeight: true
            GridLayout {
                id: gridView
                anchors {
                    fill: parent
                    margins: space_
                }
                columns: 3
                rows: 4
                columnSpacing: 10
                rowSpacing: 10
                anchors.centerIn: parent
                Repeater {
                    model: [1, 2, 3, 4, 5, 6, 7, 8, 9, "<-", 0, "x"]
                    delegate: Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        radius: 10
                        color: "white"
                        Text {
                            id: item_text
                            color: "black"
                            font.bold: true
                            font.pixelSize: 20
                            text: modelData.toString()
                            anchors.centerIn: parent
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                if (item_text.text === "x") {
                                    customerNum.text = ""
                                }
                                else if (item_text.text === "<-") {
                                    customerNum.text = customerNum.text.slice(0, -1);
                                } else {
                                    customerNum.text += item_text.text;
                                }
                            }
                        }
                    }
                }
            }
        }
        RowLayout {
            Rectangle {
                id: cancel_btn
                width: 200
                height: 60
                Layout.alignment: Qt.AlignLeft
                color: "white"
                border.color: "#2D8CF0"
                border.width: 1

                Text {
                    text: qsTr("取消")
                    color: "#2D8CF0"
                    font.bold: true
                    font.pixelSize: 20
                    anchors.centerIn: parent
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        customerNum.text = ""
                        SignalManager.tablep_open_()
                    }
                }
            }

            Item {
                Layout.fillWidth: true
            }

            Rectangle {
                id: confirm_btn
                width: 200
                height: 60
                Layout.alignment: Qt.AlignRight
                color: "#2D8CF0"
                border.color: "#2D8CF0"
                border.width: 1

                Text {
                    text: qsTr("开台")
                    color: "white"
                    font.bold: true
                    font.pixelSize: 20
                    anchors.centerIn: parent
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        // open table
                        // update status
                        //SignalManager.tableModelUpdated(table_id)

                        if (confirm_btn_status)
                        {
                            if(orderManager.createOrder(table_id, costomerNum))
                            {
                                dialog_root.close()
                                mask.visible = false
                                costomerNum = ""
                                confirm_btn_status = false
                                //update tables
                                tableManager.updateTableStatus(table_id, 1)
                                //redirect
                                SignalManager.tableModelUpdated(table_id)
                            }
                        }
                    }
                }

                Component.onCompleted: {

                }
            }
        }
    }
}
