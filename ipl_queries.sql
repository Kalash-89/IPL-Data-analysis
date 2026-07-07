-- ============================================
-- IPL DATA ANALYSIS — SQL QUERIES (BigQuery)
-- Note: Replace 'matches' and 'deliveries' below
-- with your actual dataset.table names from
-- BigQuery, e.g. `ipl-analysis-501407.your_dataset.matches`
-- ============================================

-- Step 0: Cleaned view unifying historical team name inconsistencies
CREATE OR REPLACE VIEW matches_clean AS
SELECT
  *,
  CASE
    WHEN team1 = 'Delhi Daredevils' THEN 'Delhi Capitals'
    WHEN team2 = 'Delhi Daredevils' THEN 'Delhi Capitals'
    WHEN team1 = 'Kings XI Punjab' THEN 'Punjab Kings'
    WHEN team2 = 'Kings XI Punjab' THEN 'Punjab Kings'
    ELSE team1
  END AS team1_clean
FROM matches;

-- Query 1: Team win percentage
SELECT
  winner,
  COUNT(*) AS total_wins,
  ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM matches_clean), 2) AS win_percentage
FROM matches_clean
GROUP BY winner
ORDER BY total_wins DESC;

-- Query 2: Toss impact on match result (does winning toss = winning match?)
SELECT
  COUNT(*) AS total_matches,
  SUM(CASE WHEN toss_winner = winner THEN 1 ELSE 0 END) AS toss_winner_won_match,
  ROUND(SUM(CASE WHEN toss_winner = winner THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS toss_win_match_win_pct
FROM matches_clean;

-- Query 3: Toss decision impact (bat first vs field first)
SELECT
  toss_decision,
  COUNT(*) AS total_matches,
  SUM(CASE WHEN toss_winner = winner THEN 1 ELSE 0 END) AS wins,
  ROUND(SUM(CASE WHEN toss_winner = winner THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS win_pct
FROM matches_clean
GROUP BY toss_decision;

-- Query 4: Death-overs (16-20) strike rate by batsman
SELECT
  batsman,
  SUM(batsman_runs) AS total_runs,
  COUNT(*) AS balls_faced,
  ROUND(SUM(batsman_runs) * 100.0 / COUNT(*), 2) AS strike_rate
FROM deliveries
WHERE over >= 16
GROUP BY batsman
ORDER BY strike_rate DESC
LIMIT 10;

-- Query 5: Venue-wise chase-win percentage
SELECT
  venue,
  COUNT(*) AS total_matches,
  SUM(CASE WHEN win_by_wickets > 0 THEN 1 ELSE 0 END) AS chases_won,
  ROUND(SUM(CASE WHEN win_by_wickets > 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS chase_win_pct
FROM matches_clean
GROUP BY venue
ORDER BY chase_win_pct DESC;