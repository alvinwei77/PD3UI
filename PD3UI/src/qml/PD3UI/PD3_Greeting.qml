import QtQuick 2.15
import FluentUI 1.0
import QtQuick.Layouts 1.15

Rectangle {
    id: greetings

    property var titles: ["Welcome", "PD3", "Sales System"]
    anchors.fill: parent
    opacity: 1.0
    z: 990

    Component.onCompleted: {

    }

    ColumnLayout {
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
        PauseAnimation { duration: 1000 }
        NumberAnimation { to: 0; duration: 1000 }
        onStopped: {
            greetings.visible = false
        }
    }
}
