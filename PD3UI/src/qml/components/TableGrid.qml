import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
import FluentUI
import "../global"


Item {
    id: root
    anchors.fill: parent


    Rectangle {
        anchors.fill: parent
        color: "white"
    }
    clip: true

    ListModel {
        id: table_list
    }

    property int itemsPerPage: 10
    property int pageCount: Math.ceil(table_list.count / itemsPerPage)

    SwipeView {
        id: swipeView
        width: parent.width
        height: parent.height * 0.8
        anchors {
            leftMargin: 20
            topMargin: 20
            bottomMargin: 20
        }

        Repeater {
            model: pageCount
            delegate: GridView {
                id: gridview
                cellWidth: swipeView.width / 5
                cellHeight: swipeView.width / 5
                ListModel {
                    id: page_table_ls
                }
                interactive: false

                Component.onCompleted: {
                    let startIndex = index * itemsPerPage;
                    let endIndex = Math.min(startIndex + itemsPerPage, table_list.count);
                    page_table_ls.clear();
                    for (let i = startIndex; i < endIndex; i++) {
                        page_table_ls.append(table_list.get(i));
                    }
                    // console.log("Page " + index + " has " + page_table_ls.count + " items");
                }

                model: page_table_ls

                delegate: Rectangle {
                    id: table
                    width: gridview.cellWidth - 20
                    height: gridview.cellWidth - 20
                    radius: 25
                    color: index === 0 ? "orange" : "green"
                    border.color: "gray"
                    border.width: 1
                    Text {
                        id: space
                        text: `(${model.tspacetaken}/${model.tspace})`
                        font.bold: true
                        font.pixelSize: 16
                        font.weight: 10
                        color: "white"
                        anchors {
                            horizontalCenter: parent.horizontalCenter
                            bottom: tableID.top
                            bottomMargin: 10
                        }
                    }
                    Text {
                        id: tableID
                        text: model.tid
                        font.bold: true
                        font.pixelSize: 39
                        color: "white"
                        anchors {
                            centerIn: parent
                            verticalCenterOffset: 5
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (index === 0) {
                                SignalManager.checkoutp_show_(index);
                            } else {
                                SignalManager.tablep_open_();
                            }
                        }
                    }

                }
            }
        }

        Component.onCompleted: {
            Qt.callLater(function() {
                swipeView.currentIndex = 0;
            });
        }
    }

    PageIndicator {
        height: parent.height * 0.1
        id: pageIndicator
        font.pixelSize: 30
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        count: swipeView.count
        currentIndex: swipeView.currentIndex
        delegate: Rectangle {
            width: 20
            height: 20
            radius: 10
            color: swipeView.currentIndex === index ? "blue" : "lightgray"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    swipeView.currentIndex = index
                }
            }
        }
    }

    Component.onCompleted: {
        // req table list by area id
        var arr = ["A11", "A12", "A13", "A14", "A15", "A16", "A17", "A18", "A19", "A20", "A21", "A22", "A23", "A11", "A12", "A13", "A14", "A15", "A16", "A17", "A18", "A19", "A20", "A21", "A22", "A23"];
        for (var value of arr) {
            table_list.append({"tid": value, "tspace": 4, "tspacetaken": 3})
        }
    }

    Connections {
        target: SignalManager
        function onTablep_area_focus(id){
            table_list.clear(); //清空
            var res = areaManager.fetchAreaByID(id)
            if (res.success){
                for (var value of res.records) {
                    table_list.append({"tid": value.id, "tspace": value.max_customers, "tspacetaken": value.current_customers})
                }
            } else {
                showError(res.error);
            }
        }
    }
}
