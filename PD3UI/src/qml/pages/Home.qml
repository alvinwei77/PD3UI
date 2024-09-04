import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
import FluentUI
import "../components"
import "../global"
import "../PD3UI"

Item {
    id: root
    clip:true

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

    // 布局
    ColumnLayout {
        id: layout
        anchors.fill: parent
        spacing: 10
        Item {
            id: top
            Layout.fillWidth: true
            Layout.preferredHeight: 80
            PD3_Loader {
                anchors.fill: parent
                source: "qrc:/qml/components/AreaSelector.qml"
            }
        }

        RowLayout {
            id: body
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 10
            Item {
                id: tableGrid
                Layout.preferredWidth: 1000
                Layout.fillHeight: true

                PD3_Loader {
                    anchors.fill: parent
                    source: "qrc:/qml/components/TableGrid.qml"
                }
            }
            Item {
                id: tableOpres
                Layout.fillHeight: true
                Layout.fillWidth: true

                PD3_Loader {
                    anchors.fill: parent
                    source: "qrc:/qml/components/TableOpres.qml"
                }
            }
        }
    }

    Component.onCompleted: {
        console.log("loaded Home page")
    }

}
