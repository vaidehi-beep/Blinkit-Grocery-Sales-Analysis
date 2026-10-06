# Blinkit Grocery Sales Analysis

SQL-based analysis of Blinkit grocery sales data using Microsoft SQL Server.

## 📌 Project Overview

This project analyzes grocery sales data to identify sales trends, top-performing products, outlet performance, customer ratings, and other business insights.

The analysis was performed using SQL Server and focuses on practical SQL concepts used in data analysis and business intelligence.

## 🎯 Project Objectives

- Analyze overall sales performance
- Identify top-selling product categories
- Compare sales by fat content
- Analyze outlet performance
- Compare outlet types and location tiers
- Study item visibility and sales
- Analyze ratings and sales
- Rank outlets based on sales
- Calculate category contribution to total sales
- Classify outlets based on performance
- Generate actionable business insights

## 📊 Dataset

The dataset contains **8,523 records** and the following columns:

- `Item_Fat_Content`
- `Item_Identifier`
- `Item_Type`
- `Outlet_Establishment_Year`
- `Outlet_Identifier`
- `Outlet_Location_Type`
- `Outlet_Size`
- `Outlet_Type`
- `Item_Visibility`
- `Sales`
- `Rating`

The original CSV dataset is not included in this repository.

## 🛠️ Tools & Technologies

- Microsoft SQL Server
- SQL Server Management Studio (SSMS)
- SQL
- GitHub

## 🧠 SQL Concepts Used

This project demonstrates:

- SELECT
- DISTINCT
- TOP
- WHERE
- AND / OR / NOT
- GROUP BY
- HAVING
- ORDER BY
- Aggregate Functions
  - COUNT()
  - SUM()
  - AVG()
  - MAX()
  - MIN()
- CASE Statements
- Common Table Expressions (CTEs)
- ROW_NUMBER()
- RANK()
- Window Functions
- Data Cleaning
- Conditional Filtering
- Sales Contribution Analysis

## 📈 Key KPIs

| KPI | Value |
|---|---:|
| Total Sales | 1,201,681.49 |
| Average Sales | 140.99 |
| Average Rating | 3.97 / 5 |
| Total Records | 8,523 |

## 🔍 Key Findings

### Product Performance

- Fruits and Vegetables generated the highest total sales.
- Snack Foods were the second-highest sales category.
- The top five item categories contributed approximately 59% of total sales.
- Low Fat products generated higher sales than Regular products.

### Outlet Performance

- Supermarket Type1 generated the highest sales among outlet types.
- Tier 3 outlets generated the highest total sales among location tiers.
- OUT035 was the highest-performing outlet by total sales.
- OUT019 had the lowest total sales but a very high average rating.

### Visibility & Sales

The analysis shows that higher item visibility did not necessarily result in higher sales.

### Rating & Sales

Higher ratings did not automatically result in higher sales. This shows that ratings alone are not sufficient to explain sales performance.

## 📁 Project Structure

```text
Blinkit-Grocery-Sales-Analysis/
│
├── README.md
│
├── Dataset/
│   └── README.md
│
├── Documentation/
│   └── findings.md
│
└── SQL/
    └── Blinkit_Grocery_Analysis.sql
