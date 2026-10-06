# Business Findings

## Overall Performance

- Total Sales: 1,201,681.49
- Average Sales per Record: 140.99
- Average Rating: 3.97 / 5
- Total Records: 8,523

## Product Analysis

### Top-Selling Item Categories

The highest-selling item categories are:

1. Fruits and Vegetables — 178,124.08
2. Snack Foods — 175,433.92
3. Household — 135,976.53
4. Frozen Foods — 118,558.88
5. Dairy — 101,276.46

The top five categories contribute approximately 59% of total sales.

### Fat Content Analysis

- Low Fat products generated approximately 776,319.69 in sales.
- Regular products generated approximately 425,361.80 in sales.

Low Fat products contribute a larger share of overall sales.

## Outlet Analysis

### Top Outlet

OUT035 generated the highest total sales:

- Total Sales: 133,103.91
- Average Sales: 143.12
- Average Rating: 3.94

### Outlet Type

Supermarket Type1 generated the highest sales:

- Total Sales: 787,549.89

### Location Tier

Tier 3 outlets generated the highest total sales:

- Total Sales: 472,133.03

## Visibility and Sales

The analysis shows that higher item visibility does not necessarily result in higher sales.

Low-visibility products had a slightly higher average sales value than medium- and high-visibility products.

## Rating and Sales

Higher ratings do not automatically result in higher sales.

Medium-rated products had the highest average sales among the rating categories analyzed.

## Advanced SQL Findings

- Window functions were used to identify the top-selling item within each item category.
- `RANK()` was used to rank outlets based on total sales.
- Window functions were also used to calculate each item category's contribution to total sales.
- `CASE` statements were used to classify outlets into High, Medium, and Low performers.

## Key Business Insights

1. Fruits and Vegetables and Snack Foods are the strongest product categories.
2. The top five product categories contribute approximately 59% of total sales.
3. Low Fat products generate significantly higher sales than Regular products.
4. Supermarket Type1 is the strongest outlet type by total sales.
5. Tier 3 outlets generate the highest total sales.
6. Outlet sales performance is not determined by rating alone.
7. Item visibility does not show a direct positive relationship with sales.
8. OUT035 is the highest-performing outlet by total sales.
9. OUT019 has the lowest total sales but one of the highest average ratings, showing that high customer ratings do not necessarily translate into high sales.
