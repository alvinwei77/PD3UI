import QtQuick 2.15
import QtQuick.Controls
import "../components"
import "../common"
import "../global"
import FluentUI

Item {
    id: init_root
    anchors.fill: parent

    Image {
        id: background
        source: "qrc:/res/bg_.jpg"
        anchors.fill: parent
        asynchronous: true
        z: -1
        visible: true
    }

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: Qt.createComponent("qrc:/qml/setup/code.qml")
    }

    Connections {
        target: SignalManager
        function onPushStack(url){
            stackView.push(url)
        }
    }
    Connections {
        target: SignalManager
        function onPopStack(){
            stackView.pop()
        }
    }
    Connections {
        target: SignalManager
        function onSetupFinished(){
            stackView.clear()
            background.visible=false
            window_setup.close()
        }
    }
}
