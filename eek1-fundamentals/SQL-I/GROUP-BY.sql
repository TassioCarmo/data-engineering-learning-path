-- GROUP BY Exercises
-- Simple GROUP BY Exercises

-- Basic Aggregation: Write a query to count the number of employees in each department.

SELECT department, COUNT(*) AS 'Number of Employees'
FROM company
GROUP BY department;

-- Sum Calculation: Create a query to find the total sales amount for each product category.

SELECT category, SUM(product_sales) AS 'Total Sales'
FROM product
GROUP BY category;

-- Average Calculation: Write a query to calculate the average order value for each customer.

SELECT customer_id, AVG(order_value) AS 'Average Order Value'
FROM customer
GROUP BY customer_id;

-- Intermediate GROUP BY Exercises

-- Multiple Grouping Levels: Write a query to find the total sales by both year and quarter.

SELECT YEAR(sale_date) AS year, QUARTER(sale_date) AS quarter, SUM(sale_amount) AS total_sales
FROM sales
GROUP BY YEAR(sale_date), QUARTER(sale_date)
ORDER BY year, quarter;

-- Having Clause: Create a query to find departments with more than 10 employees.

SELECT department_name, COUNT(*) AS employee_count
FROM employees
GROUP BY department_name
HAVING COUNT(*) > 10;

-- Multiple Aggregations: Write a query to calculate the minimum, maximum, and average price for each product category.

SELECT product_category, 
       MIN(price) AS "minimum price", 
       MAX(price) AS "maximum price", 
       AVG(price) AS "average price"
FROM product
GROUP BY product_category;

-- Applied GROUP BY Exercises

Sales Performance Analysis: Create a comprehensive sales analysis query:

Group sales data by region, salesperson, and product category
Calculate year-over-year growth percentages
Include count of transactions and unique customers
Filter for underperforming regions (below target by 15%)
Sort by performance metrics


WITH CurrentYearSales AS (
    SELECT
        r.region_name,
        sp.salesperson_name,
        p.category_name,
        COUNT(DISTINCT s.transaction_id) AS transaction_count,
        COUNT(DISTINCT s.customer_id) AS unique_customers,
        SUM(s.sale_amount) AS current_year_sales
    FROM
        sales s
    JOIN
        regions r ON s.region_id = r.region_id
    JOIN
        salespeople sp ON s.salesperson_id = sp.salesperson_id
    JOIN
        products p ON s.product_id = p.product_id
    WHERE
        s.sale_date BETWEEN DATE_SUB(CURRENT_DATE(), INTERVAL 1 YEAR) AND CURRENT_DATE()
    GROUP BY
        r.region_name,
        sp.salesperson_name,
        p.category_name
),

PreviousYearSales AS (
    SELECT
        r.region_name,
        sp.salesperson_name,
        p.category_name,
        SUM(s.sale_amount) AS previous_year_sales
    FROM
        sales s
    JOIN
        regions r ON s.region_id = r.region_id
    JOIN
        salespeople sp ON s.salesperson_id = sp.salesperson_id
    JOIN
        products p ON s.product_id = p.product_id
    WHERE
        s.sale_date BETWEEN DATE_SUB(CURRENT_DATE(), INTERVAL 2 YEAR) AND DATE_SUB(CURRENT_DATE(), INTERVAL 1 YEAR)
    GROUP BY
        r.region_name,
        sp.salesperson_name,
        p.category_name
),

RegionTargets AS (
    SELECT
        region_name,
        target_amount
    FROM
        region_targets
    WHERE
        target_year = YEAR(CURRENT_DATE())
)

SELECT
    cy.region_name,
    cy.salesperson_name,
    cy.category_name,
    cy.transaction_count,
    cy.unique_customers,
    cy.current_year_sales,
    COALESCE(py.previous_year_sales, 0) AS previous_year_sales,
    CASE
        WHEN COALESCE(py.previous_year_sales, 0) > 0 
        THEN ((cy.current_year_sales - COALESCE(py.previous_year_sales, 0)) / COALESCE(py.previous_year_sales, 0)) * 100
        ELSE NULL
    END AS yoy_growth_percentage,
    rt.target_amount AS region_target,
    CASE
        WHEN rt.target_amount > 0 
        THEN ((cy.current_year_sales - rt.target_amount) / rt.target_amount) * 100
        ELSE NULL
    END AS target_performance_percentage
FROM
    CurrentYearSales cy
LEFT JOIN
    PreviousYearSales py ON cy.region_name = py.region_name 
                        AND cy.salesperson_name = py.salesperson_name 
                        AND cy.category_name = py.category_name
JOIN
    RegionTargets rt ON cy.region_name = rt.region_name
WHERE
    /* Filter for underperforming regions (below target by 15% or more) */
    ((cy.current_year_sales - rt.target_amount) / rt.target_amount) * 100 <= -15
ORDER BY
    /* Sort by performance metrics (worst performing first) */
    ((cy.current_year_sales - rt.target_amount) / rt.target_amount) * 100 ASC,
    cy.region_name,
    cy.salesperson_name,
    cy.category_name;