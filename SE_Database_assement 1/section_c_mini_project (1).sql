-- =============================================================================
-- MINIPROJECT: EXPENSE TRACKER DATABASE
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 1. SCHEMA SETUP (Context for Queries)
-- -----------------------------------------------------------------------------
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE expenses (
    expense_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    category_id INT,
    amount DECIMAL(10,2) NOT NULL,
    expense_date DATE NOT NULL,
    description VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);


-- -----------------------------------------------------------------------------
-- 2. CRUD OPERATIONS DEMONSTRATION
-- -----------------------------------------------------------------------------

-- [C]REATE: Insert new records
INSERT INTO users (username, email) VALUES 
('alice_green', 'alice@email.com'),
('bob_blue', 'bob@email.com');

INSERT INTO categories (category_name) VALUES 
('Food'), ('Rent'), ('Utilities'), ('Entertainment');

INSERT INTO expenses (user_id, category_id, amount, expense_date, description) VALUES 
(1, 1, 45.50, '2026-05-15', 'Grocery shopping'),
(1, 3, 120.00, '2026-05-18', 'Electricity bill'),
(2, 1, 15.00, '2026-05-19', 'Coffee with team'),
(2, 2, 1200.00, '2026-05-01', 'May Rent');

-- [R]EAD: Fetch and analyze data
SELECT 
    e.expense_id, 
    u.username, 
    c.category_name, 
    e.amount, 
    e.expense_date, 
    e.description
FROM expenses e
JOIN users u ON e.user_id = u.user_id
JOIN categories c ON e.category_id = c.category_id
ORDER BY e.expense_date DESC;

-- [U]PDATE: Modify an existing record
UPDATE expenses 
SET amount = 50.00, description = 'Grocery shopping (Updated)' 
WHERE expense_id = 1;

-- [D]ELETE: Remove a specific record
DELETE FROM expenses 
WHERE expense_id = 3;


-- -----------------------------------------------------------------------------
-- 3. STORED PROCEDURE: CALCULATE MONTHLY USER EXPENSE
-- -----------------------------------------------------------------------------
DELIMITER $$

CREATE PROCEDURE GetMonthlyUserExpense(
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
END$$

DELIMITER ;


-- -----------------------------------------------------------------------------
-- 4. TRANSACTION CONTROL (COMMIT AND ROLLBACK)
-- -----------------------------------------------------------------------------

-- Example A: Successful Batch Insert using COMMIT
START TRANSACTION;

INSERT INTO expenses (user_id, category_id, amount, expense_date, description)
VALUES (1, 4, 15.00, '2026-05-28', 'Movie Night');

INSERT INTO expenses (user_id, category_id, amount, expense_date, description)
VALUES (1, 1, 8.50, '2026-05-29', 'Snacks');

COMMIT;


-- Example B: Failed / Aborted Operation using ROLLBACK
START TRANSACTION;

INSERT INTO expenses (user_id, category_id, amount, expense_date, description)
VALUES (2, 4, 65.00, '2026-05-29', 'Concert Ticket');

-- Intentional foreign key violation to simulate failure
INSERT INTO expenses (user_id, category_id, amount, expense_date, description)
VALUES (999, 1, 500.00, '2026-05-29', 'Invalid User Transaction');

ROLLBACK;
