import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
import FluentUI
import "../components"
import "../global"
import "../PD3UI"

PD3_Page {
    id: root
    title: "Home"
    anchors.fill: parent

    // 布局
    ColumnLayout {
        id: layout
        anchors.fill: parent
        spacing: 10
        RowLayout {
            id: top
            Layout.fillWidth: true
            Layout.preferredHeight: 80
            spacing: 80
            PD3_Loader {
                id: area_loader
                Layout.fillWidth: true
                source: GlobalModel.home_area_source
            }
            PD3_Loader {
                id: page_settings_loader
                Layout.preferredWidth: 400
                source: GlobalModel.home_page_settings_source
            }
        }
        Rectangle {
            color: "lightgray"
            Layout.preferredHeight: 1
            Layout.fillWidth: true
        }
        RowLayout {
            id: body
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 10
            PD3_Loader {
                id: tableGrid
                Layout.fillWidth: true
                Layout.fillHeight: true
                source: GlobalModel.home_table_grid_source
            }
            PD3_Loader {
                id: tableOpres
                Layout.fillHeight: true
                Layout.preferredWidth: 0
                source: GlobalModel.home_table_opras_source

                Behavior on Layout.preferredWidth {
                    NumberAnimation {
                        duration: 500
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        }
    }


    Component.onCompleted: {

    }


    Connections {
        target: SignalManager
        function onTablep_switch(){
            if (tableOpres.Layout.preferredWidth === 0) {
                tableOpres.source = GlobalModel.home_table_opras_source
            }
            tableOpres.Layout.preferredWidth = tableOpres.Layout.preferredWidth === 0 ? 200 : 0
        }
        function onGreeting_off(){
            Qt.callLater(function() {
                tableOpres.source = GlobalModel.home_table_opras_source
                tableOpres.Layout.preferredWidth = 200
            })
        }
        function onTablep_open(){
            if (tableOpres.Layout.preferredWidth === 0) {
                tableOpres.source = GlobalModel.home_table_open_source
            }
            tableOpres.Layout.preferredWidth = tableOpres.Layout.preferredWidth === 0 ? 400 : 0
        }
    }
}
