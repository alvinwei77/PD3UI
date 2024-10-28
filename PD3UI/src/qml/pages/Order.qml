import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
import FluentUI
import "../global"
import "../PD3UI"

PD3_Page {
    id: root
    title: "Order"
    anchors.fill: parent
    property int orderId_: 0

    ListModel {
        id: dishType_list
    }

    ListModel {
        id: order_list
    }

    ListModel {
        id: dishes_list
    }

    ListModel {
        id: ava_table_list
    }

    ColumnLayout {
        id: layout
        anchors.fill: parent
        spacing: 10

        PD3_Loader {
            id: dishTop_loader
            Layout.fillWidth: true
            Layout.preferredHeight: 80
            source: GlobalModel.dish_top_source
        }
        Rectangle {
            color: "lightgray"
            Layout.preferredHeight: 1
            Layout.fillWidth: true
        }
        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            PD3_Loader {
                id: dishType_loader
                Layout.preferredWidth: 130
                Layout.fillHeight: true
                source: GlobalModel.dish_type_source
            }
            Rectangle {
                color: "lightgray"
                Layout.fillHeight: true
                Layout.preferredWidth: 1
            }
            PD3_Loader {
                id: dishGrid_loader
                Layout.fillWidth: true
                Layout.fillHeight: true
                source: GlobalModel.dish_grid_source
            }
            Rectangle {
                color: "lightgray"
                Layout.fillHeight: true
                Layout.preferredWidth: 1
            }
            PD3_Loader {
                id: dishOrder_loader
                Layout.preferredWidth: 420
                Layout.fillHeight: true
                source: GlobalModel.dish_order_source
            }
        }
    }

    Component.onCompleted: {

    }


    Connections {
        target: SignalManager
        function updateOrderPage(orderId){
            root.orderId_ = orderId
        }

    }

}
