# E-commerce Product Analysis – User Activity & Stickiness

## Tools Used
- Google Sheets with functions like FILTER, UNIQUE, SORT, VLOOKUP, XLOOKUP, and ARRAYFORMULA.
- Line charts to show trends in user activity.

## Project Overview
In this project, I worked as a Product Analyst for an e-commerce platform. I analyzed user purchase activity after a new feature was launched.

The goal was to understand how often users come back and how engaged they are. I also wanted to see if the product creates a habit for users.

## Key Questions
- How does user activity change daily (DAU), weekly (WAU), and monthly (MAU)?
- Is the number of users growing or decreasing over time?
- How often do users return to the product (stickiness)?

## Key Findings
- Monthly activity was highest in March and lowest in July.
- Daily activity (DAU) is stable, which means users come back regularly.
- Weekly activity (WAU) shows a small decline over time.
- The DAU/MAU ratio is about 3%, which means users do not use the product every day.
- The WAU/MAU ratio is stable, which shows that some users return every week.

## Steps & Logic
1. **Data Cleaning & Preparation**
    - Used FILTER to select only “purchase” events.
    - Converted timestamps into readable dates.
    - Grouped data by day, week, and month to prepare for analysis.

2. **Metric Calculation**
    - Calculated:
      - DAU (daily active users)
      - WAU (weekly active users)
      - MAU (monthly active users)
    - Used COUNTUNIQUEIFS to count unique users.
    - Used VLOOKUP and XLOOKUP to match dates with the correct month or week.
    - Calculated:
      - DAU/MAU → shows daily engagement
      - WAU/MAU → shows weekly engagement

3. **Visualization**
    - Created line charts for DAU, WAU, and MAU.
    - Added trendlines to better see long-term changes.
    - Also created a “stickiness” chart to show how user engagement changes over time.

## Simple Explanation
This project shows how often users come back to the product.  
It helps understand if users are building a habit or not.  
Right now, users return weekly, but not every day, so there is room to improve engagement.

## Project Materials
- [Google Sheets Link](https://docs.google.com/spreadsheets/d/1bncV-gOiedxtW7vVqoEpIzSGSD0kEtLwGnXf4F36kkE/edit?pli=1&gid=1069468832#gid=1069468832)