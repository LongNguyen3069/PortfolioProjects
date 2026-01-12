MrBeast YouTube Channel Analytics
Project Overview

This project analyzes MrBeast’s YouTube channel data using SQL Server (T-SQL) to understand video performance, audience engagement, and content trends over time.

The focus is on deriving actionable insights from video metrics such as views, likes, comments, and upload patterns. Queries are designed for both analysis and visualization in Tableau.

Tools & Technologies

SQL Server (T-SQL)

SQL Server Management Studio (SSMS)

Tableau Public (for visualization)

Git & GitHub

Dataset Description

The dataset contains detailed statistics for MrBeast’s videos, including:

title – Video title

status – Video type (video or shorts)

published_date – Date the video was published

views – Number of views

likes – Number of likes

comments – Number of comments

duration_sec – Video duration in seconds

Skills Demonstrated

Data cleaning and preparation

Aggregate functions (COUNT, SUM, AVG)

Common Table Expressions (CTEs)

Window functions (LAG())

Self-joins for year-over-year calculations

View creation for Tableau dashboards

Audience engagement calculations

Time-series analysis

Key Analyses Performed
Video Performance Analysis

Total videos, views, likes, comments, and average video duration

Top 10 videos and shorts by views

Bottom 10 videos by views

Views, likes, and comments by video type

Engagement & Audience Behavior

Average views per video type (video vs shorts)

Audience participation per video (views + likes + comments)

Engagement ratios (likes-to-views, comments-to-views, overall engagement)

Time-Based Analysis

Videos uploaded per year and average views per year

Performance by publish day of the week

Upload frequency vs average views per month

Year-over-year growth in total views using both LAG() and self-join methods

Aggregated Insights

Performance over 5-year bins

Average audience participation per video type

KPI summaries for Tableau dashboards

Advanced SQL Features Used

CTEs for aggregations and simplification of complex queries

Window functions for year-over-year growth calculations

Self-joins for comparative year analysis

Views for reusable dashboards in Tableau

Tableau Integration

This project was structured for visualization. Queries were designed to support dashboards, including:

Video KPI summary

Top-performing videos and shorts

Engagement metrics

Upload strategy and timing analysis

Views vs likes and video duration

Repository Structure
├── MrBeast_SQL_Project.sql
├── README.md

How to Run This Project

Import the dataset into SQL Server

Ensure the table is in the database MrBeastPortfolio

Run the SQL script sequentially in SSMS

Connect Tableau to SQL Server or the created views

Build dashboards using the queries

Key Takeaways

Shorts and regular videos show distinct engagement patterns

High views do not always correlate with high likes or comments

Publishing trends and upload timing affect audience engagement

Window functions and CTEs simplify time-series analysis for dashboards

Author

Long Nguyen
Aspiring Data Analyst
SQL | Tableau | Data Analytics
