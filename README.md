# SQLite CRUD Assignment

## Database Overview

* **Database file:** `university_database.db`
* **Primary table:** `university_rankings`
* **Connection method:** Connected successfully via VS Code SQLite extension.
* **Objective:** Perform basic data exploration and CRUD operations on the pre-built university rankings dataset (2012–2015).

---

## 01 — Basic Analysis (`01_inspect.sql`)

```sql
-- List user tables
SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%' ORDER BY name;

-- Schema
PRAGMA table_info(university_rankings);

-- Preview data
SELECT * FROM university_rankings LIMIT 5;

-- Row counts per year
SELECT year, COUNT(*) AS n_rows FROM university_rankings GROUP BY year ORDER BY year;

-- Top 5 universities overall (highest scores)
SELECT institution, country, year, score FROM university_rankings ORDER BY score DESC LIMIT 5;
```

### Findings

| Year | Row Count |
| ---- | --------- |
| 2012 | 100       |
| 2013 | 100       |
| 2014 | 1001      |
| 2015 | 1000      |

**Observations:**

* Verified single user-created table: `university_rankings`.
* Dataset spans **2012–2015** with consistent structure.
* Schema includes 14 columns covering ranking metrics, institutional details, and scores.
* Harvard and Stanford dominated the #1 spot from 2012 to 2015

---

## 02 — Insert a New University (2014) (`02_insert_duke_2014.sql`)

```sql
BEGIN TRANSACTION;

INSERT INTO university_rankings (
  world_rank, institution, country, national_rank,
  quality_of_education, alumni_employment, quality_of_faculty,
  publications, influence, citations, broad_impact, patents,
  score, year
) VALUES (
  350, 'Duke Tech', 'USA', NULL,
  NULL, NULL, NULL,
  NULL, NULL, NULL, NULL, NULL,
  60.5, 2014
);

-- Verify
SELECT * FROM university_rankings WHERE institution='Duke Tech' AND year=2014;

COMMIT;
```

**Result:** Successfully inserted 1 new row for **Duke Tech (USA, 2014)** with `world_rank=350` and `score=60.5`.

---

## 03 — Count Japanese Universities in Top 200 (2013) (`03_count_japan_top200_2013.sql`)

```sql
SELECT COUNT(*) AS japan_top200_2013
FROM university_rankings
WHERE country='Japan'
  AND year=2013
  AND world_rank <= 200;
```

**Result:** `6` universities from Japan ranked in the global top 200 in 2013.

---

## 04 — Update University of Oxford’s 2014 Score (`04_update_oxford_2014.sql`)

```sql
BEGIN TRANSACTION;

-- Before (capture for README)
SELECT institution, year, score FROM university_rankings WHERE year=2014 AND institution='University of Oxford';

-- Apply update
UPDATE university_rankings
SET score = score + 1.2
WHERE year=2014 AND institution='University of Oxford';

-- After (verify)
SELECT institution, year, score FROM university_rankings WHERE year=2014 AND institution='University of Oxford';

COMMIT;
```

| Institution          | Year | Score Before | Score After |
| -------------------- | ---- | ------------ | ----------- |
| University of Oxford | 2014 | 97.51        | 98.71       |

**Result:** Successfully increased Oxford’s score by +1.2 points for 2014.

---

## 05 — Delete Low Scores (2015 < 45) (`05_delete_low_scores_2015.sql`)

```sql
BEGIN TRANSACTION;

-- How many will be removed (put this number in README)
SELECT COUNT(*) AS to_delete FROM university_rankings WHERE year=2015 AND score < 45;

DELETE FROM university_rankings WHERE year=2015 AND score < 45;

-- Verify none remain
SELECT COUNT(*) AS remaining_below_45_2015 FROM university_rankings WHERE year=2015 AND score < 45;

COMMIT;
```

| Metric                    | Count |
| ------------------------- | ----- |
| Rows deleted              | 556   |
| Remaining with score < 45 | 0     |

**Result:** Cleaned dataset by removing all 2015 entries with scores below 45. Verified deletion successfully.

---

## Summary of Results

| Operation  | Action                       | Verification               | Outcome   |
| ---------- | ---------------------------- | -------------------------- | --------- |
| **Insert** | Added Duke Tech (2014)       | Verified row in DB         | ✅ Success |
| **Count**  | Counted Japan top 200 (2013) | Returned 6                 | ✅ Success |
| **Update** | Increased Oxford 2014 score  | 97.51 → 98.71              | ✅ Success |
| **Delete** | Removed 2015 rows < 45       | 556 rows deleted, 0 remain | ✅ Success |

---

## File Summary

| File                             | Description                                         |
| -------------------------------- | --------------------------------------------------- |
| `01_inspect.sql`                 | Explore schema, preview data, and summarize by year |
| `02_insert_duke_2014.sql`        | Insert new university record for Duke Tech (2014)   |
| `03_count_japan_top200_2013.sql` | Count Japanese universities in top 200 for 2013     |
| `04_update_oxford_2014.sql`      | Correct Oxford’s score (+1.2) for 2014              |
| `05_delete_low_scores_2015.sql`  | Remove all 2015 records with score < 45             |

---

**All CRUD operations executed successfully, verified via SELECT checks, and documented in this report.**