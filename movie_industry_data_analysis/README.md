# Movie Industry Data Analysis
## Tech Stack
Programming Language: Python (Pandas, NumPy)
Data Visualization: Seaborn, Matplotlib
Data Processing: JSON files and multi-file data handling
### Project Objective
The main goal of this project was to collect, clean, and organize movie data from a large number of separate files.
The project focuses on transforming raw and unstructured data into one structured dataset for analysis of movie trends, genres, and actor patterns.
## Key Questions
How can multiple movie files be automatically merged into one clean DataFrame?
Which movie genres were most popular in different decades, and how did genres change over time?
Which actors appear most frequently in the dataset?
How often do actors appear in the most popular movie genres compared to less popular or niche genres?
## Methodology 
### 1. Data Collection
- Created a Python script to read and combine many files into one main DataFrame called `movies_df`.
### 2. Handling Complex Data
- Used the .explode() function in Pandas to separate lists inside the Cast and Genres columns, allowing individual analysis of actors and genres.
### 3. Data Cleaning
- Identified the 3 most common movie genres in the dataset.
- Compared actor appearances in mainstream genres versus niche genres.
- Organized and standardized the dataset to make analysis easier and more reliable.
### 4. Time-Series Analysis
Grouped movies by release year to analyze how the movie industry changed and grew over different decades.

## Key Findings
- Used Python libraries to automatically read and combine many JSON movie files. Created one structured master DataFrame. This process improved data organization and made large-scale analysis possible.
- Found that older decades were dominated by genres such as Drama, Comedy and Silent.
- Identified a group of highly recurring actors who appeared in significantly more films than the average actor.
- Popular actors can be divided into three groups based on the genres they work in: some mainly appear in popular films aimed at wide audiences, while others focus on niche genres where they dominate specific categories. A third group successfully works in both popular and niche genres and often has the highest overall number of films.
## Project Materials
- Full Python script with detailed comments: [movie_industry_data_analysis.ipynb](movie_industry_data_analysis.ipynb)



