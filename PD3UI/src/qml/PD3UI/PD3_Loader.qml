import QtQuick 2.15
import FluentUI

Loader {
    asynchronous: true
    FluStatusLayout {
        visible: parent.status == Loader.Loading
        anchors.fill: parent
        statusMode: FluStatusLayoutType.Loading
        z: 100
        loadingText: "loading"
        Rectangle {
            anchors.fill: parent
            color: FluTheme.primaryColor
        }
    }
}
