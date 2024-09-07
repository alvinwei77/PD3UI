pragma Singleton

import QtQuick 2.15
import FluentUI 1.0

FluObject{

    property var navigationView
    property var flipable

    id:footer_items

    FluPaneItemSeparator{}

    FluPaneItem{
        title:qsTr("系统设置")
        icon:FluentIcons.Settings
        url:""
        onTap:{
            navigationView.push(url)
        }
    }

}
