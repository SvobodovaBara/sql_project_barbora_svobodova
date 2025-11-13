WITH milk_bread AS (
    SELECT
        EXTRACT(YEAR FROM cp.date_from)::INT AS year,
        pc.name AS food_name,
        AVG(cp.value) AS avg_price
    FROM czechia_price cp
    JOIN czechia_price_category pc 
        ON cp.category_code = pc.code
    WHERE cp.value IS NOT NULL
      AND (pc.name ILIKE '%mléko%' OR pc.name ILIKE '%chléb%')
    GROUP BY EXTRACT(YEAR FROM cp.date_from)::INT, pc.name
),
avg_wage AS (
    SELECT payroll_year AS year, AVG(value) AS avg_wage
    FROM czechia_payroll
    WHERE value IS NOT NULL
      AND value_type_code = 5958   -- průměrná mzda
      AND unit_code = 200           -- Kč
    GROUP BY payroll_year
),
first_last_years AS (
    SELECT MIN(year) AS first_year, MAX(year) AS last_year
    FROM milk_bread
)
SELECT
    m.year,
    m.food_name,
    ROUND((a.avg_wage / m.avg_price)::numeric, 2) AS purchasable_units
FROM milk_bread m
JOIN avg_wage a ON m.year = a.year
JOIN first_last_years f 
    ON m.year = f.first_year OR m.year = f.last_year
ORDER BY m.year, m.food_name;
