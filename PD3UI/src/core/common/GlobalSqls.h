#ifndef GLOBALSQLS_H
#define GLOBALSQLS_H

#include <QString>

namespace globalSqls {
// Test SQLs
inline QString INIT_DB(){
    return QString(
               "-- 表分类:\n"
               "--  区域 - 桌子\n"
               "--  菜/菜品/菜品类型\n"
               "--  订单/订单类型/订单关系\n"
               "--  支付/支付方式\n"
               "--  系统设置\n\n"

               "-- 创建包含时间戳字段的基表\n"
               "CREATE TABLE base_timestamps (\n"
               "    created_time TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,\n"
               "    updated_time TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP\n"
               ");\n\n"

               "-- 触发器\n"
               "CREATE OR REPLACE FUNCTION update_timestamp()\n"
               "RETURNS TRIGGER AS $$\n"
               "BEGIN\n"
               "    NEW.updated_time = CURRENT_TIMESTAMP;\n"
               "    RETURN NEW;\n"
               "END;\n"
               "$$ LANGUAGE plpgsql;\n\n"

               "------------------------------------------------\n"
               "-- 创建区域表\n"
               "CREATE TABLE IF NOT EXISTS Area (\n"
               "    id SERIAL PRIMARY KEY,\n"
               "    key_ TEXT\n"
               ") INHERITS (base_timestamps);\n\n"

               "-- 创建桌子表\n"
               "CREATE TABLE IF NOT EXISTS Table (\n"
               "    id SERIAL PRIMARY KEY,\n"
               "    area_id INT DEFAULT 0, -- 0 代表未划分区域\n"
               "    customer_max_num INT NOT NULL\n"
               ") INHERITS (base_timestamps);\n\n"

               "------------------------------------------------\n"
               "-- 订单\n"
               "CREATE TABLE IF NOT EXISTS OrderType (\n"
               "    id SERIAL PRIMARY KEY,\n"
               "    key_ TEXT\n"
               ") INHERITS (base_timestamps);\n\n"

               "-- 订单表\n"
               "CREATE TABLE IF NOT EXISTS Orders (\n"
               "    id SERIAL PRIMARY KEY,\n"
               "    table_id INT NOT NULL,\n"
               "    order_type_id INT NOT NULL,\n"
               "    customer_num INT NOT NULL,\n"
               "    discount NUMERIC(10, 2) DEFAULT 0,\n"
               "    service_charge NUMERIC(10, 2) DEFAULT 0,\n"
               "    tax NUMERIC(10, 2) DEFAULT 0,\n"
               "    order_status INT NOT NULL DEFAULT 0,\n"
               "    CONSTRAINT fk_order_type_id FOREIGN KEY (order_type_id) REFERENCES OrderType(id),\n"
               "    CONSTRAINT fk_table_id FOREIGN KEY (table_id) REFERENCES Table(id)\n"
               ") INHERITS (base_timestamps);\n\n"

               "------------------------------------------------\n"
               "-- 订单关联表\n"
               "CREATE TABLE IF NOT EXISTS OrdersDishes (\n"
               "    order_id INT NOT NULL,\n"
               "    dish_id INT NOT NULL,\n"
               "    price NUMERIC(10, 2) NOT NULL,\n"
               "    quantity INT NOT NULL DEFAULT 1,\n"
               "    note TEXT,\n"
               "    CONSTRAINT fk_order_id FOREIGN KEY (order_id) REFERENCES Orders(id),\n"
               "    CONSTRAINT fk_dish_id FOREIGN KEY (dish_id) REFERENCES Dishes(id)\n"
               ") INHERITS (base_timestamps);\n\n"

               "------------------------------------------------\n"
               "-- 创建账单表\n"
               "CREATE TABLE IF NOT EXISTS Bills (\n"
               "    id SERIAL PRIMARY KEY,\n"
               "    order_id INT NOT NULL,\n"
               "    payment_id INT NOT NULL,\n"
               "    currency_id INT,\n"
               "    note VARCHAR(255),\n"
               "    CONSTRAINT fk_order_id FOREIGN KEY (order_id) REFERENCES Orders(id)\n"
               ") INHERITS (base_timestamps);\n\n"

               "------------------------------------------------\n"
               "-- 支付方式表\n"
               "CREATE TABLE IF NOT EXISTS PaymentMethod (\n"
               "    id SERIAL PRIMARY KEY,\n"
               "    currency_id INT NOT NULL,\n"
               "    note VARCHAR(255) NOT NULL,\n"
               "    CONSTRAINT fk_currency_id FOREIGN KEY (currency_id) REFERENCES Currency(id)\n"
               ") INHERITS (base_timestamps);\n\n"

               "------------------------------------------------\n"
               "-- 货币表\n"
               "CREATE TABLE IF NOT EXISTS Currency (\n"
               "    id SERIAL PRIMARY KEY,\n"
               "    code VARCHAR(3)\n"
               ");\n\n"

               "------------------------------------------------\n"
               "-- 菜品及其标签、描述等信息\n"
               "CREATE TABLE IF NOT EXISTS Dishes (\n"
               "    id SERIAL PRIMARY KEY,\n"
               "    discount NUMERIC(10, 2) DEFAULT 0.00,\n"
               "    key_ TEXT DEFAULT '',\n"
               "    dish_top VARCHAR(255),\n"
               "    dish_tags VARCHAR(255),\n"
               "    allergies_id VARCHAR(255),\n"
               "    description VARCHAR(255)\n"
               ") INHERITS (base_timestamps);\n\n"

               "------------------------------------------------\n"
               "-- 创建系统设置表\n"
               "CREATE TABLE IF NOT EXISTS Settings (\n"
               "    id SERIAL PRIMARY KEY,\n"
               "    key_ VARCHAR(255) NOT NULL,\n"
               "    reference VARCHAR(255) NOT NULL\n"
               ") INHERITS (base_timestamps);\n\n"

               "-- 为每个子表都创建触发器\n"
               "DO $$\n"
               "DECLARE\n"
               "    r RECORD;\n"
               "BEGIN\n"
               "    FOR r IN SELECT tablename FROM pg_tables WHERE tablename LIKE 'your_table_prefix%' LOOP\n"
               "        EXECUTE 'CREATE TRIGGER set_timestamp BEFORE UPDATE ON ' || r.tablename || ' FOR EACH ROW EXECUTE FUNCTION update_timestamp();';\n"
               "    END LOOP;\n"
               "END $$;\n"
        );
}


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
