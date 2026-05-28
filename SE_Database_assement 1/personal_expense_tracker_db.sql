-- ========================================================
-- TOPS TECHNOLOGIES - ASSESSMENT FILE
-- DATABASE MANAGEMENT - SQL & PL/SQL
-- THEME: PERSONAL EXPENSE TRACKER DB
-- ========================================================

-- ========================================================
-- SECTION B: SQL HANDS-ON
-- ========================================================

-- 2. DML Operations

-- Insert 5 Users with unique names and emails
INSERT INTO users (user_id, name, email, created_at) VALUES
(1, 'Alice Smith', 'alice@email.com', '2026-01-10'),
(2, 'Bob Jones', 'bob@email.com', '2026-01-15'),
(3, 'Charlie Brown', 'charlie@email.com', '2026-02-01'),
(4, 'Diana Prince', 'diana@email.com', '2026-02-10'),
(5, 'Evan Wright', 'evan@email.com', '2026-03-05');

-- Insert 3 Categories
INSERT INTO categories (category_id, category_name) VALUES
(1, 'Food'),
(2, 'Rent'),
(3, 'Entertainment');

-- Insert 10 Expense Records distributed across different users and categories
INSERT INTO expenses (expense_id, user_id, category_id, amount, expense_date) VALUES
(101, 1, 1, 45.50, '2026-05-01'),
(102, 1, 3, 12.00, '2026-05-02'),
(103, 2, 2, 1200.00, '2026-05-01'),
(104, 2, 1, 85.20, '2026-05-04'),
(105, 3, 3, 60.00, '2026-05-05'),
(106, 4, 1, 25.00, '2026-05-06'),
(107, 1, 1, 15.75, '2026-05-07'),
(108, 1, 2, 950.00, '2026-05-01'),
(109, 1, 3, 30.00, '2026-05-10'),
(110, 1, 1, 50.00, '2026-05-12');

-- Update one incorrect expense: change the amount of a specific expense_id
UPDATE expenses 
SET amount = 55.00 
WHERE expense_id = 110;

-- Delete one expense: remove a record where the amount is less than a specific value (e.g., 20.00)
DELETE FROM expenses 
WHERE amount < 20.00;


-- 3. Data Retrieval

-- Display all expenses with details (using INNER JOIN)
SELECT e.expense_date, e.amount, u.name, c.category_name
FROM expenses e
INNER JOIN users u ON e.user_id = u.user_id
INNER JOIN categories c ON e.category_id = c.category_id;

-- Show total expense amount per category (using SUM and GROUP BY)
SELECT c.category_name, SUM(e.amount) AS total_spent
FROM expenses e
INNER JOIN categories c ON e.category_id = c.category_id
GROUP BY c.category_name;

-- Display users sorted by total spending (ordered from highest to lowest)
SELECT u.name, SUM(e.amount) AS total_spending
FROM users u
LEFT JOIN expenses e ON u.user_id = e.user_id
GROUP BY u.user_id, u.name
ORDER BY total_spending DESC;


-- 4. Views

-- Create a view named ActiveUsersView
CREATE VIEW ActiveUsersView AS
SELECT u.name, u.email
FROM users u
INNER JOIN expenses e ON u.user_id = e.user_id
GROUP BY u.user_id, u.name, u.email
HAVING COUNT(e.expense_id) > 5;

-- Query the view
SELECT * FROM ActiveUsersView;


-- ========================================================
-- SECTION C: MINI PROJECT
-- ========================================================

-- 1. CRUD Queries Examples

-- Create (Insert)
INSERT INTO expenses (expense_id, user_id, category_id, amount, expense_date) 
VALUES (111, 3, 1, 18.50, '2026-05-15');

-- Read (Select)
SELECT * FROM expenses WHERE user_id = 3;

-- Update
UPDATE expenses SET amount = 22.00 WHERE expense_id = 111;

-- Delete
DELETE FROM expenses WHERE expense_id = 111;


-- 2. Stored Procedure to Calculate Monthly User Expense
DELIMITER //

CREATE PROCEDURE CalculateMonthlyUserExpense(
    IN p_user_id INT,
    IN p_month INT,
    IN p_year INT,
    OUT p_total_expense DECIMAL(10,2)
)
BEGIN
    SELECT COALESCE(SUM(amount), 0.00)
    INTO p_total_expense
    FROM expenses
    WHERE user_id = p_user_id 
      AND MONTH(expense_date) = p_month 
      AND YEAR(expense_date) = p_year;
END //

DELIMITER ;


-- 3. Transaction Isolation (COMMIT & ROLLBACK)

-- Scenario A: Successful sequence committing variations safely
START TRANSACTION;

INSERT INTO expenses (expense_id, user_id, category_id, amount, expense_date)
VALUES (112, 4, 2, 1100.00, '2026-06-01');

COMMIT;


-- Scenario B: Rollback execution path isolating faulty or unwanted variations
START TRANSACTION;

INSERT INTO expenses (expense_id, user_id, category_id, amount, expense_date)
VALUES (113, 2, 1, 50000.00, '2026-05-18'); -- Input mistake: fat-finger entry

ROLLBACK;
