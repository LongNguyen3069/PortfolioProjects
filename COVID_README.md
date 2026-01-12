COVID-19 Global Analytics SQL Project
Project Overview

This project analyzes COVID-19 cases, deaths, and vaccination data using SQL Server (T-SQL) to uncover insights about the pandemic's impact across countries and continents.

The focus is on calculating infection rates, death percentages, vaccination progress, and exploring population-level trends. The queries are structured to support Tableau dashboards for visualization of key metrics.

Tools & Technologies

SQL Server (T-SQL)

SQL Server Management Studio (SSMS)

Tableau Public (for visualization)

Git & GitHub

Dataset Description

The project uses two primary tables:

1. CovidDeaths

Contains country-level COVID-19 statistics:

location – Country or region

continent – Continent of the location

date – Date of the record

total_cases – Cumulative COVID-19 cases

new_cases – Daily new cases

total_deaths – Cumulative deaths

new_deaths – Daily new deaths

population – Total population of the country

2. CovidVaccination

Contains vaccination data:

location – Country or region

date – Date of the record

new_vaccinations – Daily vaccinations administered

Skills Demonstrated

Data cleaning and preparation

Aggregate functions (SUM, MAX, AVG)

Calculating percentages and rates (death rate, infection rate, vaccination coverage)

Common Table Expressions (CTEs)

Window functions for cumulative calculations

Temporary tables for intermediate computations

View creation for Tableau dashboards

Time-series and population-based analysis

Key Analyses Performed
Case and Death Analysis

Total cases vs total deaths per country and continent

Death percentage calculation (likelihood of dying if infected)

Infection percentage relative to population

Countries and continents with the highest death counts

Vaccination Analysis

Total and rolling vaccinations per country

Percentage of population vaccinated

Comparison of vaccination progress across continents

Time-Series Analysis

Daily global cases and deaths

Yearly and monthly trends

Population-adjusted metrics over time

Population-Based Metrics

Highest infection rates relative to population

Deaths per population

Rolling vaccination coverage

Advanced SQL Features Used

CTEs for aggregations and cumulative calculations

Window functions for rolling totals of vaccinations

Temporary tables for intermediate results

Views to support Tableau dashboards

Tableau Integration

Queries were structured to support interactive dashboards, including:

Global and continent-level cases and deaths

Infection and death rates by country

Vaccination progress over time

Comparison of total cases vs population

Repository Structure
├── Covid_SQL_Project.sql
├── README.md

How to Run This Project

Import the CovidDeaths and CovidVaccination datasets into SQL Server

Ensure both tables are in the database PortfolioProject

Run the SQL script sequentially in SSMS

Connect Tableau to SQL Server or the created views

Build dashboards using the queries

Key Takeaways

Infection and death rates vary significantly across continents and countries

Population-adjusted metrics are critical for understanding pandemic impact

Vaccination progress can be tracked cumulatively using rolling sums

Window functions and CTEs simplify complex time-series calculations for visualization

Author

Long Nguyen
Aspiring Data Analyst
SQL | Tableau | Data Analytics
