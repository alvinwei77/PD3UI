// mockData.js

// 模拟的区域列表数据
var mockAreaList = [
    {"name": "油燜大蝦", "price": 30, "count": 1, "unit": "份", "status": "已下单"},
    {"name": "數量不是整數", "price": 45, "count": 5.5, "unit": "斤", "status": "已下单"},
    {"name": "價格是小數", "price": 15.99, "count": 1, "unit": "份", "status": "已下单"},
    {"name": "名字很長很長的燙燙燙錕斤拷燙燙燙錕斤拷燙燙燙錕斤拷燙燙燙錕斤拷", "price": 1, "count": 10000, "unit": "份", "status": "已下单"}
];

// 模拟的请求函数
function fetchAreaList() {
    var success = Math.random() > 0.5;  // 50% 几率返回成功，50% 几率返回失败
    if (success) {
        return {
            success: true,
            error: "No error",
            data: mockAreaList
        };
    } else {
        // 模拟错误响应
        var errors = ["Error code 404", "Error code 500", "Network issue"];
        var randomError = errors[Math.floor(Math.random() * errors.length)];
        return {
            success: false,
            error: randomError,
            data: []
        };
    }
}

// 导出函数
function getAreaList() {
    return fetchAreaList();
}
