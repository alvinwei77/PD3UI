#include "queryInterface.h"

QVariantMap toVariantMap(const QueryResult& result) {
    QVariantMap map;
    map["success"] = result.success;
    map["error"] = result.error;
    map["records"] = result.records;
    return map;
}
