# Stack Overflow Developer Survey Analysis

## Tech Stack
- **Language:** Python
- **Libraries:** Pandas, Numpy
- **Notebook:** Google Colab

## Project Overview
The goal of this project was to analyze the Stack Overflow Developer Survey dataset using Python and Pandas.
The analysis focused on understanding developers’ experience, work habits, programming language usage, education methods, and salary differences across countries.

## Key Questions
- How many respondents participated in the survey?
- How many people completed all questions?
- What is the average experience of developers?
- How many developers work remotely?
- How popular is Python among developers?
- How many people learned programming through online courses?
- How does salary differ across countries for Python developers?
- What is the education level of the highest-paid developers?

## Methodology
1. Dataset loading & exploration — load the Stack Overflow survey dataset using Pandas and explored its structure, including missing values and column types.
2. Data completeness check — use the survey schema to identify valid question columns and filter fields.
3. Experience analysis — calculate basic statistics: mean, median, and mode for developer experience (`WorkExp`).
4. Remote work analysis — filter responses reporting remote work and count them.
5. Python usage analysis — identified developers using Python from the programming language column and calculated their percentage in the dataset.
6. Learning methods analysis — filter respondents who learned programming through online courses.
7. Compensation analysis — for Python users, group by country and compute average and median `ConvertedCompYearly`.
8. Top earners analysis — inspect education level and other attributes of highest-paid respondents.

## Key Findings
- The dataset contains a large, global sample of developers across experience levels.
- Python is one of the most commonly used programming languages.
- Remote work is widely adopted in the developer community.
- Compensation levels vary significantly between countries.
- Online learning plays an important role in developer education.

## Skills Used
- Data cleaning
- Filtering data
- Grouping and aggregation
- Handling missing values
- Basic statistics

## Conclusion
This project demonstrates practical data analysis skills using Pandas, including data filtering, grouping, aggregation, and working with real-world survey data to extract meaningful insights.
This project helped me practice real data analysis using Pandas and understand how to work with large datasets and extract useful insights.

