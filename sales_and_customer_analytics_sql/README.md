# Study Case: Sales & Customer Analytics (SQL – PostgreSQL)

## Tech Stack
- PostgreSQL
- SQL functions: SUM, AVG, COUNT, CTEs, subqueries, and set operations (UNION ALL, INTERSECT)

## Project Overview
In this project, I worked as a Data Analyst for a retail company that sells products both online and in physical stores. The goal was to analyze customer behavior across both channels and connect online and offline data.

## Business Questions
- Who are the highest-spending customers across both channels?
- Which products and customers appear in both online and offline sales?
- How does the average order value differ between online and offline stores?
- How do high-value purchases change during the year?

## SQL Logic
1. **Data Integration (UNION ALL, INTERSECT)**  
    Combined data from online and offline tables using UNION ALL.  
    Used INTERSECT to find customers who shop in both channels. This helps identify loyal customers and supports cross-channel marketing.

2. **Financial Metrics (SUM, AVG, COUNT)**  
    Calculated the average order value (average check) using AVG.  
    Used SUM to calculate total revenue, and COUNT(DISTINCT) to count unique users.  
    Filtered only completed payments to ensure the revenue is correct.

3. **Advanced Filtering (Subqueries, HAVING)**  
    Wrote queries to find customers who buy more than 2 units of the same product.  
    This used subqueries inside WHERE conditions and HAVING to filter grouped results.

4. **Seasonality Analysis (CTEs + EXTRACT)**  
    Created CTEs (WITH clause) to organize complex queries.  
    Used EXTRACT(MONTH FROM date) to analyze monthly trends.  
    With HAVING, filtered customers who spend more than the average per month.

## Key Insights
- Found the top 3 products based on the number of unique customers.
- Identified online customers who spend more on single items than the average offline price.
- Compared total products sold and total orders in each channel.

## Database Structure
The database includes 9 connected tables that show the full customer journey:

### Online (E-commerce):
- Users (customer data)
- Orders (purchase info)
- Order items (products in each order)
- Payments (transaction status)
- Shipments (delivery info)
- Products (product details and prices)

### Offline (retail stores):
- Store orders (in-store purchases)
- Store order items (products bought in store)
- Store payments (payment info in store)

## Project Materials
- SQL file: [customer_and_sales_analysis.sql](customer_and_sales_analysis.sql)