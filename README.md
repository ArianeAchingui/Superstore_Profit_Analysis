# Superstore Profit Decline Analysis

## Project Overview

In this project, I analyzed retail sales data to understand why the company's profit margin declined in 2017, even though sales continued to grow.

Using SQL and Power BI, I compared sales and profitability across product categories, subcategories, products, and geographic areas. The analysis highlighted Furniture as a major area of concern, with high discounts and very low profit margins.

## Business Questions

- Why did the profit margin decline in 2017?
- Which product categories and subcategories were the least profitable?
- How were discounts related to profitability?
- Which products and states generated the largest losses?
- What could the business do to improve profitability?

## Dataset

The project uses a Superstore retail dataset from Kaggle, covering 2014–2017.

- **Records:** 10,000+ transactions
- **Tables:** Orders, order items, products, and customers
- **Product categories:** Furniture, Office Supplies, and Technology

## Analysis Approach

### SQL Analysis

I used SQL with SQLite to combine and analyze data from the four tables.

The analysis included:

- Sales and profit margin trends over time
- Profitability by category and subcategory
- Discount patterns and their relationship to profit
- Product-level and geographic performance
- Year-over-year comparisons using `LAG()`

I also used joins, CTEs, aggregations, and date transformations to organize the data and answer the business questions.

### Power BI Dashboard

I built an interactive Power BI dashboard to explore the results and compare sales and profitability across different categories, products, and time periods.

## Key Findings

- **Profit margin declined in 2017.** It fell from 13.43% in 2016 to 12.74% in 2017, even though sales continued to increase.
- **Furniture had very low profitability.** Its profit margin was approximately 2.5%, considerably below the margins of the other major categories.
- **Tables and Bookcases were problem areas.** Both subcategories showed poor profitability, with losses affecting the Furniture category's overall performance.
- **Furniture had the highest average discount.** At approximately 17.4%, its average discount was higher than those of the other categories. This pattern, combined with its low profit margin, suggested that discounting deserved further investigation.
- **Some products and locations generated losses.** Product-level analysis identified a Cubify 3D printer as a major loss-making product, while West Virginia had approximately $1,600 in net losses.

## Recommendations

Based on the findings, I would recommend:

1. **Review Furniture discount policies.** Test lower discounts and monitor how they affect sales volume and profitability before making permanent changes.
2. **Investigate low-performing subcategories and products.** Review pricing, costs, and demand for Tables, Bookcases, and other loss-making products.
3. **Compare profitability across categories.** Consider opportunities to focus more on products and categories that generate stronger profit margins.
4. **Investigate geographic losses.** Review shipping costs and sales patterns in underperforming locations, including West Virginia.

These recommendations would need to be tested against actual business costs and customer behavior before implementation.

## Tools Used

- **SQL / SQLite** — Data analysis, joins, CTEs, aggregations, and window functions
- **Power BI** — Data modeling, measures, interactive dashboard, and visualizations
- **Git / GitHub** — Project documentation and version control

## What I Learned

This project helped me understand why increasing sales does not always mean increasing profitability. By using SQL to investigate different parts of the business and Power BI to visualize the results, I was able to identify areas that needed further attention and develop recommendations based on the data.
