#ifndef GLOBALSQLS_H
#define GLOBALSQLS_H

#include <QString>

namespace globalSqls {
// Test SQLs
inline QString SELECT_TEST() {
    return QString("SELECT * from Test");
}

inline QString SELECT_TEST_BY_ID(int id) {
    return QString("SELECT * from Test where id = %1").arg(id);
}

inline QString INSERT_TEST(const QString &text, int id) {
    return QString("SELECT * from Test where id = %1").arg(id);
}

}

#endif // GLOBALSQLS_H
