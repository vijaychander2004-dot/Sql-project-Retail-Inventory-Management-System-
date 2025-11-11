-- Retail Inventory Management System
-- Create the Database
CREATE DATABASE retail_store;
USE retail_store;
-- Create Tables
CREATE TABLE suppliers (
  supplier_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  contact VARCHAR(20)
);
CREATE TABLE products (
  product_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  category VARCHAR(50),
  supplier_id INT,
  price DECIMAL(8,2),
  FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);
CREATE TABLE customers (
  customer_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  phone VARCHAR(15)
);
CREATE TABLE inventory (
  inventory_id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT,
  quantity INT,
  last_updated DATE,
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);
CREATE TABLE orders (
  order_id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT,
  order_date DATE,
  total_amount DECIMAL(10,2),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
CREATE TABLE order_details (
  order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT,
  product_id INT,
  quantity INT,
  price DECIMAL(8,2),
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);
CREATE TABLE transactions (
  transaction_id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT,
  transaction_type ENUM('purchase', 'sale'),
  quantity INT,
  transaction_date DATE,
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);
-- Insert Example Data
INSERT INTO suppliers (name, contact) VALUES
  ('FreshMart', '9812345678'),
  ('QuickFoods', '9823456789'),
  ('VeggieZone', '9834567890'),
  ('BakeryBest', '9845678912');
INSERT INTO products (name, category, supplier_id, price) VALUES
  ('Apples', 'Fruit', 1, 70.00),
  ('Milk', 'Dairy', 2, 55.00),
  ('Potatoes', 'Vegetable', 3, 40.00),
  ('Bread', 'Bakery', 4, 45.00),
  ('Tomatoes', 'Vegetable', 3, 45.00),
  ('Bananas', 'Fruit', 1, 50.00),
  ('Paneer', 'Dairy', 2, 120.00),
  ('Cake', 'Bakery', 4, 250.00);
  INSERT INTO customers (name, phone) VALUES
  ('Anil Kumar', '9000111122'),
  ('Seema Rani', '9000222233'),
  ('Ravi Das', '9000333344');
 INSERT INTO inventory (product_id, quantity, last_updated) VALUES
 (1, 80, '2025-11-10'), -- Apples
 (2, 50, '2025-11-10'), -- Milk
 (3, 100, '2025-11-10'), -- Potatoes
 (4, 60, '2025-11-10'), -- Bread
 (5, 120, '2025-11-10'), -- Tomatoes
 (6, 40, '2025-11-10'), -- Bananas
 (7, 20, '2025-11-10'), -- Paneer
 (8, 15, '2025-11-10'); -- Cake
 -- Sample Transactions (Sales & Purchases)
INSERT INTO transactions (product_id, transaction_type, quantity, transaction_date) VALUES
 (1, 'purchase', 30, '2025-11-10'),
 (2, 'purchase', 30, '2025-11-10'),
 (5, 'purchase', 40, '2025-11-10');
INSERT INTO transactions (product_id, transaction_type, quantity, transaction_date) VALUES
 (1, 'sale', 10, '2025-11-11'), -- Apples
 (2, 'sale', 15, '2025-11-11'), -- Milk
 (4, 'sale', 10, '2025-11-11'), -- Bread
 (5, 'sale', 25, '2025-11-11'), -- Tomatoes
 (8, 'sale', 2,  '2025-11-11'); -- Cake
 -- Output Examples
 -- Show All Inventory
SELECT p.name, i.quantity, i.last_updated
FROM products p
JOIN inventory i ON p.product_id = i.product_id;
-- List Products with Low Stock (e.g., less than 30 units)
SELECT p.name, i.quantity
FROM products p
JOIN inventory i ON p.product_id = i.product_id
WHERE i.quantity < 30;
-- Update Stock After Sale
UPDATE inventory SET quantity = quantity - 5, last_updated = '2025-11-11' WHERE product_id = 1; -- Apples
-- Get Top Selling Product This Month
SELECT p.name, SUM(t.quantity) AS total_sold
FROM transactions t
JOIN products p ON t.product_id = p.product_id
WHERE t.transaction_type = 'sale'
AND t.transaction_date BETWEEN '2025-11-01' AND '2025-11-30'
GROUP BY p.name
ORDER BY total_sold DESC
LIMIT 1;
-- Show All Products Sold Today
SELECT p.name, t.quantity
FROM transactions t
JOIN products p ON t.product_id = p.product_id
WHERE t.transaction_type = 'sale' AND t.transaction_date = CURRENT_DATE;
-- Add a New Order
INSERT INTO orders (customer_id, order_date, total_amount)
VALUES (2, '2025-11-11', 650.00);
-- Insert details for each product in the order
INSERT INTO order_details (order_id, product_id, quantity, price) VALUES
  (1, 2, 5, 55.00),   -- Milk
  (1, 4, 3, 45.00),   -- Bread
  (1, 5, 10, 45.00);  -- Tomatoes
-- Show all products, even those with no sales
SELECT p.name
FROM Products p
LEFT JOIN Transactions t ON p.product_id = t.product_id AND t.transaction_type = 'sale'
WHERE t.transaction_date IS NULL OR t.transaction_date < '2025-11-01';


















  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
















































