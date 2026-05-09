# Facebook Ads Performance Analysis

## Tech Stack
- **Language**: Python
- **Libraries**: Pandas, NumPy
- **Visualization**: Matplotlib, Seaborn

## Project Objective
The goal of this project was to analyze the performance of Facebook advertising campaigns using data visualization. I worked with advertising data from CSV files to identify spending trends, evaluate campaign profitability (ROMI), and understand the relationship between important marketing metrics.

## Key Questions
- How did advertising spend and ROMI change during 2021?
- How can a 10-day rolling average help show long-term trends?
- Which campaigns had the highest investment and which produced the best ROMI?
- What is the relationship between advertising spend and the total value generated?

## Methodology

### 1. Time-Series Analysis
Converted raw date strings into datetime format for analysis. 
Used a 10-day moving average (`rolling(window=10)`) to smooth daily changes and better see long-term trends in spend and ROMI.

### 2. Campaign Comparison
Created bar charts to compare campaigns by total spend and ROMI.
Used box plots to analyze the stability of campaign performance and identify outliers.

### 3. Correlation & Regression Analysis
A correlation matrix was created and visualized with `sns.heatmap(corr_matrix, annot=True)` to identify relationships between numerical variables.
`sns.lmplot` was used to analyze the relationship between advertising spend and revenue in the dataset.

## Key Findings
- Advertising spending stayed low and stable from January to May, then increased rapidly and reached its peak in August 2021. After August, spending gradually decreased and stabilized, while ROMI showed similar fluctuations during high-spending periods.

- A 10-day rolling average helps show whether campaign performance is slowly improving or declining over time, which is useful for long-term planning and decision-making.

- According to the "Total Advertising Spend" bar chart, the "Expansion" campaign had the highest investment (nearly 70,000 USD), followed by "Lookalike". Looking at the "Total ROMI" bar chart, the order changes completely. The most efficient campaigns at turning spend into revenue were "Trendy" and "Promos".

- The heatmap shows a perfect positive correlation (1.0) between `total_spend` and `total_value`, meaning more spending directly leads to more revenue. It also shows a strong relationship (0.8) between `total_impressions` and `total_clicks`.

- The lmplot visualization showed a strong positive relationship between `total_spend` and `total_value`, meaning that higher advertising spending consistently generated higher revenue.

## Project Materials
- Full Python script with detailed comments: [facebook_ads_analysis.ipynb](facebook_ads_analysis.ipynb)
