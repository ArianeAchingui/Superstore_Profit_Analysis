-- ============================================================================
-- PROJECT: Superstore Profit Decline Analysis
-- AUTHOR: Ariane Achingui Tsafack
-- DATE:12/04/2025
-- DESCRIPTION: SQL queries to investigate causes of profit decline
-- DATABASE: Superstore SQLite Database
-- ============================================================================


-- Business Question: Which product categories have the lowest profit margin?
-- Approach: Aggregate total sales and total profit at the category level; compute profit margin as profit divided by sales.
-- Output: Categories ordered from lowest to highest profit margin.

SELECT 
    p.category,
    SUM(oi.profit) * 1.0 / SUM(oi.sales) AS profit_margin
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY profit_margin ASC;

-- Business Question: Which product sub-categories generate the largest total profit loss?
-- Approach: Join product and order item data, aggregate profit at the sub-category level.
-- Output: Sub-categories ordered from lowest to highest total profit to identify loss drivers.

SELECT 
    p.sub_category, 
    SUM(oi.profit) AS total_profit
FROM products p
INNER JOIN order_items oi 
    ON p.product_id = oi.product_id
GROUP BY p.sub_category
ORDER BY total_profit ASC;

-- Business Question: Which customer segments have the lowest overall profit margin?
-- Approach: Join customer, order, and order item data; calculate profit margin as profit divided by sales by segment.
-- Output: Customer segments ordered from lowest to highest profit margin.

SELECT c.segment, 
       SUM(oi.profit) * 1.0 / SUM(oi.sales) AS profit_margin
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.segment
ORDER BY profit_margin ASC;

-- Business Question: Which regions and state generate the lowest total profit?
-- Approach: Join customer, order, and order item data; aggregate profit by region.
-- Output: Regions ordered from lowest to highest total profit to identify weak markets.

SELECT c.region, c.state, SUM(oi.profit) AS total_profit
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.region, c.state
ORDER BY total_profit ASC;

-- Confirm profit is actually declining year-over-year
SELECT 
    substr(o.order_date, length(o.order_date) - 3, 4) AS year,
    SUM(oi.sales) AS total_sales,
    SUM(oi.profit) AS total_profit,
    SUM(oi.profit) * 1.0 / SUM(oi.sales) AS profit_margin
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY year
ORDER BY year;

-- Business Question: Which products generate the largest total profit loss?
-- Approach: Join product data with order item transactions and aggregate profit per product.
-- Output: Products ordered from lowest to highest total profit to identify loss-making items.

SELECT p.product_id, p.product_name, SUM(oi.profit) AS total_profit
FROM products p
INNER JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id
ORDER BY total_profit ASC;


-- Business Question: How does discount level impact overall profitability?
-- Approach: Group transactions by discount level and aggregate total sales and profit.
-- Output: Profitability by discount level, highlighting losses at higher discount rates.

SELECT 
    discount,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM order_items
GROUP BY discount
ORDER BY total_profit ASC;

-- Business Question: Which product categories show declining profit trends over time?
-- Approach: Convert order_date text (M/D/YYYY) into YEAR-MONTH format using substr/instr.
-- Aggregate monthly profit per category, then use LAG to compare month-over-month change.

WITH category_month_profit AS (
    SELECT
        p.category,
        
        -- Extract YEAR
        substr(o.order_date, length(o.order_date) - 3, 4) AS year,
        
        -- Extract MONTH (pad with leading zero)
        printf('%02d', substr(o.order_date, 1, instr(o.order_date, '/') - 1)) AS month,

        SUM(oi.profit) AS monthly_profit
    FROM products p
    JOIN order_items oi 
        ON p.product_id = oi.product_id
    JOIN orders o 
        ON oi.order_id = o.order_id
    GROUP BY p.category, year, month
)

SELECT
    category,
    year || '-' || month AS year_month,
    monthly_profit,
    LAG(monthly_profit) OVER (
        PARTITION BY category
        ORDER BY year, month
    ) AS previous_month_profit,
    monthly_profit 
        - LAG(monthly_profit) OVER (
            PARTITION BY category
            ORDER BY year, month
        ) AS month_over_month_change
FROM category_month_profit
ORDER BY category, year_month;

-- Business Question: Which categories give higher discounts, and how does it relate to total profit?
-- Approach: Calculate average discount and total profit per category.
-- Output: Categories sorted by highest discount to identify discount-heavy groups.

SELECT
    p.category,
    AVG(oi.discount) AS avg_discount,
    SUM(oi.profit) AS total_profit
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY avg_discount DESC;


-- Business Question:
-- How do discount usage and shipping mode influence customer profitability?
-- Approach:
--   1. Compute customer-level sales, profit, and discount metrics.
--   2. Identify the dominant shipping mode for each customer.
--   3. Join results and filter to loss-making customers.

WITH customer_profit AS (
    SELECT
        c.customer_id,
        c.customer_name,
        COUNT(DISTINCT o.order_id) AS order_count,
        SUM(oi.sales) AS total_sales,
        SUM(oi.profit) AS total_profit,
        AVG(oi.discount) AS avg_discount
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY c.customer_id, c.customer_name
),

customer_shipping AS (
    SELECT
        o.customer_id,
        o.ship_mode,
        COUNT(*) AS mode_count,
        RANK() OVER (
            PARTITION BY o.customer_id
            ORDER BY COUNT(*) DESC
        ) AS rk
    FROM orders o
    GROUP BY o.customer_id, o.ship_mode
)

SELECT
    cp.customer_id,
    cp.customer_name,
    cp.order_count,
    cp.total_sales,
    cp.total_profit,
    cp.avg_discount,
    cs.ship_mode AS dominant_shipping_mode
FROM customer_profit cp
JOIN customer_shipping cs
    ON cp.customer_id = cs.customer_id
WHERE cp.total_profit < 0
  AND cs.rk = 1
ORDER BY cp.total_profit ASC;

-- Business Question:
-- Which product sub-categories are driving the least profitability,
-- and how heavily are they discounted, within each main category?
--
-- Approach:
-- 1. Aggregate total sales, profit, and discount for each sub-category.
-- 2. Include main product category for better drilldown insights.
-- 3. Sort by total_profit ascending to surface the least profitable sub-categories.

WITH subcat_profit AS (
    SELECT
        p.category,
        p.sub_category,
        SUM(oi.sales) AS total_sales,
        SUM(oi.profit) AS total_profit,
        AVG(oi.discount) AS avg_discount
    FROM products p
    JOIN order_items oi
        ON p.product_id = oi.product_id
    GROUP BY p.category, p.sub_category
)

SELECT
    category,
    sub_category,
    total_sales,
    total_profit,
    avg_discount
FROM subcat_profit
ORDER BY total_profit ASC;