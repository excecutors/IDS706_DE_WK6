BEGIN TRANSACTION;

-- Before (capture for README)
SELECT institution, year, score
FROM university_rankings
WHERE year=2014 AND institution='University of Oxford';

-- Apply update
UPDATE university_rankings
SET score = score + 1.2
WHERE year=2014 AND institution='University of Oxford';

-- After (verify)
SELECT institution, year, score
FROM university_rankings
WHERE year=2014 AND institution='University of Oxford';

COMMIT;