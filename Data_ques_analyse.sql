-- Gender breakdown of employees in the company (aged 18 and above)
SELECT gender, COUNT(*) AS count
FROM "HR"
WHERE age >= 18
GROUP BY gender;

-- Race/ethnicity breakdown of employees in the company (aged 18 and above), sorted by count in descending order
SELECT race, COUNT(*) AS count
FROM "HR"
WHERE age >= 18
GROUP BY race
ORDER BY count DESC;

-- Age distribution of employees in the company (aged 18 and above)
SELECT MIN(age) AS youngest, MAX(age) AS oldest
FROM "HR"
WHERE age >= 18;

SELECT FLOOR(age/10)*10 AS age_group, COUNT(*) AS count
FROM "HR"
WHERE age >= 18
GROUP BY FLOOR(age/10)*10;

-- Number of employees working at headquarters vs. remote locations (aged 18 and above)
SELECT location, COUNT(*) as count
FROM "HR"
WHERE age >= 18
GROUP BY location;

-- Average length of employment for terminated employees (aged 18 and above)
SELECT ROUND(AVG(EXTRACT(YEAR FROM AGE(termdate, hire_date))), 0) AS avg_length_of_employment
FROM "HR"
WHERE termdate <= CURRENT_DATE AND termdate IS NOT NULL AND age >= 18;

-- Gender distribution across departments and job titles (aged 18 and above)
SELECT department, gender, jobtitle, COUNT(*) as count
FROM "HR"
WHERE age >= 18
GROUP BY department, gender, jobtitle
ORDER BY department, gender, jobtitle;

-- Distribution of job titles across the company (aged 18 and above)
SELECT jobtitle, COUNT(*) as count
FROM "HR"
WHERE age >= 18
GROUP BY jobtitle
ORDER BY jobtitle DESC;

-- Department with the highest turnover rate (aged 18 and above)
SELECT department, (COUNT(*)::FLOAT / (SELECT COUNT(*) FROM "HR" WHERE age >= 18)) AS turnover_rate
FROM "HR"
WHERE termdate <= CURRENT_DATE AND termdate IS NOT NULL AND age >= 18
GROUP BY department
ORDER BY turnover_rate DESC
LIMIT 1;

-- Distribution of employees across locations by state (aged 18 and above), sorted by count in descending order
SELECT location_state, COUNT(*) as count
FROM "HR"
WHERE age >= 18 AND termdate IS NOT NULL
GROUP BY location_state
ORDER BY count DESC;

-- Employee count changes over time based on hire and term dates (aged 18 and above)
SELECT EXTRACT(YEAR FROM hire_date) AS hire_year, EXTRACT(YEAR FROM termdate) AS term_year, COUNT(*) AS employee_count
FROM "HR"
WHERE age >= 18 AND (hire_date IS NOT NULL OR termdate IS NOT NULL)
GROUP BY hire_year, term_year
ORDER BY hire_year, term_year;

-- Tenure distribution for each department (aged 18 and above)
SELECT department, ROUND(AVG(EXTRACT(YEAR FROM AGE(CURRENT_DATE, termdate))), 0) as avg_tenure
FROM "HR"
WHERE termdate <= CURRENT_DATE AND termdate IS NOT NULL AND age >= 18
GROUP BY department;
