-- WHERE Exercises
-- Simple WHERE Exercises

-- Basic Filtering: Write a query to select all products from the products table where the category is 'Books'.

SELECT products_name FROM products WHERE category = 'Books';

-- Numeric Comparison: Create a query to find all employees hired after January 1, 2023.

SELECT employee_name
FROM employee
WHERE hired > '2003-01-01';

-- Multiple Conditions: Write a query to find all orders with a total amount between $100 and $500.

SELECT orders_name 
FROM orders 
WHERE total_amount BETWEEN 100 AND 500 ;


-- Intermediate WHERE Exercises

-- Pattern Matching: Create a query using LIKE to find all customers whose email addresses are from gmail.com.

SELECT customers_name 
FROM customers 
WHERE email LIKE '%@gmail.com';


-- NULL Handling: Write a query to find all records in an orders table where the shipping_date is NULL.

SELECT records 
FROM orders 
WHERE shipping_date_datail IS NULL;

-- IN Operator: Create a query to find all products that belong to categories 'Electronics', 'Computers', or 'Accessories'.

SELECT products 
FROM orders 
WHERE categories LIKE IN ('Electronics', 'Computers', 'Accessories');


-- Applied WHERE Exercises

-- Fraud Detection Query: Design a query to identify potentially fraudulent transactions:

-- Filter transactions occurring outside customer's home country
-- Find multiple high-value transactions within a short time period
-- Identify unusual shipping addresses different from the billing address
-- Focus on high-risk product categories

SELECT 
    t.transaction_id,
    t.customer_id,
    c.customer_name,
    t.transaction_date,
    t.transaction_amount,
    t.product_category,
    t.shipping_address,
    t.billing_address,
    c.home_country,
    t.transaction_country,
    -- Count of high-value transactions by this customer in the last 24 hours
    (
        SELECT COUNT(*) 
        FROM transactions t2
        WHERE t2.customer_id = t.customer_id
        AND t2.transaction_amount > 1000
        AND t2.transaction_date BETWEEN t.transaction_date - INTERVAL '24 HOURS' AND t.transaction_date
    ) AS high_value_tx_24h
FROM 
    transactions t
JOIN 
    customers c ON t.customer_id = c.customer_id
WHERE 
    -- Transactions outside customer's home country
    t.transaction_country != c.home_country
    
    -- High-value transactions (over $1000)
    AND t.transaction_amount > 1000
    
    -- Shipping address different from billing address
    AND t.shipping_address != t.billing_address
    
    -- High-risk product categories
    AND t.product_category IN ('Electronics', 'Jewelry', 'Gift Cards', 'Digital Assets')
    
    -- Multiple high-value transactions check (via the subquery above)
    AND (
        SELECT COUNT(*) 
        FROM transactions t2
        WHERE t2.customer_id = t.customer_id
        AND t2.transaction_amount > 1000
        AND t2.transaction_date BETWEEN t.transaction_date - INTERVAL '24 HOURS' AND t.transaction_date
    ) >= 2
ORDER BY 
    t.customer_id,
    t.transaction_date DESC;