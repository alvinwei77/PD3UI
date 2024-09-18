pragma Singleton

import QtQuick 2.15
import FluentUI 1.0

QtObject{
    // 菜单导航设置
    property int displayMode: FluNavigationViewType.Auto
    // 页面设置
    property int pageMargin: 10
    property string pageColor: "white"
    property var backgroundColor: {
        "whole_background": "white",
        "layer_2": "lightgray"
    }
    property var dishGridColor: {
        "default": "white",
        "default_text": "black",
        "selected": "#4A9CE8",
        "selected_text": "white"
    }
    property var tabColor: {
        "default": "white",
        "default_text": "black",
        "selected": "#1684FC",
        "selected_text": "white"
    }
    property var buttonsColor:{
        "style1_bg":"#4A9CE8",
        "style1_text":"white"
    }



    // 引用
    property string home_area_source: "qrc:/qml/components/TableArea.qml"
    property string home_page_settings_source: "qrc:/qml/components/TableSettings.qml"
    property string home_table_grid_source: "qrc:/qml/components/TableGrid.qml"
    property string home_table_opras_source: "qrc:/qml/components/TableOpres.qml"
    property string home_table_open_source: "qrc:/qml/components/TableOpenSheet.qml"

    property string dish_top_source: "qrc:/qml/components/DishTop.qml"
    property string dish_type_source: "qrc:/qml/components/DishType.qml"
    property string dish_grid_source: "qrc:/qml/components/DishGrid.qml"
    property string dish_order_source: "qrc:/qml/components/DishOrder.qml"

}
