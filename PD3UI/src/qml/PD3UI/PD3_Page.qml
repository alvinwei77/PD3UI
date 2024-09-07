import QtQuick 2.15
import "../global"
import "../PD3UI"

Item {
    id: root
    clip:true
    default property alias content: contentArea.data
    required property string title

    // 页面边距
    anchors {
        fill: parent
        margins: GlobalModel.pageMargin
    }

    // 背景颜色
    Rectangle {
        anchors.fill: parent
        color: GlobalModel.pageColor
    }

    Item {
        id: contentArea
        anchors.fill: parent
    }

    Component.onCompleted: {
        console.log(`loaded ${title} page`, `size: ${root.width}, ${root.height}`)
    }
}
