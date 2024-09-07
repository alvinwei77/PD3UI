import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
import "../global"

Item {
    id: keyboard
    property var keyboradData: [1, 2, 3, "Qty", 4, 5, 6, " ", 7, 8, 9, " ", "+", 0, "-", "<-"]
    property string activeKey: ""

    Rectangle {
        id: payment_btn
        width: parent.width*0.4
        height: parent.height
        anchors {
            left: parent.left
        }
        color: paymentMouse.containsMouse? "lightpurple": "purple"
        Text {
            text: qsTr(">")
            font.bold: true
            font.pixelSize: 20
            color: "white"
            anchors {
                bottom: paymentMark.top
                bottomMargin: 5
                horizontalCenter: parent.horizontalCenter
            }
        }
        Text {
            id: paymentMark
            text: qsTr("Payment")
            font.bold: true
            font.pixelSize: 20
            color: "white"
            anchors {
                centerIn: parent
            }
        }
        MouseArea {
            id: paymentMouse
            anchors.fill: parent
            onClicked: {
                // open payment dialog
                SignalManager.paymentDiaOpen_()
            }
            hoverEnabled: true
        }
    }

    GridLayout {
        id: gridView
        width: parent.width*0.6
        height: parent.height
        anchors {
            right: parent.right
            left: payment_btn.right
        }
        columns: 4
        rows: 4
        columnSpacing: 0
        rowSpacing: 0
        Repeater {
            model: keyboradData
            delegate: Rectangle {
                id: key_
                Layout.fillWidth: true
                Layout.fillHeight: true
                radius: 0
                color: item_text.text === activeKey ? "lightgray" :"white"
                border.width: 1
                border.color: "lightgray"
                Text {
                    id: item_text
                    color: "black"
                    font.bold: true
                    font.pixelSize: 10
                    text: modelData.toString()
                    anchors.centerIn: parent
                }
                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    onClicked: {
                        if (item_text.text === "Qty" && activeKey === item_text.text) {
                            activeKey = ""
                        } else if (item_text.text === "Qty" && activeKey!==item_text.text){
                            activeKey = item_text.text
                        } else {
                            if (activeKey!== ""){
                               console.log("send signal", activeKey, item_text.text)
                               SignalManager.pPropertyChange_(item_text.text, activeKey)
                            }
                        }
                    }
                    hoverEnabled: true
                }
            }
        }
    }
}
