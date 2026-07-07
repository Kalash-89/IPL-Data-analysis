# IPL Data Analysis — SQL & Tableau Dashboard

## Overview
Analysed 1,095 IPL matches and 260K+ ball-by-ball delivery records using SQL (Google BigQuery) 
for data querying and Tableau for interactive visualization. Dataset sourced from Kaggle's 
IPL Complete Dataset.

## Tools Used
- **Google BigQuery** — SQL querying on cleaned dataset
- **Tableau Public** — Interactive dashboard visualization
- **SQL** — Data cleaning, aggregation, and analysis

## Key Findings
- Toss outcome has **negligible impact** on match results — toss-winning teams won only 50.6% of matches
- **Fielding-first** decisions showed a higher win rate (53.6%) compared to batting first
- Analysed venue-wise chase-win percentages to identify grounds favoring second-innings batting
- Built a cleaned SQL view (`matches_clean`) to unify historical team name inconsistencies 
  (e.g., Delhi Daredevils → Delhi Capitals)

## Dashboard Preview

### Toss Decision Impact
![Toss Decision Impact](toss_decision_impact.png)

### Wins by Team
![Wins by Team](wins_by_team.png)

### Venue Chase Analysis
![Venue Chase Analysis](venue_chase_analysis.png)

## Files in this Repository
- `ipl_data_analysis.twbx` — Tableau Packaged Workbook (full interactive dashboard)
- `ipl_queries.sql` — SQL queries used for analysis (BigQuery)
- `*.png` — Dashboard screenshots

## Dataset
Source: [IPL Complete Dataset, Kaggle](https://www.kaggle.com/datasets)
