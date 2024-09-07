#ifndef QUERYINTERFACE_H
#define QUERYINTERFACE_H

#include <QString>
#include <QVariantList>
#include <QList>
#include <functional>

// 用于保存query结果的接口
struct QueryResult {
    bool success;
    QString error;
    QVariantList records;
};

QVariantMap toVariantMap(const QueryResult& result);

// // 功能函数，用于检查图片是否存在，并返回相应的路径
// QString getProductImagePath(int productId);

// // 抽象的函数接口，用于为产品列表添加图片路径
// QVariantList addImagePathsToProducts(QVariantList products);

// QString handleImage(int id, const QString &imagePath, const QString &targetDir="C:/Users/Public/PD3/");

#endif // QUERYINTERFACE_H
