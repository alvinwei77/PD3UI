import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
import FluentUI
import "../global"

RowLayout {
    id: root
    anchors.fill: parent
    property var tables : [
        {
            "color": "green",
            "status": "open",
            "counts": 13
        },
        {
            "color": "blue",
            "status": "order",
            "counts": 11
        },
        {
            "color": "darkorange",
            "status": "check",
            "counts": 5
        }
    ]

    Repeater {
        model: tables
        delegate: Row {
            Layout.fillHeight: true
            Layout.preferredWidth: 80
            spacing: 5
            Rectangle {
                width: 30
                height: 30
                radius: 15
                color: modelData.color
                border.width: 1
                border.color: "lightgray"
                anchors.verticalCenter: parent.verticalCenter
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("clicked")
                    }
                }
                Text {
                    color: "white"
                    font.bold: true
                    anchors.centerIn: parent
                    text: modelData.counts
                }
            }
            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: modelData.status
            }
        }
    }

    Item {
        Layout.fillWidth: true
    }

    FluIconButton {
        Layout.preferredWidth: 50
        Layout.fillHeight: true
        iconSource: FluentIcons.GlobalNavButton
        onClicked: {
            SignalManager.tablep_switch_()
        }
    }

    Component.onCompleted: {
        // req
    }

}

