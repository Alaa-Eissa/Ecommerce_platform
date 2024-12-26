CREATE DATABASE ecommerce_ platform;
Use ecommerce_platform;
CREATE TABLE Users(
user_id INT AUTO_INCREMENT PRIMARY KEY ,
name VARCHAR(100) NOT NULL ,
email VARCHAR(100) UNIQUE NOT NULL ,
password VARCHAR(255) NOT NULL ,
phone VARCHAR ( 20 ,)
address VARCHAR ( 255 ,)
 role ENUM('customer', 'admin') DEFAULT 'customer ');

CREATE TABLE Categories(
category_id INT AUTO_INCREMENT PRIMARY KEY ,
name VARCHAR(100) NOT NULL ,
 description TEXT);

CREATE TABLE Products(
product_id INT AUTO_INCREMENT PRIMARY KEY ,
name VARCHAR(100) NOT NULL ,
description TEXT ,
price DECIMAL(10, 2) NOT NULL ,
stock_quantity INT NOT NULL ,
category_id INT,
forgeing key (category_id) references categories(category_id)
);

CREATE TABLE Orders(
order_id INT AUTO_INCREMENT PRIMARY KEY ,
user_id INT NOT NULL ,
order_date DATETIME DEFAULT CURRENT_TIMESTAMP ,
status ENUM('pending', 'shipped', 'delivered', 'canceled') DEFAULT 'pending '
,foreign key (user_id) references users (user_id));

CREATE TABLE Order_Details(
order_detail_id INT NOT NULL AUTO_INCREMENT
order_id INT NOT NULL ,
product_id INT NOT NULL ,
quantity INT NOT NULL ,
subtotal DECIMAL(10, 2) NOT NULL ,
PRIMARY KEY (order_detail_id, order_id) ,
 FOREIGN KEY (order_id) REFERENCES Orders(order_id),
FOREIGN KEY (product_id) REFERENCES Products(product_id));

CREATE TABLE Payments(
payment_id INT AUTO_INCREMENT
order_id INT NOT NULL ,
payment_date DATETIME DEFAULT CURRENT_TIMESTAMP ,
payment_method ENUM('credit_card', 'paypal', 'cash') NOT NULL ,
amount DECIMAL(10, 2) NOT NULL ,
PRIMARY KEY (payment_id, order_id),
 FOREIGN KEY (order_id) REFERENCES Orders(order_id));
 
CREATE TABLE Shipping(
shipping_id INT AUTO_INCREMENT
order_id INT NOT NULL ,
shipping_address VARCHAR(255) NOT NULL ,
shipping_date DATETIME ,
delivery_date DATETIME ,
status ENUM('in transit', 'delivered') DEFAULT 'in transit ,'
PRIMARY KEY (shipping_date, order_id) ,
  FOREIGN KEY (order_id) REFERENCES Orders(order_id));

  INSERT INTO Users (name, email, password, phone, address, role) 
VALUES 
('John Doe', 'john@example.com', 'password123', '1234567890', '123 Main St, City', 'customer'),
('Jane Smith', 'jane@example.com', 'password456', '0987654321', '456 Elm St, City', 'customer'),
('Admin', 'admin@example.com', 'adminpassword', NULL, NULL, 'admin');

INSERT INTO Categories (name, description) VALUES 
('Electronics', 'Gadgets and devices'),
('Fashion', 'Clothes and accessories'),
('Books', 'All kinds of books');

INSERT INTO Products (name, description, price, stock_quantity, category_id) 
VALUES 
('Smartphone X', 'Latest smartphone', 699.99, 50, 1),
('Wireless Headphones', 'Noise-cancelling', 199.99, 100, 1),
('Leather Jacket', 'Stylish black jacket', 149.99, 30, 2),
('Novel XYZ', 'Bestseller novel', 19.99, 200, 3);

INSERT INTO Orders (user_id, order_date, status) 
VALUES
(1, '2024-12-01 10:30:00', 'pending'),
(2, '2024-12-02 15:45:00', 'shipped'),
(1, '2024-12-05 12:00:00', 'delivered');

INSERT INTO Order_Details (order_id, product_id, quantity, subtotal) 
VALUES 
(1, 1, 2, 1399.98),
(1, 2, 1, 199.99),
(2, 3, 1, 149.99);

INSERT INTO Payments (order_id, payment_date, payment_method, amount) 
VALUES
(1, '2024-12-01 11:00:00', 'credit_card', 1599.97),
(2, '2024-12-02 16:00:00', 'paypal', 149.99);

INSERT INTO Shipping (order_id, shipping_address, shipping_date, status, delivery_date) 
VALUES
(1, '123 Main St, City', '2024-12-01 14:00:00', 'in transit', '2024-12-03'),
(2, '456 Elm St, City', '2024-12-02 17:00:00', 'delivered', '2024-12-05');
