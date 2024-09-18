pragma Singleton

import QtQuick 2.15
import FluentUI 1.0

FluObject {
    property var navigationView
    FluPaneItem{
        id: item_home
        title: qsTr("Home")
        icon: FluentIcons.Shop
        url: "qrc:/qml/pages/Home.qml"
        onTap: { navigationView.push(url) }
    }

    FluPaneItem{
        id:item_tables
        title: qsTr("Bills")
        icon: FluentIcons.ClipboardListMirrored
        url: "qrc:/qml/pages/Order.qml"
        onTap: { navigationView.push(url) }
    }





}
