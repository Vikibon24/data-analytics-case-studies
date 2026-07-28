# Revenue Metrics Dashboard

## Tech Stack
- **Database**: PostgreSQL
- **Query tool**: DBeaver
- **Visualization**: Tableau Public

## Project Objective
The goal of this project was to build an interactive dashboard for analyzing monthly recurring revenue and paid user dynamics of a mobile gaming platform. The analysis focused on identifying why revenue and the paid user base change from month to month — not just tracking the numbers themselves, but breaking each change down into its underlying drivers (new customers, churned customers ...).

### Key Questions
- How does MRR change month over month?
- How many users are paying customers each month, and how many are new?
- What is the ARPPU?
- How many users churn each month, and how much revenue is lost as a result?
- What share of revenue growth (loss) comes from new users (churned users) vs. existing users paying more (less) (expansion/ contraction)?
- What is the average customer lifetime (LT) and lifetime value (LTV)?
- How do these metrics differ by user language, age, and payment month?

## Methodology

### 1. Base Revenue Table
- Aggregated raw payment records into monthly revenue per user using SUM() and DATE_TRUNC('month', ...).
- Grouped by user_id and calendar month to produce one row per user per active payment month.

### 2. Auxiliary Time Columns
- Used LAG() and LEAD() partitioned by user_id, ordered by payment month, to find each user's previous and next actual payment.
- Used MIN() OVER (PARTITION BY user_id) to identify each user's first payment month.
- Calculated the expected next calendar month (payment_month + INTERVAL '1 month') to detect gaps in payments.

### 3. Metric Flags at User-Month Level
- Flagged new users and new revenue with CASE WHEN payment_month = first_payment_month.
- Flagged churned users and churned revenue by comparing the actual next payment to the expected next calendar month, correctly attributing churn to the month after the last payment rather than the payment month itself.
- Flagged expansion and contraction revenue by comparing each user's revenue to their previous payment.

### 4. Monthly Aggregation for Tableau
- Joined pre-aggregated monthly totals (MRR, paid users, ARPPU) back onto the row-level data, so date/language/age filters keep working correctly across every chart.
- Preserved user-level granularity in the final output, so Tableau can aggregate under any filter combination.

### 5. Dashboard Build
- Exported the final query result from DBeaver as a CSV file and loaded it into Tableau Public.
- Built 13 individual metric sheets plus two combined waterfall charts showing revenue and user change factors.
- Used table calculations (LOOKUP) for month-over-month comparisons (Churn Rate, Revenue Churn Rate, LT, LTV).


## Key Findings
- The paid user base grew 4.6x over the observed period (43 → 199 users), while ARPPU stayed remarkably stable ($43–49) — indicating growth was driven mainly by customer acquisition, not by users spending more per capita.
- Churn Rate peaked at 35.7% in November, coinciding with a slowdown in overall paid user growth — a signal that retention, not acquisition, is the area needing attention going forward.
- Revenue and user "change factors" charts show that new customer acquisition consistently outweighed losses from churn in most months, but the balance narrowed significantly toward the end of the year.

## Project Materials
- Full Python script with detailed comments: [revenue_metrics_dashboard.sql](revenue_metrics_dashboard.sql)
- Tableau: https://public.tableau.com/views/final_project_17849124752920/RevenueMetrics?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link
