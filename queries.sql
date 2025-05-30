-- 1. Average insurance charges
SELECT AVG(charges) AS avg_charges
FROM charges;

-- 2. Insured people by region
SELECT region,
       COUNT(*) AS total_insured
FROM charges
GROUP BY region;

-- 3. Charges by age group
SELECT
  CASE
    WHEN CAST(age AS INTEGER) BETWEEN 18 AND 30 THEN '18-30'
    WHEN CAST(age AS INTEGER) BETWEEN 31 AND 45 THEN '31-45'
    WHEN CAST(age AS INTEGER) BETWEEN 46 AND 60 THEN '46-60'
    ELSE '60+'
  END AS age_group,
  COUNT(*) AS patient_count,
  ROUND(AVG(CAST(charges AS FLOAT)), 2) AS avg_charges
FROM charges
GROUP BY age_group
ORDER BY age_group;

-- 4. Top 5 Highest Medical Charges with details
SELECT age, sex, smoker, bmi, children, region, CAST(charges AS FLOAT) AS charges
FROM charges
ORDER BY charges DESC
LIMIT 5;

-- 5a. Average charges by age group (alternative grouping)
SELECT
  CASE
    WHEN CAST(age AS INTEGER) >= 60 THEN '60+'
    WHEN CAST(age AS INTEGER) BETWEEN 40 AND 59 THEN '40-59'
    WHEN CAST(age AS INTEGER) BETWEEN 20 AND 39 THEN '20-39'
    ELSE 'Under 20'
  END AS age_group,
  ROUND(AVG(CAST(charges AS FLOAT)), 2) AS avg_charges,
  COUNT(*) AS patient_count
FROM charges
GROUP BY age_group
ORDER BY age_group;

-- 5b. Smoker status for age 60+
SELECT smoker,
       ROUND(AVG(CAST(charges AS FLOAT)), 2) AS avg_charges,
       COUNT(*) AS patient_count
FROM charges
WHERE CAST(age AS INTEGER) >= 60
GROUP BY smoker;
