# Sales Analytics & Business Reporting (SQL)

## Overview

This project focuses on **analyzing sales data stored in a Data Warehouse** using advanced SQL techniques.
The analysis generates meaningful **business insights, customer intelligence, and product performance metrics**.

The project builds analytical reports on top of a **Gold Layer Data Warehouse** and demonstrates practical SQL skills used in real analytics workflows.

This project includes:

* Exploratory Data Analysis (EDA)
* Advanced analytical SQL queries
* Customer analytics report
* Product performance report
* Business KPI analysis

The goal is to transform raw warehouse data into **actionable business insights**.

---

# Project Structure

```
sales-analytics
│
├── sql
│   ├── eda.sql
│   ├── advanced_analysis.sql
│   ├── customer_report.sql
│   └── product_report.sql
│
├── docs
│   └── analytics_explanation.md
│
└── README.md
```

---

# Data Source

The analysis is performed on the **Gold Layer** of the Data Warehouse which contains:

### Fact Table

* `gold.fact_sales`

### Dimension Tables

* `gold.dim_customers`
* `gold.dim_products`

These tables store **clean, integrated, analytics-ready data** following a **Star Schema** model.

---

# Exploratory Data Analysis (EDA)

The EDA phase explores the structure and main characteristics of the dataset.

### Examples of analysis performed

* Total sales
* Total orders
* Total products
* Total customers
* Revenue by category
* Revenue by customer
* Product performance ranking
* Country distribution of customers
* Sales distribution across regions

Example query:

```sql
SELECT 
category_name,
SUM(sales_amount) AS total_revenue
FROM gold.fact_sales fs
LEFT JOIN gold.dim_products dp
ON fs.product_key = dp.product_key
GROUP BY category_name
ORDER BY total_revenue DESC
```

---

# Advanced SQL Analysis

Advanced analytics queries were developed to extract deeper business insights.

### Types of analysis included

### 1. Time-Based Analysis

Tracks sales performance over time.

Metrics analyzed:

* Monthly sales
* Customer growth
* Quantity sold

### 2. Cumulative Analysis

Uses **window functions** to calculate:

* Running total sales
* Moving averages

Example:

```sql
SUM(total_sales) OVER (ORDER BY order_date) AS running_total_sales
```

### 3. Performance Analysis

Compares product performance against:

* Average historical performance
* Previous year's sales

Techniques used:

* `LAG()`
* `WINDOW FUNCTIONS`

### 4. Part-to-Whole Analysis

Determines how much each category contributes to total revenue.

### 5. Data Segmentation

Customer segmentation:

| Segment | Definition                              |
| ------- | --------------------------------------- |
| VIP     | ≥12 months history and spending > $5000 |
| Regular | ≥12 months history and spending ≤ $5000 |
| New     | Less than 12 months of activity         |

Product segmentation:

| Segment        | Definition        |
| -------------- | ----------------- |
| High Performer | Sales > $50,000   |
| Mid Range      | $10,000 – $50,000 |
| Low Performer  | < $10,000         |

---

# Customer Analytics Report

The `gold.report_customers` view generates a **complete customer analytics dataset**.

### Metrics Included

* Total orders
* Total sales
* Total quantity purchased
* Number of products purchased
* Customer lifespan
* Recency (months since last purchase)
* Average order value
* Average monthly spending

### Additional Segmentation

Customers are grouped by:

**Age Groups**

* Under 20
* 20–29
* 30–39
* 40–49
* 50+

**Customer Segments**

* VIP
* Regular
* New

This report enables **customer lifetime analysis and segmentation.**

---

# Product Performance Report

The `gold.report_products` view provides **product-level analytics**.

### Metrics Included

* Total orders
* Total revenue
* Total quantity sold
* Total unique customers
* Product lifespan
* Recency of last sale
* Average selling price
* Average order revenue
* Average monthly revenue

### Product Segmentation

Products are categorized as:

| Segment        | Definition        |
| -------------- | ----------------- |
| High Performer | Sales > $50,000   |
| Mid Range      | $10,000 – $50,000 |
| Low Performer  | < $10,000         |

This report helps identify:

* Top performing products
* Underperforming products
* Product demand patterns

---

# Key SQL Concepts Used

This project demonstrates many **advanced SQL concepts** used in real analytics jobs:

* Window Functions
* Common Table Expressions (CTEs)
* Aggregations
* Data Segmentation
* Ranking Functions
* Time Series Analysis
* Running Totals
* Data Warehouse querying

---

# Business Insights Enabled

The analytics enable answers to questions like:

* What products generate the most revenue?
* Who are the most valuable customers?
* How do sales evolve over time?
* Which product categories dominate revenue?
* Which customers should be targeted for retention?

---

# Skills Demonstrated

* SQL Analytics
* Business KPI Analysis
* Customer Segmentation
* Product Performance Analysis
* Data Warehouse Querying
* Window Functions
* Analytical Thinking

---

# Future Improvements

Possible extensions for this project:

* Build a **Power BI dashboard**
* Add **customer lifetime value (CLV) modeling**
* Implement **RFM segmentation**
* Create **forecasting models**
* Automate reporting pipelines

---

# Related Project

This analytics project is built on top of a **Data Warehouse Engineering project** where the data model and pipelines were created.

The warehouse repository can be found here:

`(https://github.com/YusufRyan1/sql-data-warehouse-project)`
