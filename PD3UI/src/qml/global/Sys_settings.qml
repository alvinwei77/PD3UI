pragma Singleton

import QtQuick 2.15
import QtCore
import FluentUI
import com.pd3.pgpool 1.0

FluObject {
    id: setting_s

    readonly property alias activation_settings: activation_s
    readonly property alias dbInfo: db_info_s
    readonly property alias lang: lang_s.lang

    Settings {
        id: activation_s
        category: "Activation_s"
        property string code: value("code", "")
        property string startDate: value("startDate", "")
        property string endDate: value("endDate", "")
    }

    Settings {
        id: db_info_s
        category: "DB_info_s"
        property string host: value("host", "127.0.0.1")
        property string port: value("port", "5432")
        property string user: value("user", "pd3sales")
        property string password: value("password", "")
    }

    Settings {
        id: lang_s
        category: "Lang_s"
        property string lang: value("lang", "en")
    }

    function setActivation(value) {
        activation_s.setValue("code", value)
    }

    function setDbInfo(host, port, user, password) {
        //console.log(host, port, user, password, "22222")
        db_info_s.setValue("host", "127.0.0.1")
        db_info_s.setValue("port", "5432")
        db_info_s.setValue("user", "postgres")
        db_info_s.setValue("password", "PD3tech")
    }

    function setLang(value) {
        lang_s.setValue("lang", value)
        return checkCode(code)
    }

    function checkCode(code) {
        // 网络请求，判断是否code合法

        // 获取到项目功能套餐包含项列表，检查

        // 获取开始时间，过期时间，写入系统环境变量

        if (code === "pd3"){return true}
        return false;
    }

    function dbConnectTest(host, port, user, password){
        console.log(host, port, user, password)
        setDbInfo(host, port, user, password)
        if (PGPool.testConnectionAsync()) {
            return true
        } else {
            return false
        }
    }

    function isCompelete(){
        // // activation check
        // if (!checkCode(activation_s.value("code", ""))){
        //     return false
        // }

        // // db check
        // var host = db_info_s.value("host", "127.0.0.1")
        // var port = db_info_s.value("port", "5432")
        // var user = db_info_s.value("user", "postgres")
        // var password = db_info_s.value("password", "")
        // if (!dbConnectTest(host, port, user, password)){
        //     return false
        // }
        return true
    }
}
