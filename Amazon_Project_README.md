Amazon Sales & Reviews SQL Analysis
Project Overview

This project analyzes an Amazon Sales and Reviews dataset using SQL Server (T-SQL) to uncover insights related to product pricing, customer ratings, and sentiment trends across brands.

The goal is to demonstrate real-world SQL skills such as data exploration, aggregation, joins, window functions, CTEs, temp tables, and view creation, while producing analysis-ready outputs for Tableau visualizations.

Tools & Technologies

SQL Server (T-SQL)

SQL Server Management Studio (SSMS)

Tableau Public (for visualization)

Git & GitHub

Dataset Description

The project uses two tables:

1. Amazon_Ratings

Contains product review and sentiment data:

Name

Brand

Rating

No_of_ratings

Review_Text

Cleaned_Review_Text

Sentiment (Positive / Negative)

2. Amazon_Price

Contains pricing data:

Name

Brand

Actual_Price

Discount_Price

Skills Demonstrated

Data exploration and validation

Aggregate functions (AVG, SUM, COUNT)

Filtering and sorting

Joins across multiple tables

Window functions (OVER, PARTITION BY)

Common Table Expressions (CTEs)

Temporary tables

View creation for BI tools

Data type conversion

Business-driven analysis

Key Analyses Performed
Ratings & Sentiment Analysis

Average rating by brand

Brands with the most negative reviews

Products driving negative sentiment

Brands with the highest positive ratings

Sentiment distribution percentages

Pricing Analysis

Net price calculation (Actual – Discount)

Average net price by product and brand

Discount percentage by brand

Price comparison vs customer ratings

Brand-Level Insights

Total number of ratings by brand

Average rating by brand

Relationship between pricing, discounts, and sentiment

Advanced SQL Features Used
Common Table Expressions (CTEs)

Simplified complex window function calculations and brand-level aggregations.

Temporary Tables

Calculated average net prices and discount percentages efficiently.

Views

Created reusable views for Tableau:

total_net_price

vw_sentiment_distribution

Tableau Integration

This project was designed for visualization. SQL queries were structured to directly power dashboards, including:

KPI summary

Average price vs discount price

Discount percentage by brand

Rating distribution

Sentiment breakdown

Repository Structure
├── Amazon_SQL_Project.sql
├── README.md

How to Run This Project

Import the dataset into SQL Server

Ensure both tables are in the same database (AmazonProject)

Run the SQL script sequentially in SSMS

Connect Tableau to SQL Server or created views

Build dashboards using the provided queries

Key Takeaways

Brands with extreme ratings (1 or 5) show clear sentiment patterns

Heavy discounting does not always correlate with higher ratings

Sentiment analysis helps identify product improvement opportunities

Window functions and views simplify BI workflows

Author

Long Nguyen
Aspiring Data Analyst
SQL | Tableau | Data Analytics
