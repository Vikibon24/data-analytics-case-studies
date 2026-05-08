# Mobile Game Data Analysis – User Behavior & Outliers

## Tools Used
- Google Sheets with statistical functions like AVERAGE, MEDIAN, QUARTILE, STDEV, COUNTIF, and IF
- Visualization: histograms and boxplot (using a candlestick chart)

## Project Overview
In this project, I worked as a Data Analyst for a mobile game company. I analyzed data from 500 users to understand typical player behavior.

The main goal was to find unusual users (called "outliers" or "whales") and see how they affect important metrics like average revenue.

## Key Questions
- What is normal user behavior (sessions, payments, game time)?
- Are there users who behave very differently from others?
- How do extreme users affect average values?

## Key Findings
- The average payment ($10.06) is much higher than the median ($6.71). This means a small number of users spend a lot (right-skewed data).
- 23 high-cost exceptions were identified. Using only the average would give a wrong picture of typical users.
- Most users have about 4 sessions.
- Most payments are between $0 and $3.64.
- Payments vary a lot (high standard deviation), while sessions and game time are more stable.

## Steps & Logic

### 1. Descriptive Statistics
I calculated basic statistics for sessions, payments, and game time:
- Mean, Median, Mode
- Minimum and Maximum values
- Standard deviation
- Quartiles (Q1, Q2, Q3)

### 2. Outlier Detection (IQR Method)
To find unusual values, I used the Interquartile Range (IQR):
- IQR = Q3 − Q1
- Upper Bound = Q3 + 1.5 * IQR
- Lower Bound = Q1 − 1.5 * IQR

Created a simple rule using IF statements to label each user as:
- "low outlier"
- "high outlier"
- "normal"

### 3. Data Visualization
- Histogram: shows how payments are distributed (right skew)
- Boxplot: clearly shows the spread of data and identifies outliers

## Project Materials
- [Google Sheets](https://docs.google.com/spreadsheets/d/1m9h993GmnsJGBL1KiBTtUWDWon8Qny0Z5tC5QuDSUdE/edit?gid=628620766#gid=628620766)
