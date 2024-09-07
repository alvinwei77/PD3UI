import QtQuick 2.15
import QtQuick.VirtualKeyboard
import QtQuick.VirtualKeyboard.Settings

Item {
    anchors {
        horizontalCenter: parent.horizontalCenter
        bottom: parent.bottom
    }
    // property alias active: inputPanel.active
    // InputPanel {
    //     id: inputPanel
    //     z: 999
    //     x: 0
    //     y: parent.height
    //     width: parent.width

    //     states: State {
    //         name: "visible"
    //         when: inputPanel.active
    //         PropertyChanges {
    //             target: inputPanel
    //             y: parent.height - inputPanel.height - 32
    //         }
    //     }
    //     transitions: Transition {
    //         from: ""
    //         to: "visible"
    //         reversible: true
    //         ParallelAnimation {
    //             NumberAnimation {
    //                 properties: "y"
    //                 duration: 250
    //                 easing.type: Easing.InOutQuad
    //             }
    //         }
    //     }

    //     Component.onCompleted: {
    //         VirtualKeyboardSettings.locale = "zh_CN"
    //         VirtualKeyboardSettings.activeLocales = ["zh_CN", "en_US"]
    //         VirtualKeyboardSettings.fullScreenMode  = false
    //     }
    // }
}

