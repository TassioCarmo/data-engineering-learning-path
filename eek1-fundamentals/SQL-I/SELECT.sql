-- SELECT Exercises
--Simple SELECT Exercises

-- Basic Column Selection: Write a query to select just the name and email columns from a customers table.

SELECT name,email FROM customers;

-- Column Aliases: Create a query that selects the product_name and unit_price columns from a products table, renaming them as "Product" and "Price" in the output.

SELECT product_name AS "Product" ,unit_price AS "Price" FROM products;

-- DISTINCT Selection: Write a query to select all unique department values from an employees table.

SELECT DISTINCT department FROM employees;


-- Intermediate SELECT Exercises

-- Calculated Columns: Write a SELECT statement that calculates a 15% discount on all products, showing original price and discounted price.

SELECT unit_price, unit_price * 0.85  FROM products;

-- String Manipulation: Create a query that combines first_name and last_name columns from a users table into a single "Full Name" column.

SELECT first_name || ' ' || last_name AS "Full Name" FROM users;


-- CASE Statements: Write a SELECT query that categorizes products as "Budget" (under $50), "Regular" ($50-$100), or "Premium" (over $100) based on their price.

SELECT unit_price ,
  CASE
    WHEN unit_price  < 50 THEN 'Budget'
    WHEN unit_price  BETWEEN 50 AND 100 THEN 'Regular'
    ELSE 'Premium'
  END AS categorizes 
FROM products;

-- Applied SELECT Exercises

-- Customer Report Generation: Create a comprehensive customer profile query that:

-- Selects customer demographic information
-- Includes calculated fields for account age and loyalty status
-- Formats phone numbers and addresses consistently
-- Limits sensitive information based on user permission level

SELECT 
    customer_id,
    first_name,
    last_name,
    -- Format phone number: assuming it's stored as digits (e.g., 1234567890)
    CONCAT('(', SUBSTRING(phone, 1, 3), ') ', SUBSTRING(phone, 4, 3), '-', SUBSTRING(phone, 7, 4)) AS formatted_phone,
    
    -- Format address consistently (assuming it's stored in parts like street, city, state, zip)
    CONCAT(street, ', ', city, ', ', state, ' ', zip) AS formatted_address,
    
    -- Calculate account age in years: assuming account_created is a date column
    TIMESTAMPDIFF(YEAR, account_created, CURDATE()) AS account_age,

    -- Loyalty status based on account age or points
    CASE
        WHEN TIMESTAMPDIFF(YEAR, account_created, CURDATE()) < 1 THEN 'New'
        WHEN loyalty_points > 1000 THEN 'Gold'
        ELSE 'Regular'
    END AS loyalty_status,
    
    -- Based on permission_level, show or hide sensitive info (email is considered sensitive)
    CASE
        WHEN permission_level >= 2 THEN email
        ELSE 'Email hidden'
    END AS email,
    
    -- Similarly, limit address or other info
    CASE
        WHEN permission_level >= 3 THEN address
        ELSE 'Address hidden'
    END AS address
FROM customers;