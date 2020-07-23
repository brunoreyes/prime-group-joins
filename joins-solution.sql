-- Tasks
--1. Get all customers and their addresses.
SELECT * FROM "customers"
JOIN "addresses" on "addresses"."customer_id" = "customers"."id"; 

--2. Get all orders and their line items (orders, quantity and product).
SELECT * FROM "customers"
JOIN "addresses" on "addresses"."customer_id" = "customers"."id";

--3. Which warehouses have cheetos?
SELECT "warehouse" FROM "warehouse"
JOIN "warehouse_product" on "warehouse_product"."warehouse_id" = "warehouse"."id"
JOIN "products" on "products"."id" = "warehouse_product"."product_id"
WHERE "description" = 'cheetos';

--4. Which warehouses have diet pepsi?
SELECT "warehouse" FROM "warehouse"
JOIN "warehouse_product" on "warehouse_product"."warehouse_id"="warehouse"."id"
JOIN "products" on "products"."id" = "warehouse_product"."product_id"
WHERE "description" = 'diet pepsi';

--5. Get the number of orders for each customer. NOTE: It is OK if those without orders are not included in results.
SELECT "customers"."first_name", "customers"."last_name", COUNT("customers"."id") FROM "orders"
JOIN "addresses" ON "orders"."address_id" = "addresses"."id"
JOIN "customers" ON "customers"."id" = "addresses"."customer_id"
GROUP BY "customers"."id";

--6. How many customers do we have?
SELECT COUNT(*) FROM "customers"
-- by selecting the highest id, we know how many customers we have

--7. How many products do we carry?
SELECT COUNT(*) FROM "products";


--8. What is the total available on-hand quantity of diet pepsi?
SELECT SUM("on_hand") FROM "warehouse"
JOIN "warehouse_product" on "warehouse_product"."warehouse_id"="warehouse"."id"
JOIN "products" on "products"."id" = "warehouse_product"."product_id"
WHERE "description" = 'diet pepsi';

-- Stretch
-- How much was the total cost for each order?
SELECT orders.id as order_id, SUM(line_items.quantity * products.unit_price) as order_total_cost FROM orders
JOIN line_items ON line_items.order_id = orders.id
JOIN products ON products.id = line_items.product_id
GROUP BY orders.id
ORDER BY orders.id ASC;


-- How much has each customer spent in total?
SELECT customers.id as customer_id, SUM(line_items.quantity * products.unit_price) as customer_total_cost FROM customers
JOIN addresses ON customers.id = addresses.id
JOIN orders ON addresses.id = orders.id
JOIN line_items ON line_items.order_id = orders.id
JOIN products ON products.id = line_items.product_id
GROUP BY customers.id
ORDER BY customers.id ASC;

-- How much has each customer spent in total? Customers who have spent $0 should still show up in the table. It should say 0, not NULL (research coalesce).
SELECT customers.id as customer_id, SUM(line_items.quantity * products.unit_price) as customer_total_cost FROM customers
JOIN addresses ON customers.id = addresses.id
JOIN orders ON addresses.id = orders.id
JOIN line_items ON line_items.order_id = orders.id
JOIN products ON products.id = line_items.product_id
GROUP BY customers.id
ORDER BY customers.id ASC;