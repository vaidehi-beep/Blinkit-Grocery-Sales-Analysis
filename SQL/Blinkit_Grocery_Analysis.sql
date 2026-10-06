/*
=========================================================
Blinkit Grocery Sales Analysis
Database: SQL Server
Table: dbo.[BlinkIT Grocery Data]
Records: 8,523
=========================================================
*/


/*
=========================================================
01. DATA EXPLORATION
=========================================================
*/

-- View sample records
SELECT TOP 10 *
FROM dbo.[BlinkIT Grocery Data];


-- Check total number of records
SELECT COUNT(*) AS total_records
FROM dbo.[BlinkIT Grocery Data];


-- Check distinct item types
SELECT DISTINCT Item_Type
FROM dbo.[BlinkIT Grocery Data]
ORDER BY Item_Type;


-- Check distinct fat-content values
SELECT DISTINCT Item_Fat_Content
FROM dbo.[BlinkIT Grocery Data]
ORDER BY Item_Fat_Content;


-- Check distinct outlet types
SELECT DISTINCT Outlet_Type
FROM dbo.[BlinkIT Grocery Data]
ORDER BY Outlet_Type;


-- Check distinct outlet locations
SELECT DISTINCT Outlet_Location_Type
FROM dbo.[BlinkIT Grocery Data]
ORDER BY Outlet_Location_Type;


/*
=========================================================
02. DATA CLEANING
=========================================================
*/

-- Check inconsistent values in Item_Fat_Content
SELECT
    Item_Fat_Content,
    COUNT(*) AS record_count
FROM dbo.[BlinkIT Grocery Data]
GROUP BY Item_Fat_Content
ORDER BY record_count DESC;


-- Standardize inconsistent fat-content values
UPDATE dbo.[BlinkIT Grocery Data]
SET Item_Fat_Content =
    CASE
        WHEN Item_Fat_Content IN ('LF', 'low fat') THEN 'Low Fat'
        WHEN Item_Fat_Content = 'reg' THEN 'Regular'
        ELSE Item_Fat_Content
    END;


-- Verify cleaned values
SELECT
    Item_Fat_Content,
    COUNT(*) AS record_count
FROM dbo.[BlinkIT Grocery Data]
GROUP BY Item_Fat_Content
ORDER BY record_count DESC;


-- Check missing ratings
SELECT COUNT(*) AS missing_ratings
FROM dbo.[BlinkIT Grocery Data]
WHERE Rating IS NULL;


-- Check duplicate Item + Outlet combinations
SELECT
    Item_Identifier,
    Outlet_Identifier,
    COUNT(*) AS duplicate_count
FROM dbo.[BlinkIT Grocery Data]
GROUP BY
    Item_Identifier,
    Outlet_Identifier
HAVING COUNT(*) > 1;


/*
=========================================================
03. KPI ANALYSIS
=========================================================
*/

-- KPI 1: Total Sales
SELECT
    SUM(Sales) AS total_sales
FROM dbo.[BlinkIT Grocery Data];


-- KPI 2: Average Sales
SELECT
    AVG(Sales) AS average_sales
FROM dbo.[BlinkIT Grocery Data];


-- KPI 3: Average Rating
SELECT
    AVG(Rating) AS average_rating
FROM dbo.[BlinkIT Grocery Data];


-- KPI 4: Total Records
SELECT
    COUNT(*) AS total_records
FROM dbo.[BlinkIT Grocery Data];


/*
=========================================================
04. SALES ANALYSIS
=========================================================
*/

-- Sales by Fat Content
SELECT
    Item_Fat_Content,
    SUM(Sales) AS total_sales
FROM dbo.[BlinkIT Grocery Data]
GROUP BY Item_Fat_Content
ORDER BY total_sales DESC;


-- Sales by Item Type
SELECT
    Item_Type,
    SUM(Sales) AS total_sales
FROM dbo.[BlinkIT Grocery Data]
GROUP BY Item_Type
ORDER BY total_sales DESC;


-- Average Sales by Item Type
SELECT
    Item_Type,
    AVG(Sales) AS average_sales
FROM dbo.[BlinkIT Grocery Data]
GROUP BY Item_Type
ORDER BY average_sales DESC;


-- Average Rating by Item Type
SELECT
    Item_Type,
    AVG(Rating) AS average_rating
FROM dbo.[BlinkIT Grocery Data]
GROUP BY Item_Type
ORDER BY average_rating DESC;


-- Top 5 Item Types
SELECT TOP 5
    Item_Type,
    SUM(Sales) AS total_sales
FROM dbo.[BlinkIT Grocery Data]
GROUP BY Item_Type
ORDER BY total_sales DESC;


-- Item Types with sales above 100,000
SELECT
    Item_Type,
    SUM(Sales) AS total_sales
FROM dbo.[BlinkIT Grocery Data]
GROUP BY Item_Type
HAVING SUM(Sales) > 100000
ORDER BY total_sales DESC;


/*
=========================================================
05. OUTLET ANALYSIS
=========================================================
*/

-- Sales by Outlet Size
SELECT
    Outlet_Size,
    SUM(Sales) AS total_sales
FROM dbo.[BlinkIT Grocery Data]
GROUP BY Outlet_Size
ORDER BY total_sales DESC;


-- Sales by Outlet Location Tier
SELECT
    Outlet_Location_Type,
    SUM(Sales) AS total_sales
FROM dbo.[BlinkIT Grocery Data]
GROUP BY Outlet_Location_Type
ORDER BY total_sales DESC;


-- Sales by Outlet Type
SELECT
    Outlet_Type,
    SUM(Sales) AS total_sales
FROM dbo.[BlinkIT Grocery Data]
GROUP BY Outlet_Type
ORDER BY total_sales DESC;


-- Sales by Outlet Location and Outlet Type
SELECT
    Outlet_Location_Type,
    Outlet_Type,
    SUM(Sales) AS total_sales
FROM dbo.[BlinkIT Grocery Data]
GROUP BY
    Outlet_Location_Type,
    Outlet_Type
ORDER BY total_sales DESC;


-- Top 5 Outlets
SELECT TOP 5
    Outlet_Identifier,
    SUM(Sales) AS total_sales,
    AVG(Rating) AS average_rating
FROM dbo.[BlinkIT Grocery Data]
GROUP BY Outlet_Identifier
ORDER BY total_sales DESC;


-- Bottom 5 Outlets
SELECT TOP 5
    Outlet_Identifier,
    SUM(Sales) AS total_sales,
    AVG(Rating) AS average_rating
FROM dbo.[BlinkIT Grocery Data]
GROUP BY Outlet_Identifier
ORDER BY total_sales ASC;


-- Sales by Establishment Year
SELECT
    Outlet_Establishment_Year,
    SUM(Sales) AS total_sales,
    AVG(Sales) AS average_sales,
    COUNT(*) AS outlet_records
FROM dbo.[BlinkIT Grocery Data]
GROUP BY Outlet_Establishment_Year
ORDER BY Outlet_Establishment_Year;


-- Outlet Age vs Sales
SELECT
    Outlet_Identifier,
    Outlet_Establishment_Year,
    2026 - Outlet_Establishment_Year AS outlet_age,
    SUM(Sales) AS total_sales
FROM dbo.[BlinkIT Grocery Data]
GROUP BY
    Outlet_Identifier,
    Outlet_Establishment_Year
ORDER BY total_sales DESC;


/*
=========================================================
06. ADVANCED SQL ANALYSIS
=========================================================
*/

-- 1. Top-selling item within each Item Type
WITH ranked_items AS
(
    SELECT
        Item_Type,
        Item_Identifier,
        Sales,
        ROW_NUMBER() OVER
        (
            PARTITION BY Item_Type
            ORDER BY Sales DESC
        ) AS sales_rank
    FROM dbo.[BlinkIT Grocery Data]
)
SELECT
    Item_Type,
    Item_Identifier,
    Sales
FROM ranked_items
WHERE sales_rank = 1
ORDER BY Sales DESC;


-- 2. Rank outlets by total sales
WITH outlet_sales AS
(
    SELECT
        Outlet_Identifier,
        SUM(Sales) AS total_sales
    FROM dbo.[BlinkIT Grocery Data]
    GROUP BY Outlet_Identifier
)
SELECT
    Outlet_Identifier,
    total_sales,
    RANK() OVER
    (
        ORDER BY total_sales DESC
    ) AS sales_rank
FROM outlet_sales
ORDER BY sales_rank;


-- 3. Sales contribution percentage by Item Type
SELECT
    Item_Type,
    SUM(Sales) AS total_sales,
    ROUND
    (
        SUM(Sales) * 100.0 /
        SUM(SUM(Sales)) OVER (),
        2
    ) AS sales_contribution_percentage
FROM dbo.[BlinkIT Grocery Data]
GROUP BY Item_Type
ORDER BY sales_contribution_percentage DESC;


-- 4. Item Visibility vs Sales
SELECT
    CASE
        WHEN Item_Visibility < 0.10 THEN 'Low Visibility'
        WHEN Item_Visibility BETWEEN 0.10 AND 0.20
            THEN 'Medium Visibility'
        ELSE 'High Visibility'
    END AS visibility_category,
    COUNT(*) AS item_count,
    AVG(Sales) AS average_sales,
    SUM(Sales) AS total_sales
FROM dbo.[BlinkIT Grocery Data]
GROUP BY
    CASE
        WHEN Item_Visibility < 0.10 THEN 'Low Visibility'
        WHEN Item_Visibility BETWEEN 0.10 AND 0.20
            THEN 'Medium Visibility'
        ELSE 'High Visibility'
    END
ORDER BY average_sales DESC;


-- 5. Rating vs Sales
SELECT
    CASE
        WHEN Rating < 3.5 THEN 'Low Rating'
        WHEN Rating BETWEEN 3.5 AND 4.0
            THEN 'Medium Rating'
        ELSE 'High Rating'
    END AS rating_category,
    COUNT(*) AS item_count,
    AVG(Sales) AS average_sales,
    SUM(Sales) AS total_sales
FROM dbo.[BlinkIT Grocery Data]
GROUP BY
    CASE
        WHEN Rating < 3.5 THEN 'Low Rating'
        WHEN Rating BETWEEN 3.5 AND 4.0
            THEN 'Medium Rating'
        ELSE 'High Rating'
    END
ORDER BY average_sales DESC;


-- 6. High Sales + High Rating products
SELECT
    Item_Identifier,
    Item_Type,
    Sales,
    Rating,
    Outlet_Identifier
FROM dbo.[BlinkIT Grocery Data]
WHERE Sales > 200
  AND Rating >= 4
ORDER BY Sales DESC;


-- 7. Classify outlets based on sales performance
WITH outlet_sales AS
(
    SELECT
        Outlet_Identifier,
        SUM(Sales) AS total_sales
    FROM dbo.[BlinkIT Grocery Data]
    GROUP BY Outlet_Identifier
)
SELECT
    Outlet_Identifier,
    total_sales,
    CASE
        WHEN total_sales >= 130000
            THEN 'High Performer'
        WHEN total_sales >= 100000
            THEN 'Medium Performer'
        ELSE 'Low Performer'
    END AS performance_category
FROM outlet_sales
ORDER BY total_sales DESC;


-- 8. Advanced Outlet Analysis
SELECT
    Outlet_Identifier,
    Outlet_Type,
    Outlet_Location_Type,
    SUM(Sales) AS total_sales,
    AVG(Sales) AS average_sales,
    AVG(Rating) AS average_rating
FROM dbo.[BlinkIT Grocery Data]
GROUP BY
    Outlet_Identifier,
    Outlet_Type,
    Outlet_Location_Type
ORDER BY total_sales DESC;


/*
=========================================================
07. BUSINESS INSIGHTS
=========================================================
*/

-- Overall KPIs
-- Total Sales      : 1,201,681.49
-- Average Sales    : 140.99
-- Average Rating   : 3.97 / 5
-- Total Records    : 8,523

-- Key findings:
--
-- 1. Fruits and Vegetables generated the highest sales.
-- 2. Snack Foods were the second-highest sales category.
-- 3. The top five item categories contributed approximately
--    59% of total sales.
-- 4. Low Fat products generated higher sales than Regular products.
-- 5. Supermarket Type1 generated the highest sales among
--    outlet types.
-- 6. Tier 3 outlets generated the highest total sales.
-- 7. OUT035 was the highest-performing outlet by total sales.
-- 8. Higher item visibility did not necessarily result
--    in higher sales.
-- 9. Higher ratings did not automatically result in
--    higher sales.
-- 10. OUT019 had the lowest total sales but a very high
--     average rating, showing that ratings alone do not
--     determine sales performance.


/*
=========================================================
END OF ANALYSIS
=========================================================
*/
