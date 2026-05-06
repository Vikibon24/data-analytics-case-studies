# Study case: BigQuery Analysis – eCommerce Insights

Official Documentation: This project follows the GA4 BigQuery Export Schema

## Tech Stack
- Google BigQuery to analyze data from a public Google Analytics 4 (GA4) dataset
- Advanced SQL features: `UNNEST`, window functions, partitioned tables

## Project Overview
The goal was to analyze detailed user activity from GA4. The dataset is nested, with arrays and structures, so it required transforming the data to understand user behavior, product performance, and session activity.

## Business Questions
- How to work with `ARRAY` and `STRUCT` fields?
- Which products generate the most revenue and how often do they appear in user sessions?
- Who are the most valuable customers (VIP users)?
- What are the most common entry points for user sessions?

## Methodology
1. Working with Nested Data
    - GA4 stores data in arrays, so I used `UNNEST` to flatten it and extract session IDs and event details.
2. Product Analysis
    - I summarized each product, calculated view/use frequency, and measured total revenue by multiplying price and quantity.
3. Efficient Filtering
    - I used `EXISTS` with `UNNEST` to find events for specific product categories without heavy joins.
4. Customer Segmentation
    - I used ranking functions like `RANK` and `ROW_NUMBER` to group users by spend and identify the top 20 customers.
5. Session Analysis
    - I grouped data by user and session ID to find the first event in each session and understand entry points.

## Additional Detail
- I converted raw timestamps into readable date/time format using a special function to make the data easier to analyze.

## Project Materials
- SQL file: [product_and_session_analysis.sql](product_and_session_analysis.sql)