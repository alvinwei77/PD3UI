pragma Singleton

import QtQuick 2.15

QtObject {
    property bool vkb: false

    property bool orderStatus: false

    function setOrderStatus_(count){
        orderStatus = count
    }

    function getOrderStatus_(){
        return orderStatus
    }
}
