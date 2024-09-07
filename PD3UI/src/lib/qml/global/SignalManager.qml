pragma Singleton

import QtQuick 2.15
import FluentUI

FluObject {
    id: signalManager

    signal tablep_switch()
    function tablep_switch_(){
        tablep_switch()
    }

    signal tablep_open()
    function tablep_open_(){
        tablep_open()
    }

    signal greeting_off()
    function greeting_off_(){
        greeting_off()
    }


    // ------

    signal pushStack(string url)
    function pushStack_(url){
        pushStack(url)
    }

    signal test(string abc)
    function test_(abc){
        test(abc)
    }

    signal ordersPayment(var paymentMethods)
    function ordersPayment_(paymentMethods){
        ordersPayment(paymentMethods)
    }

    signal popStack()
    function popStack_(){
        popStack()
    }

    signal setupFinished()
    function setupFinished_(){
        setupFinished()
    }

    signal acviteInput()
    function acviteInput_(){
        acviteInput()
    }

    signal getProductInfo(var id, var editable)
    function getProductInfo_(id, editable){
        getProductInfo(id, editable)
    }

    signal productList(var cid)
    function productList_(cid){
        productList(cid)
    }

    signal pAddtoOrderList(var pid)
    function pAddtoOrderList_(pid){
        pAddtoOrderList(pid)
    }

    signal pPropertyChange(var action, var key)
    function pPropertyChange_(action, key){
        pPropertyChange(action, key)
    }

    signal iConditionalChange(var category_id, var status)
    function iConditionalChange_(category_id, status) {
        iConditionalChange(category_id, status)
    }

    signal paymentDiaOpen()
    function paymentDiaOpen_(){
        paymentDiaOpen()
    }

    signal activeCategory(var id)
    function activeCategory_(id){
        activeCategory(id)
    }

    signal categoriesLoaded()
    function categoriesLoaded_(){
        categoriesLoaded()
    }

    signal searchItem(var keys)
    function searchItem_(keys){
        searchItem(keys)
    }
    signal updateItem()
    function updateItem_(){
        updateItem()
    }
    signal updateStoreList()
    function updateStoreList_(){
        updateStoreList()
    }

    signal orderStatus(var status, var paymentMethods, var date)
    function orderStatus_(status, paymentMethods, date){
        orderStatus(status, paymentMethods, date)
    }

    signal searchOrder(var data)
    function searchOrder_(data){
        searchOrder(data)
    }
}

