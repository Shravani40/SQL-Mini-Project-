CREATE DATABASE creditcard_system;
USE creditcard_system;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT,
    city VARCHAR(100),
    income DECIMAL(12,2)
);
CREATE TABLE Cards (
    card_id INT PRIMARY KEY,
    customer_id INT,
    card_type VARCHAR(50),
    provider VARCHAR(50),
    credit_limit DECIMAL(12,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
CREATE TABLE Merchants (
    merchant_id INT PRIMARY KEY,
    merchant_name VARCHAR(150) NOT NULL,
    category VARCHAR(100),
    risk_level VARCHAR(50),
    city VARCHAR(100)
);
CREATE TABLE Transactions (
    txn_id INT PRIMARY KEY,
    card_id INT,
    merchant_id INT,
    txn_amount DECIMAL(12,2),
    txn_date DATETIME,
    txn_type VARCHAR(50),
    status VARCHAR(50),
    FOREIGN KEY (card_id) REFERENCES Cards(card_id),
    FOREIGN KEY (merchant_id) REFERENCES Merchants(merchant_id)
);
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    customer_id INT,
    amount_paid DECIMAL(12,2),
    payment_mode VARCHAR(50),
    payment_date DATETIME,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
CREATE TABLE Rewards (
    reward_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    txn_id INT,
    reward_points INT,
    reward_date DATETIME,
    description VARCHAR(255),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (txn_id) REFERENCES Transactions(txn_id)
);
CREATE TABLE Disputes (
    dispute_id INT AUTO_INCREMENT PRIMARY KEY,
    txn_id INT,
    customer_id INT,
    reason VARCHAR(255),
    dispute_date DATETIME,
    status VARCHAR(50),
    resolution VARCHAR(255),
    FOREIGN KEY (txn_id) REFERENCES Transactions(txn_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

INSERT INTO Customers VALUES
(1, 'John Doe', 32, 'New York', 75000),
(2, 'Sarah Smith', 28, 'Chicago', 62000),
(3, 'Michael Brown', 45, 'San Francisco', 120000),
(4, 'Emily Johnson', 36, 'Los Angeles', 90000),
(5, 'David Lee', 50, 'Houston', 110000),
(6, 'Olivia Davis', 26, 'Seattle', 58000),
(7, 'Daniel Wilson', 40, 'Miami', 95000),
(8, 'Sophia Martinez', 30, 'Boston', 70000);

INSERT INTO Cards VALUES
(1, 1, 'Credit', 'Visa', 10000),
(2, 1, 'Credit', 'MasterCard', 15000),
(3, 2, 'Debit', 'Visa', 5000),
(4, 3, 'Credit', 'Amex', 20000),
(5, 4, 'Credit', 'Visa', 12000),
(6, 5, 'Debit', 'MasterCard', 7000),
(7, 6, 'Credit', 'Visa', 8000),
(8, 7, 'Credit', 'Amex', 15000);

INSERT INTO Merchants VALUES
(1, 'Amazon', 'E-commerce', 'Low', 'Seattle'),
(2, 'Best Buy', 'Electronics', 'Low', 'New York'),
(3, 'Starbucks', 'Food & Beverage', 'Medium', 'Chicago'),
(4, 'CryptoWorld', 'Finance', 'High', 'Miami'),
(5, 'Walmart', 'Retail', 'Low', 'Houston'),
(6, 'Apple Store', 'Electronics', 'Low', 'Los Angeles'),
(7, 'Target', 'Retail', 'Low', 'Boston'),
(8, 'Local Cafe', 'Food & Beverage', 'Medium', 'San Francisco');

INSERT INTO Transactions VALUES
(1, 1, 1, 120.50, '2025-01-10 10:15:00', 'Purchase', 'Success'),
(2, 2, 2, 540.00, '2025-01-12 14:20:00', 'Purchase', 'Success'),
(3, 3, 3, 8.75, '2025-01-15 09:00:00', 'Purchase', 'Success'),
(4, 4, 4, 150000.00, '2025-02-18 17:30:00', 'Purchase', 'Flagged'),
(5, 1, 3, 100005.25, '2025-02-20 08:10:00', 'Purchase', 'Flagged'),
(6, 5, 5, 200.00, '2025-02-22 13:45:00', 'Purchase', 'Success'),
(7, 6, 6, 999.99, '2025-03-25 16:00:00', 'Purchase', 'Success'),
(8, 7, 7, 45.50, '2025-03-28 11:30:00', 'Purchase', 'Success');

INSERT INTO Payments VALUES
(1, 1, 250.00, 'Credit Card', '2025-01-11 11:00:00'),
(2, 2, 100.00, 'UPI', '2025-01-13 12:00:00'),
(3, 3, 500.00, 'Bank Transfer', '2025-01-17 16:45:00'),
(4, 4, 300.00, 'Debit Card', '2025-01-23 10:30:00'),
(5, 5, 450.00, 'Credit Card', '2025-01-24 09:15:00'),
(6, 6, 120.00, 'UPI', '2025-01-26 14:20:00'),
(7, 7, 600.00, 'Bank Transfer', '2025-01-29 15:50:00'),
(8, 8, 350.00, 'Credit Card', '2025-01-30 10:40:00');

INSERT INTO Rewards VALUES
(1, 1, 1, 12, '2025-01-10 10:20:00', 'Purchase Reward'),
(2, 2, 2, 54, '2025-01-12 14:25:00', 'High-value transaction bonus'),
(3, 1, 5, 5, '2025-01-20 08:15:00', 'Coffee purchase reward'),
(4, 4, 6, 20, '2025-01-22 13:50:00', 'Retail shopping reward'),
(5, 6, 7, 50, '2025-01-25 16:05:00', 'Electronics purchase reward'),
(6, 7, 8, 4, '2025-01-28 11:35:00', 'Small purchase reward'),
(7, 3, 3, 1, '2025-01-15 09:05:00', 'Coffee reward'),
(8, 5, 6, 20, '2025-01-22 13:55:00', 'Retail reward bonus');

INSERT INTO Disputes VALUES
(1, 4, 3, 'Suspicious high-value transaction', '2025-01-19 09:00:00', 'Pending', NULL),
(2, 2, 1, 'Incorrect billing amount', '2025-01-13 10:30:00', 'Resolved', 'Refund processed'),
(3, 5, 1, 'Wrong transaction amount', '2025-01-21 08:30:00', 'Resolved', 'Corrected'),
(4, 6, 4, 'Duplicate charge', '2025-01-23 14:00:00', 'Pending', NULL),
(5, 7, 6, 'Unauthorized transaction', '2025-01-26 14:30:00', 'Investigating', NULL),
(6, 8, 7, 'Refund not received', '2025-01-29 12:00:00', 'Pending', NULL),
(7, 3, 3, 'Incorrect reward points applied', '2025-01-16 09:30:00', 'Resolved', 'Points corrected'),
(8, 1, 1, 'Transaction date mismatch', '2025-01-11 12:00:00', 'Resolved', 'Adjusted');

INSERT INTO Customers(customer_id, name) VALUES (9, 'Atulya Singh');
SELECT * FROM Customers;

DELETE FROM Customers 
WHERE customer_id= 9;
SELECT * FROM Customers;

SELECT * FROM Disputes
WHERE status= 'Pending';

RENAME TABLE Customers to NewCustomers;
SELECT * FROM NewCustomers;

ALTER TABLE NewCustomers
DROP COLUMN age;
SELECT * FROM NewCustomers;

UPDATE NewCustomers
SET income= 100000
WHERE customer_id = 1;
SELECT * FROM NewCustomers;

SELECT 
    MONTH(txn_date) AS month,
    SUM(txn_amount) AS total_spent
FROM Transactions
GROUP BY month
ORDER BY month;

SELECT 
    AVG(txn_amount) AS avg_transaction_amount
FROM Transactions;

SELECT 
    p.payment_id,
    p.amount_paid,
    c.name
FROM Payments p
RIGHT JOIN NewCustomers c ON p.customer_id = c.customer_id;

SELECT 
    cd.card_id,
    cd.card_type,
    cd.credit_limit,
    t.txn_id,
    t.txn_amount
FROM Cards cd
LEFT JOIN Transactions t
    ON cd.card_id = t.card_id;

SELECT 
    c.name,
    r.reward_points,
    r.reward_date
FROM NewCustomers c
INNER JOIN Rewards r 
    ON c.customer_id = r.customer_id;

SELECT *
FROM Transactions
WHERE txn_amount > (
    SELECT AVG(txn_amount)
    FROM Transactions
);

CREATE VIEW Newcustomer_basic_view AS
SELECT 
    customer_id,
    name,
    city,
    income
FROM NewCustomers;

SELECT * FROM Newcustomer_basic_view;

CREATE VIEW payment_history_view AS
SELECT 
    p.payment_id,
    c.name,
    p.amount_paid,
    p.payment_date
FROM Payments p
JOIN NewCustomers c 
    ON p.customer_id = c.customer_id;

DELIMITER $$

CREATE PROCEDURE get_customer_transactions(IN cust_id INT)
BEGIN
    SELECT 
        t.txn_id,
        t.txn_amount,
        t.txn_date,
        t.status
    FROM Transactions t
    JOIN Cards cd ON t.card_id = cd.card_id
    WHERE cd.customer_id = cust_id;
END $$

DELIMITER ;
CALL get_customer_transactions(1);

SELECT 
    t.txn_id,
    t.txn_amount,
    t.txn_date,
    t.status,
    c.card_id,
    c.customer_id
FROM Transactions t
JOIN Cards c ON t.card_id = c.card_id
WHERE t.txn_amount > 100000
ORDER BY t.txn_amount DESC;


SELECT 
    customer_id,
    DATE(txn_date) AS txn_day,
    COUNT(*) AS daily_transaction_count
FROM Transactions
JOIN Cards  ON Transactions.card_id = Cards.card_id
GROUP BY Cards.customer_id, DATE(Transactions.txn_date);




