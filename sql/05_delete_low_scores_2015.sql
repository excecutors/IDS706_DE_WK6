BEGIN TRANSACTION;

-- How many will be removed (put this number in README)
SELECT COUNT(*) AS to_delete
FROM university_rankings
WHERE year=2015 AND score < 45;

DELETE FROM university_rankings
WHERE year=2015 AND score < 45;

-- Verify none remain
SELECT COUNT(*) AS remaining_below_45_2015
FROM university_rankings
WHERE year=2015 AND score < 45;

COMMIT;