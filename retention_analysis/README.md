# Retention Analysis with Cohort Analysis 

## Tech Stack
- **Language**: SQL
- **Database / SQL Tool**: PostgreSQL (via DBeaver)
- **Visualization & Analysis Tool**: Google SheetsL 

## Project Overview
This project analyzes user retention duration post-signup, comparing organic users (natural signups) and promo users (promotion-driven signups) to assess long-term loyalty.

## Steps & Logic

### 1.**Data Processing (SQL)**:
- Cleaned inconsistent datetime formats (signup & event timestamps)
- Removed NULLs, test events, and invalid records
- Joined user and event tables using SQL JOIN
- Built cohorts based on signup month
- Calculated month offset (user lifecycle stage)

### 2.**Cohort Analysis Logic**:
- Grouped users by cohort month (signup period)
- Tracked user activity across monthly offsets (0–5)
- Segmented users into:
- Organic users
- Promo users
- Calculated retention trends across time

### 3.**Visualization (Google Sheets)**:
- Built pivot-based cohort tables
- Created retention rate table (% format)
- Used slicer for promo vs organic segmentation

## Key Metrics
- **Retention Rate**: Percentage of users remaining active over time.
- **Cohort Performance**: Behavior comparison across signup months.
- **Acquisition Quality**: Promo vs organic user retention differences.

## SQL Concepts Used
- Common Table Expressions (CTEs)
- JOIN operations
- Date parsing and transformation
- Month difference calculation (DATEDIFF-style logic)
- Aggregation (COUNT DISTINCT users)

## Project Materials
- [Google Sheets Link](https://docs.google.com/spreadsheets/d/1ZPY4mYfiYrLPrzE-YWxfziLlDHrPI9SH-gzmBSIqpnM/edit?usp=sharing)
- [Google Presentation Link](https://docs.google.com/presentation/d/1SfUWeBBZXJDSQj5VVigKqrKwilrG7u7Z5rY5gW1qVSg/edit?usp=sharing)
- SQL file: [user_retention_cohort_analysis.sql](user_retention_cohort_analysis.sql)