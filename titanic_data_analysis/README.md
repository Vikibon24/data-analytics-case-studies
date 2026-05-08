# Titanic Data Analysis: Exploratory Data Analysis

## Tech Stack
- Language: Python
- Libraries: Pandas, NumPy, Seaborn, Matplotlib
- Environment: Google Colab / Jupyter Notebook

## Project Objective
The goal of this project was to explore and analyze the Titanic passenger dataset. I focused on cleaning the data, creating new features, and identifying the main factors that affected passenger survival.

### Key Questions
- How should missing values be handled, especially in the age column?
- Can family relationships on board be simplified into one metric?
- Which age categories had the highest death rates?
- Does the embarkation port relate to passenger characteristics, such as family size?
- How does age and social status (class) affect survival chances?
- Is there a correlation between family size on board and mortality?
- Which demographic groups were the most vulnerable during the disaster?

## Methodology

### 1. Data Cleaning & Optimization
- Converted text fields (`sex`, `embarked`, `who`, `embark_town`) into category format to optimize memory usage.
- Changed the `alive` column from “yes/no” to Boolean values (`True`/`False`) for easier analysis.
- Handled missing values in the `age` column using median imputation.

### 2. Feature Engineering
- Consolidated `sibsp` and `parch` into a new metric: `relatives`.
- Corrected the data for passengers traveling alone by setting `relatives` to 0.
- Grouped large families into one category called “above 5” for focused statistical analysis.

### 3. Data Transformation & Analysis
- Created age groups: `child`, `young`, `adult`, and `senior` using a custom function.
- Calculated survival and death rates for each age group using grouping functions.
- Identified the age group with the highest mortality rate using `groupby()` and `idxmax()`.

## Key Findings
- Children had a better chance of survival, while older passengers had much lower survival rates.
- Social class influenced survival chances. Passengers in Third Class and those on lower decks (such as Deck G) were less likely to survive.
- Large families (7–10 people) had a 100% death rate, suggesting that traveling in large groups made evacuation more difficult.

### Additional findings
- The highest mortality rate was in the Senior age group (75.00%).
- Passengers in Third Class had a high mortality rate of 75.76%.
- Large families were the most affected, with 100% mortality for groups of 7 or 10 relatives.
- Among cabin locations, Deck G was the most dangerous, with a 50.00% mortality rate.

## Project Materials
- Full Python script with detailed comments: [titanic_analysis.ipynb](titanic_analysis.ipynb)
