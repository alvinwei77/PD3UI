import QtQuick 2.15
import FluentUI 1.0
import QtQuick.Layouts 1.15
import "../global"
import "."

Rectangle {
    id: greetings

    property var titles: ["Welcome", "PD3", "R System"]
    anchors.fill: parent
    opacity: 1.0
    z: 990

    Rectangle {
        id: bg
        width: 200
        height: 200
        color: "blue"

        // 旋转矩形
        transform: Rotation {
            origin.x: width / 2  // 设置旋转中心为矩形的中间
            origin.y: height / 2
            angle: 45  // 设置旋转角度（单位为度）
        }

        PathAnimation {
            id: pathAnimation
            target: bg
            loops: -1
            duration: 300
            orientation: PathAnimation.TopFirst
            path: Path {
                startX: title.x + title.width
                startY: title.y
                PathCurve { x: title.x; y: title.y+title.height }
            }
        }
    }

    ColumnLayout {
        id: title
        width: 200
        height: 200
        anchors.centerIn: parent
        spacing: 20
        Repeater {
            model: titles
            delegate: Text {
                text: qsTr(modelData.toString())
                color: "grey"
                font.pixelSize: 40
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }

    SequentialAnimation on opacity {
        running: greetings.visible
        loops: 1
        PauseAnimation { duration: 1500 }
        NumberAnimation { to: 0; duration: 1500 }
        onStopped: {
            greetings.visible = false
            SignalManager.greeting_off_()
        }
    }

    Item {
        id: arrowItem
        anchors.fill: parent
        TArrow {
            id: arrow1
        }
        TArrow {
            id: arrow2
        }
        TArrow {
            id: arrow3
        }
        TArrow {
            id: arrow4
        }
        TArrow {
            id: arrow5
        }
        TArrow {
            id: arrow6
        }
        TArrow {
            id: arrow7
        }
        TArrow {
            id: arrow8
        }
        TArrow {
            id: arrow9
        }
    }

    Item {
        id: mirrorItem
        x: arrowItem.x
        y: arrowItem.y + arrowItem.height
        width: arrowItem.width
        height: arrowItem.height
        opacity: 0.3
        layer.enabled: true
        layer.effect: Component {
            ShaderEffectSource {
                sourceItem: arrowItem
                textureMirroring: ShaderEffectSource.MirrorVertically
            }
        }
        transform: Rotation {
            origin.x: mirrorItem.width / 2
            origin.y: mirrorItem.height / 2
            axis {x: 1; y: 0; z: 0}
            angle: 180
        }
    }

    Component.onCompleted: {
        seAnimation.start()
    }

    SequentialAnimation {
        id: seAnimation
        ScriptAction {script: arrow1.run()}
        PauseAnimation {duration: 200 }
        ScriptAction {script: arrow2.run()}
        PauseAnimation {duration: 200 }
        ScriptAction {script: arrow3.run()}

        PauseAnimation {duration: 500 }

        ScriptAction {script: arrow4.run()}
        PauseAnimation {duration: 200 }
        ScriptAction {script: arrow5.run()}
        PauseAnimation {duration: 200 }
        ScriptAction {script: arrow6.run()}

        PauseAnimation {duration: 500 }

        ScriptAction {script: arrow7.run()}
        PauseAnimation {duration: 200 }
        ScriptAction {script: arrow8.run()}
        PauseAnimation {duration: 200 }
        ScriptAction {script: arrow9.run()}
        PauseAnimation {duration: 200 }
    }
}
