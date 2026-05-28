-- ========================================================
-- TOPS TECHNOLOGIES - ASSESSMENT FILE
-- DATABASE MANAGEMENT - SQL & PL/SQL
-- SECTION C: MINI PROJECT (EXPENSE TRACKER DB)
-- ========================================================

-- ========================================================
-- 1. WRITE CRUD QUERIES
-- ========================================================

-- QUESTION: Write basic CRUD (Create, Read, Update, Delete) queries using the schema.

-- [CREATE] Insert a new expense record
INSERT INTO expenses (expense_id, user_id, category_id, amount, expense_date) 
VALUES (111, 3, 1, 18.50, '2026-05-15');

-- [READ] Select and display expenses for a specific user
SELECT * FROM expenses 
WHERE user_id = 3;

-- [UPDATE] Update the amount of a specific expense record
UPDATE expenses 
SET amount = 22.00 
WHERE expense_id = 111;

-- [DELETE] Remove a specific expense record from the system
DELETE FROM expenses 
WHERE expense_id = 111;


-- ========================================================
-- 2. STORED PROCEDURE TO CALCULATE MONTHLY USER EXPENSE
-- ========================================================

-- QUESTION: Write a stored procedure to calculate monthly user expense.

DELIMITER //

CREATE PROCEDURE CalculateMonthlyUserExpense(
    IN p_user_id INT,
    IN p_month INT,
    IN p_year INT,
    OUT p_total_expense DECIMAL(10,2)
)
BEGIN
    -- Aggregates total spent by a given user during a specific month and year
    SELECT COALESCE(SUM(amount), 0.00)
    INTO p_total_expense
    FROM expenses
    WHERE user_id = p_user_id 
      AND MONTH(expense_date) = p_month 
      AND YEAR(expense_date) = p_year;
END //

DELIMITER ;

/*
-- Example usage of how to execute this procedure:
CALL CalculateMonthlyUserExpense(1, 5, 2026, @total);
SELECT @total AS 'Total May Expenses for User 1';
*/


-- ========================================================
-- 3. TRANSACTION CONTROL (COMMIT AND ROLLBACK)
-- ========================================================

-- QUESTION: Demonstrate COMMIT and ROLLBACK with example queries.

-- Scenario A: Demonstrating COMMIT (Successful Transaction Execution)
-- This block represents a complete transaction that saves successfully.
START TRANSACTION;

-- Logging a valid insurance premium expense
INSERT INTO expenses (expense_id, user_id, category_id, amount, expense_date)
VALUES (112, 4, 2, 1100.00, '2026-06-01');

-- Committing changes permanently to the database
COMMIT;


-- Scenario B: Demonstrating ROLLBACK (Error Recovery / Data Safeguard)
-- This block shows how to revert changes if an error or invalid data is encountered.
START TRANSACTION;

-- Intended entry was $50.00 but entered $50000.00 by accident
INSERT INTO expenses (expense_id, user_id, category_id, amount, expense_date)
VALUES (113, 2, 1, 50000.00, '2026-05-18'); 

-- Catching the anomaly, we rollback to abort and undo this insert completely
ROLLBACK;

-- The database safely rejects expense record 113 as if it never happened.
