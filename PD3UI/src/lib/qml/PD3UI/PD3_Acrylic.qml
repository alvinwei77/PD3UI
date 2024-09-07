import QtQuick 2.15
import QtQuick.Layouts
import FluentUI
import "./"
import "../global"


FluAcrylic {
    id: content
    property var setup_type
    property var next
    property alias contentWidth: contentItem.width
    property alias contentHeight: contentItem.height
    property var checkFunc: null
    property var nextHandler: null
    property alias title: title.text
    // target: background
    width: contentWidth
    height: contentHeight + 100 + 60
    anchors.centerIn: parent
    tintOpacity: 0.1
    tintColor: "white"
    blurRadius: 1

    FluFrame {
        id: contentcard
        anchors.fill: parent

        Text {
            id: title
            text: qsTr("text")
            height: 20
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: 10
            }
            font.bold: true
            font.pixelSize: 30
        }

        Item {
            id: contentItem
            width: 780
            height: 400
            anchors {
                top: parent.top
            }
        }
        RowLayout {
            width: parent.width
            height: 80
            anchors {
                bottom: parent.bottom
                bottomMargin: 10

            }
            Rectangle {
                id: pop_
                Layout.preferredHeight: parent.height/1.5
                Layout.preferredWidth: parent.width/4
                border.width: 2
                border.color: "#666666"
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                //visible: setup_type === "mid" || setup_type === "end"
                enabled: setup_type === "begin" ? false : true
                radius: 10
                FluIconButton{
                    anchors.fill: parent
                    anchors.centerIn: parent
                    iconSource: FluentIcons.Back
                    iconSize: 35
                    onClicked: {
                        SignalManager.popStack_()
                    }
                }
            }
            Rectangle {
                id: push_
                Layout.preferredHeight: parent.height/1.5
                Layout.preferredWidth: parent.width/4
                border.width: 2
                border.color: "#666666"
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                visible: setup_type === "mid" || setup_type === "begin"
                radius: 10
                enabled: checkFunc? checkFunc(): false
                FluIconButton{
                    anchors.fill: parent
                    anchors.centerIn: parent
                    iconSource: FluentIcons.Forward
                    iconSize: 35
                    onClicked: {
                        if (nextHandler) {
                            if (nextHandler()){
                                SignalManager.pushStack_(next)
                            }
                        }
                    }
                }
            }
            Rectangle {
                id: end_
                Layout.preferredHeight: parent.height/1.5
                Layout.preferredWidth: parent.width/4
                border.width: 2
                border.color: "#666666"
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                visible: setup_type === "end"
                radius: 10
                enabled: checkFunc? checkFunc(): false
                FluIconButton{
                    anchors.fill: parent
                    anchors.centerIn: parent
                    iconSource: FluentIcons.Connect
                    iconSize: 35
                    onClicked: {
                        if (nextHandler) {
                            nextHandler();
                        }
                        SignalManager.setupFinished()
                    }
                }
            }
        }
    }
}
