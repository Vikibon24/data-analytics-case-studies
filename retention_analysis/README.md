# Retention Analysis with Cohort Analysis (SQL & Google Sheets)

## Project Overview
This project analyzes user retention duration post-signup, comparing organic users (natural signups) and promo users (promotion-driven signups) to assess long-term loyalty.

## Technical Workflow
1. **Data Cleaning (SQL)**: Standardized date formats, removed extraneous spaces, test data, and null values for improved dataset accuracy.
2. **Cohort Calculation**: Grouped users by signup month and computed month offsets between signup and activity dates.
3. **Data Aggregation**: Segmented users into promo and organic groups, then tallied unique active users per cohort over time.
4. **Visualization & Analysis (Google Sheets)**: Generated tables and heatmaps to illustrate retention trends and identify drop-off points.

## Key Metrics
- **Retention Rate**: Percentage of users remaining active over time.
- **Acquisition Quality**: Evaluation of value from promo users (high volume) versus organic users (potential longer retention).

## SQL Highlights
Utilized Common Table Expressions (CTEs) for code clarity, unified date formats, and applied date functions to measure user activity in months.

## Project Materials
- [Google Sheets Link](https://docs.google.com/spreadsheets/d/1ZPY4mYfiYrLPrzE-YWxfziLlDHrPI9SH-gzmBSIqpnM/edit?usp=sharing)
- [Google Presentation Link](https://docs.google.com/presentation/d/1SfUWeBBZXJDSQj5VVigKqrKwilrG7u7Z5rY5gW1qVSg/edit?usp=sharing)
- SQL file: [user_retention_cohort_analysis.sql](user_retention_cohort_analysis.sql)