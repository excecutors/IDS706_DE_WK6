-- List user tables (lists every user-created table in the database)
SELECT name
FROM sqlite_master
WHERE type='table' AND name NOT LIKE 'sqlite_%'
ORDER BY name;

-- Schema for university_rankings (structure of the table: column names, data types, etc)
PRAGMA table_info(university_rankings);

-- Peek a few rows
SELECT * FROM university_rankings LIMIT 5;

-- Basic row counts per year (handy for README)
SELECT year, COUNT(*) AS n_rows
FROM university_rankings
GROUP BY year
ORDER BY year;

-- Top 5 universities overall (highest scores)
SELECT institution, country, year, score
FROM university_rankings
ORDER BY score DESC
LIMIT 5;