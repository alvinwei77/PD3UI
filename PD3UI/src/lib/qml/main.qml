import QtQuick 2.15
import QtQuick.Window 2.15
import FluentUI 1.0
import "./global"
import "./PD3UI"

FluWindow {
    id: window
    title: "PD3Tech"
    width: 1366
    height: 768

    launchMode: FluWindowType.SingleTask
    backgroundColor: Config.backgroundColor
    visible: true

    property bool compacted: true
    property bool pageLoaded: false

    Component.onCompleted: {}
    Component.onDestruction: { FluRouter.exit() }

    Column {
        id: logo
        width: compacted?130:50
        height: 100
        anchors {
            left: window.left
            top: window.top
        }
        spacing: 10
        FluClip {
            radius: [10, 10, 10, 10]
            width: compacted?130:50
            height: 50
            Image {
                asynchronous: true
                anchors.fill: parent
                source: compacted ? "qrc:/public/pd3logo2.png": "qrc:/public/pd3color.png"
                fillMode: Image.PreserveAspectCrop
            }
            anchors.horizontalCenter: parent.horizontalCenter
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    compacted = !compacted
                }
            }
        }
        Text {
            id: title
            text: qsTr("PD3餐饮系统")
            font.pixelSize: 13
            anchors.horizontalCenter: parent.horizontalCenter
            visible: compacted
        }
    }

    FluNavigationView {
        id: nav_view
        width: parent.width
        height: parent.height
        cellWidth: 130
        cellHeight: 60
        z:990
        pageMode: FluNavigationViewType.NoStack
        items: ItemsOriginal
        footerItems: ItemsFooter
        topPadding: 0
        displayMode: compacted ? GlobalModel.displayMode: FluNavigationViewType.Compact
        hideNavAppBar: true
        navTopMargin: 100

        Component.onCompleted: {
            ItemsOriginal.navigationView = nav_view
            ItemsFooter.navigationView = nav_view
            setCurrentIndex(0)
        }
    }

    // PD3_Greeting {
    //     id: greetings
    //     z: 999
    // }

    Connections {
        target: dbService
        function onDbConnecting(success){
            if(!success){
                showError("DataBase connecting error")
            }
        }
    }

}
