-- Data Cleaning and Corrections

-- Set the datestyle to 'MDY' for month/day/year format
SET datestyle = 'MDY';

-- Change the data type of "birthdate" column
ALTER TABLE "HR"
ALTER COLUMN birthdate TYPE DATE USING birthdate::DATE;

-- Update "birthdate" values based on different date formats
UPDATE "HR"
SET birthdate = CASE
    WHEN CAST(birthdate AS TEXT) ~ E'^\\d{2}/\\d{2}/\\d{4}$' THEN CAST(birthdate AS DATE)
    WHEN CAST(birthdate AS TEXT) ~ E'^\\d{2}-\\d{2}-\\d{4}$' THEN CAST(birthdate AS DATE)
    ELSE NULL
END
WHERE CAST(birthdate AS TEXT) ~ E'^\\d{2}/\\d{2}/\\d{4}$' OR CAST(birthdate AS TEXT) ~ E'^\\d{2}-\\d{2}-\\d{4}$';

-- Set a specific date format for "birthdate"
UPDATE "HR"
SET birthdate = '1984-06-29'
WHERE birthdate IS NOT NULL;

-- Change the data type of "birthdate" column (again)
ALTER TABLE "HR"
ALTER COLUMN birthdate SET DATA TYPE DATE;

-- Update "hire_date" values based on different date formats
UPDATE "HR"
SET hire_date = CASE
    WHEN CAST(hire_date AS TEXT) LIKE '%/%' THEN CAST(hire_date AS DATE)
    WHEN CAST(hire_date AS TEXT) LIKE '%-%' THEN CAST(hire_date AS DATE)
    ELSE NULL
END
WHERE hire_date IS NOT NULL;

-- Change the data type of "hire_date" column with explicit USING clause
ALTER TABLE "HR"
ALTER COLUMN hire_date TYPE DATE USING hire_date::DATE;

-- Update "termdate" values to a proper date format
UPDATE "HR"
SET termdate = NULL
WHERE termdate = '0000-00-00';

-- Change the data type of "termdate" column with explicit USING clause
ALTER TABLE "HR"
ALTER COLUMN termdate TYPE DATE USING termdate::DATE;

-- Add an "age" column and calculate ages
ALTER TABLE "HR" ADD COLUMN age INT;

UPDATE "HR"
SET age = DATE_PART('year', age(birthdate));

-- Calculate the youngest and oldest ages
SELECT
    MIN(age) AS youngest,
    MAX(age) AS oldest
FROM "HR";

-- Count employees younger than 18
SELECT COUNT(*)
FROM "HR"
WHERE age < 18;

-- Count employees with a term date in the future
SELECT COUNT(*)
FROM "HR"
WHERE termdate > CURRENT_DATE;

-- Select the "location" column
SELECT location
FROM "HR";
