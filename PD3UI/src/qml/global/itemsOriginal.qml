pragma Singleton

import QtQuick 2.15
import FluentUI 1.0

FluObject {
    property var navigationView

    // FluPaneItem{
    //     id: item_test
    //     title: qsTr("Test")
    //     icon: FluentIcons.MultimediaDMP
    //     //url: "qrc:/qml/pages/Test2.qml"
    //     url: "qrc:/qml/pages/Test.qml"
    //     onTap: { navigationView.push(url) }
    //     visible: true
    // }

    FluPaneItem{
        id: item_home
        title: qsTr("Sales")
        icon: FluentIcons.Shop
        url: "qrc:/qml/pages/Sales.qml"
        onTap: { navigationView.push(url)}
    }

    FluPaneItem{
        id:item_tables
        title: qsTr("Orders")
        icon: FluentIcons.ClipboardListMirrored
        url: "qrc:/qml/pages/Orders.qml"
        onTap: { navigationView.push(url) }
    }

    FluPaneItem{
        id:item_bill
        title:qsTr("Stores")
        icon: FluentIcons.AllAppsMirrored
        url: "qrc:/qml/pages/Stores.qml"
        onTap: { navigationView.push(url) }
    }

    FluPaneItem{
        id:item_dishes
        title: qsTr("Analysis")
        icon: FluentIcons.AreaChart
        url: "qrc:/qml/pages/Analysis.qml"
        onTap: { navigationView.push(url, extra) }
        visible: false
    }

    FluPaneItem{
        id: item_hwm
        title: qsTr("HardWares")
        icon: FluentIcons.MultimediaDMP
        url: "qrc:/qml/pages/Hardwares.qml"
        onTap: { navigationView.push(url) }
        visible: true
    }
}
