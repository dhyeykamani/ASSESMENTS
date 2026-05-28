-- ========================================================
-- TOPS TECHNOLOGIES - ASSESSMENT FILE
-- DATABASE MANAGEMENT - SQL & PL/SQL
-- SECTION B: SQL HANDS-ON (ALL TASKS)
-- ========================================================

-- ========================================================
-- 1. DDL Understanding
-- ========================================================

/*
QUESTION:
Without modifying the schema:
Explain why foreign keys are used: Specifically, why must user_id in
the expenses table correspond to a real ID in the users table?

ANSWER:
The user_id in the 'expenses' table points to a valid ID in the 'users' table 
to enforce Referential Integrity. This prevents the database from creating 
"ghost" expenses that don't belong to any real user, keeping the data clean 
and trustworthy.
*/

/*
QUESTION:
Mention one issue that would occur if foreign keys were removed:
Describe the risk of "Orphaned Records" (e.g., an expense existing for a
user who has been deleted).

ANSWER:
Without foreign keys, deleting a user leaves all their historical transactions 
behind in the 'expenses' table. These are known as "Orphaned Records". 
Because they point to a user ID that no longer exists, they distort financial 
metrics and make data analytics highly inaccurate.
*/


-- ========================================================
-- 2. DML Operations
-- ========================================================

-- QUESTION: Write SQL queries to:
-- * Insert 5 users into the users table with unique names and emails.
-- * Insert 3 categories (e.g., 'Food', 'Rent', 'Entertainment').
-- * Insert 10 expense records distributed across different users and categories.
-- * Update one incorrect expense: Use the UPDATE command to change the amount of a specific expense_id.
-- * Delete one expense: Remove a record where the amount is less than a specific value.

-- Insert 5 Users
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

-- Insert 10 Expense Records
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

-- Update one incorrect expense
UPDATE expenses 
SET amount = 55.00 
WHERE expense_id = 110;

-- Delete one expense (where amount is less than 20.00)
DELETE FROM expenses 
WHERE amount < 20.00;


-- ========================================================
-- 3. Data Retrieval
-- ========================================================

-- QUESTION: Display all expenses with details: Show the expense_date, amount, 
-- name (from users), and category_name (from categories) using INNER JOIN.
SELECT e.expense_date, e.amount, u.name, c.category_name
FROM expenses e
INNER JOIN users u ON e.user_id = u.user_id
INNER JOIN categories c ON e.category_id = c.category_id;


-- QUESTION: Show total expense amount per category: Use SUM(amount) and GROUP BY category_name.
SELECT c.category_name, SUM(e.amount) AS total_spent
FROM expenses e
INNER JOIN categories c ON e.category_id = c.category_id
GROUP BY c.category_name;


-- QUESTION: Display users sorted by total spending: List user names and their total 
-- sum of expenses, ordered from highest to lowest.
SELECT u.name, SUM(e.amount) AS total_spending
FROM users u
LEFT JOIN expenses e ON u.user_id = e.user_id
GROUP BY u.user_id, u.name
ORDER BY total_spending DESC;


-- ========================================================
-- 4. Views
-- ========================================================

-- QUESTION: Create a view named ActiveUsersView: This view should list the name 
-- and email of any user who has logged more than 5 individual expense records.
CREATE VIEW ActiveUsersView AS
SELECT u.name, u.email
FROM users u
INNER JOIN expenses e ON u.user_id = e.user_id
GROUP BY u.user_id, u.name, u.email
HAVING COUNT(e.expense_id) > 5;


-- QUESTION: Query the view: Write a simple SELECT statement to show all data from ActiveUsersView.
SELECT * FROM ActiveUsersView;
