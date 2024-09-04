import QtQuick 2.9
import QtQuick.Controls 2.2
import "."
import "../global"

Item {
    anchors.fill: parent
    Column {
        anchors.centerIn: parent
        spacing: 10
        Rectangle {
            id: rec
            width: 600
            height: 300
            border.color: "lightblue"
            color: Config.backgroundColor
            Rectangle {
                x: 10
                y: 40
                width: 100
                height: 100
                border.color: "red"
                color: Config.themeColor
                smooth: true
                antialiasing: true

                MoveAera {
                    anchors.fill: parent
                    onMove: {
                        parent.x += xOffset
                        parent.y += yOffset
                    }
                }
            }
            // Rectangle {
            //     x: 380
            //     y: 40
            //     width: 200
            //     height: 160
            //     border.color: "red"
            //     color: CusConfig.backgroundColor
            //     smooth: true
            //     antialiasing: true
            //     CusTemplateDragBorder {
            //         width: parent.width + borderMargin * 2
            //         height: parent.height + borderMargin * 2
            //         anchors.centerIn: parent
            //         visible: true
            //     }
            // }
        }

        Rectangle {
            width: 600
            height: 300
            border.color: "lightblue"
            color: Config.backgroundColor
            CusRectDraw {
                anchors.fill: parent
            }
        }
    }
}
