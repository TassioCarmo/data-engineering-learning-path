-- JOIN Exercises
-- Simple JOIN Exercises

-- Basic Inner Join: Write a query to join a customers table with an orders table to display customer names alongside their orders.

SELECT c.customer_name, o.order_id
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id;

-- Left Join: Create a query using LEFT JOIN to find all customers and their orders, including customers who haven't placed any orders.




-- Multiple Table Join: Write a query to join three tables: orders, order_details, and products to show order information with product names.

-- Intermediate JOIN Exercises

-- Self Join: Create a query that joins the employees table to itself to find all pairs of employees who work in the same department.
-- Join with Aggregation: Write a query that joins customers and orders tables, then groups by customer to find the total spending of each customer.
-- Join with Filtering: Create a query that joins products and categories tables, filtering for only active products in specific categories.

-- Applied JOIN Exercises

-- E-commerce Analytics Dashboard: Design a comprehensive query for an e-commerce analytics dashboard:

-- Join customers, orders, products, and categories tables
-- Calculate customer lifetime value and purchase frequency
-- Analyze product performance by category and manufacturer
-- Identify cross-selling opportunities based on purchase patterns
-- Include YTD comparisons with previous year's data