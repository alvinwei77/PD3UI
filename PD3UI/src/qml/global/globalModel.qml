pragma Singleton

import QtQuick 2.15
import FluentUI 1.0

QtObject{
    // 菜单导航设置
    property int displayMode: FluNavigationViewType.Auto
    // 页面设置
    property int pageMargin: 10
    property string pageColor: "white"

}
