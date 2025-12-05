# Superstore Profit Decline Analysis

## Project Overview

Analyzed retail sales data to diagnose declining profitability and identify actionable opportunities for margin improvement. Using SQL and Power BI, I uncovered that excessive discounting is driving unsustainable margins and profit losses, particularly in the Furniture category, despite strong sales growth.

**Analysis Tools:** SQL (SQLite), Power BI

---

## Business Problem

After three years of consistent growth (2014-2016), the company's profit margin declined for the first time in 2017. Leadership needed to understand what was driving this reversal and how to address it
Key Question: What caused the profit margin to drop from 13.43% in 2016 to 12.74% in 2017?
---
## Analysis Approach
SQL Analysis
I analyzed 10,000+ transactions across four tables (orders, order_items, products, customers) spanning 2014-2017. Using SQL, I examined profitability across multiple dimensions to identify patterns and problem areas.
SQL Techniques Used:

Multi-table JOINs to combine data across tables
CTEs and subqueries for complex calculations
Window functions (LAG) for year-over-year comparisons
GROUP BY aggregations for category and time-based analysis
Date parsing and formatting for temporal trends

What I Analyzed:

Category and sub-category profitability
Year-over-year and month-over-month trends
Discount impact on profit margins
Geographic performance by state
Individual product profitability

Power BI Dashboard
I built an interactive dashboard to visualize the findings and enable stakeholders to explore the data. The dashboard shows the profit decline story through multiple lenses: time trends, category performance, and discount analysis.

## Key Findings

### 1. Critical Margin Disparity Across Categories

Analysis revealed a significant performance gap between product categories:

- **Overall Profit margin:** 12.74% (all categories combined)
- **Furniture profit margin:** 2.4% (isolated to Furniture products)

The Furniture category's 2.4% margin falls well below the operational break-even threshold of 5-8% needed to cover overhead, warehousing, and fulfillment costs. This low-margin category is systematically dragging down overall business performance.

### 2. Furniture Sub-Categories Drive Aggregate Losses

Drilling into sub-category performance identified Tables and Bookcases as the primary loss drivers. Both sub-categories generate consistent negative returns, with cumulative losses offsetting gains from profitable product lines.

**Root Cause:** High shipping costs for large, heavy items combined with competitive pricing pressure creates an unsustainable cost structure.

### 3. Discount Strategy Creates Negative Return Spiral

Correlation analysis between discount levels and profitability revealed a destructive pattern:

**Critical Finding:** Furniture category averages 17% discount rate on products with only 2.6% baseline margin—mathematically ensuring negative returns.

### 4. Year-over-Year Performance Deterioration

Time-series analysis shows consistent growth 2014-2016, with inflection point in 2017:
- 2016: 13.43% profit margin
- 2017: 12.74% profit margin (first decline)

This represents a 0.68% relative deterioration and signals that current business practices are unsustainable.

### 5. Geographic Performance Variability

Regional analysis identified West Virginia as the weakest geographic market, generating $1,600 in net losses. Likely driven by combination of shipping economics and regional discount patterns.

### 6. Individual Product Failures

Product-level analysis isolated the "Cubify CubeX 3D Printer Double Head Print" as generating the largest single-product loss. High unit cost combined with aggressive pricing creates significant per-transaction losses despite low transaction volume.

---

## Technical Approach

### SQL Analysis

Conducted multi-dimensional analysis using SQLite, querying across four normalized tables (orders, order_items, products, customers) with ~10,000 transactions spanning 2014-2017.

**Query Techniques Applied:**
- Multi-table JOINs for dimensional analysis
- CTEs for complex aggregations
- Window functions (LAG) for time-series trend analysis
- GROUP BY aggregations for categorical segmentation
- Text parsing functions (SUBSTR, PRINTF) for date normalization

**Analysis Dimensions:**
- Category and sub-category profitability
- Temporal trends (year-over-year, month-over-month)
- Discount impact correlation
- Geographic performance segmentation
- Customer segment analysis
- Individual product profitability

### Power BI Dashboard

Built interactive dashboard enabling stakeholders to explore findings across multiple dimensions:

**Dashboard Components:**
1. KPI Cards (Top Row):

Total Sales: $2.30M
Total Profit: $286.40K
2017 Profit Margin: 12.74%
Year-over-Year Decline: -0.68% (highlighted in red)

Key Visualizations:

1. 2017: First Profit Margin Decline (Line Chart)

Shows profit margin trend from 2014-2017
Visualizes growth through 2016, then decline in 2017
Data labels on each point for clarity


2. Furniture Operates at Critically Low 2.49% Margin (Bar Chart)

Compares profit margins across all three categories
Furniture highlighted in red to emphasize the problem
Office Supplies and Technology shown in blue for comparison


3. Furniture Discounts Average 17.39% (Highest) (Bar Chart)

Displays average discount percentage by category
Furniture bar in red shows 17.39% average discount
Demonstrates the root cause of low margins


4. Sales by Year (Line Chart)

Shows total sales growth trend 2014-2017
Illustrates that sales increased while margins declined


5. Top Loss-Making Products (Bar Chart)

Lists individual products generating losses
Cubify printers shown as largest loss drivers
Negative values clearly visible


6. Tables and Bookcases Drive Sub-category Losses (Bar Chart)

Breaks down Furniture performance by sub-category
Tables and Bookcases shown with lowest margins
Identifies specific problem areas within Furniture


7. Discount vs Profit by Category (Scatter Plot)

Visualizes relationship between discount levels and profitability
Three data points (one per category)
Shows Furniture at highest discount with lowest margin

## Business Recommendations

Immediate Actions
1. Test Reduced Discounting on Furniture

Cap Furniture discounts at 12% maximum (currently 17.39%) for 30-day test period
Monitor sales volume, revenue, and customer response
If volume holds (>80%), continue with reduced discounts and restore profitability
If volume drops significantly (<60%), proceed to phase out low-margin products
Impact: Data-driven decision on pricing power vs. product-market fit

2. Implement Discount Governance

Set company-wide maximum discount of 15%
Require approval for Furniture discounts >10%
Monitor discount patterns by category
Impact: Prevent future margin erosion across all categories

3. Optimize Product Mix

Reduce Furniture inventory investment regardless of discount test results
Shift marketing focus to higher-margin categories (Technology, Office Supplies)
Impact: Improve overall portfolio economics

Strategic Initiatives (Based on Test Results)
4. If Discount Reduction Successful:

Maintain 10-12% discount cap on Furniture
Keep profitable sub-categories, discontinue only worst performers
Impact: Restore profitability while maintaining product selection

5. If Market Won't Support Profitable Pricing:

-Phase out Tables and Bookcases over 90 days
-Discontinue Cubify 3D printer and other loss-making products
-Clear inventory at controlled discounts
-Impact: Eliminate systematic losses, reallocate resources to profitable categories

6. Address Geographic Inefficiencies

Review West Virginia shipping costs and minimum order thresholds
Impact: Improve regional profitability

Projected Impact
Implementing these recommendations could:

Improve profit margins by 3-5 percentage points
Increase total profit by 25-35% through either restored margins or loss elimination
Volume may decrease 5-10% if products discontinued, but improved profitability compensates

### Key Takeaways
1. Sales growth doesn't always mean profit growth: The business increased total sales year-over-year, but profit margins declined. This taught me that revenue volume alone is misleading—you need to look at profitability per dollar sold.
2. Product mix is critical: Not all revenue is valuable. The Furniture category generates sales volume but operates at margins so low (2.49%) that it actually reduces overall profitability. High sales in the wrong category can hurt the business.
3. Discounting has a breaking point: There's a limit to how much you can discount before destroying profitability. When you discount products that already have thin margins, you're not driving profitable growth—you're creating systematic losses.
4. Combining tools reveals the full story: Using SQL to analyze the data and Power BI to visualize it allowed me to identify exactly where the problems were (Furniture), why they existed (over-discounting), and how much they cost the business (quantified impact).



---

## Technical Skills Demonstrated

- **SQL:** Complex multi-table queries, CTEs, window functions, aggregations, data transformations
- **Power BI:** Interactive dashboards, DAX measures, data modeling, visualization design
- **Analytical Methods:** Root cause analysis, correlation analysis, trend identification, segmentation
- **Business Translation:** Converting data insights into actionable recommendations with quantified impact

---

## Data Specifications

**Source:** Superstore retail dataset (Kaggle)  
**Volume:** 10,000+ transactions  
**Time Range:** 2014-2017 (4 years)  
**Schema:** 4 normalized tables (orders, order_items, products, customers)  
**Categories:** Furniture, Office Supplies, Technology

---






