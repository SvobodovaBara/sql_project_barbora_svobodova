WITH milk_bread AS (
    SELECT
        year,
        category_name AS food_name,
        avg_price
    FROM data_academy_content.t_barbora_svobodova_project_sql_primary_final
    WHERE category_name ILIKE '%mléko%' OR category_name ILIKE '%chléb%'
),
avg_wage AS (
    SELECT year, avg_wage
    FROM data_academy_content.t_barbora_svobodova_project_sql_primary_final
    GROUP BY year, avg_wage
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
JOIN first_last_years f ON m.year = f.first_year OR m.year = f.last_year
ORDER BY m.year, m.food_name;
