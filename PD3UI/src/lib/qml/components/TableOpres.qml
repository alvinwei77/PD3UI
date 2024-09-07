import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
import FluentUI
import "../PD3UI"

Item {
    id: root
    anchors.fill: parent

    property int width_: 150
    property int height_: 50
    property int space_: 20

    Rectangle {
        anchors.fill: parent
        color: "white"
    }

    ColumnLayout {
        id: body
        anchors {
            fill: parent
            topMargin: space_
            bottomMargin: space_
        }
        spacing: space_
        Item {
            Layout.preferredHeight: height_
            Layout.preferredWidth: width_
            Layout.alignment: Qt.AlignHCenter
            Rectangle {
                id: statusa
                width: 50
                height: 50
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                }
                color: "green"
                radius: 5
                border.color: "lightgray"
                border.width: 1
            }
            Text {
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: statusa.right
                    leftMargin: 20
                }
                text: qsTr("空闲")
                font.pixelSize: 20
                font.bold: true
            }
        }
        Item {
            Layout.preferredHeight: height_
            Layout.preferredWidth: width_
            Layout.alignment: Qt.AlignHCenter
            Rectangle {
                id: statusb
                width: 50
                height: 50
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                }
                color: "blue"
                radius: 5
                border.color: "lightgray"
                border.width: 1
            }
            Text {
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: statusb.right
                    leftMargin: 20
                }
                text: qsTr("已开台")
                font.pixelSize: 20
                font.bold: true
            }
        }
        Item {
            Layout.preferredHeight: height_
            Layout.preferredWidth: width_
            Layout.alignment: Qt.AlignHCenter
            Rectangle {
                id: statusc
                width: 50
                height: 50
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                }
                color: "yellow"
                radius: 5
                border.color: "lightgray"
                border.width: 1
            }
            Text {
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: statusc.right
                    leftMargin: 20
                }
                text: qsTr("已点餐")
                font.pixelSize: 20
                font.bold: true
            }
        }
        FluFilledButton {
            Layout.preferredHeight: height_
            Layout.preferredWidth: width_
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("开台")
            font.bold: true
            font.pixelSize: 20
            normalColor: "green"
        }
        FluFilledButton {
            Layout.preferredHeight: height_
            Layout.preferredWidth: width_
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("点餐")
            font.bold: true
            font.pixelSize: 20
            normalColor: "blue"
        }
        FluFilledButton {
            Layout.preferredHeight: height_
            Layout.preferredWidth: width_
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("结账")
            font.bold: true
            font.pixelSize: 20
            normalColor: "yellow"
            textColor: "black"
        }
        FluButton {
            Layout.preferredHeight: height_
            Layout.preferredWidth: width_
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("外带")
            font.bold: true
            font.pixelSize: 20
        }
    }

}
