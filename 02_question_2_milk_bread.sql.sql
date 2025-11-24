WITH raw_prices AS (
    SELECT
        year,
        category_name,
        avg_price
    FROM data_academy_content.t_barbora_svobodova_project_sql_primary_final
    WHERE category_name ILIKE '%mléko%' OR category_name ILIKE '%chléb%'
),
prices AS (
    SELECT
        year,
        CASE
            WHEN category_name ILIKE '%mléko%' THEN 'mléko'
            WHEN category_name ILIKE '%chléb%' THEN 'chléb'
        END AS food_name,
        AVG(avg_price)::numeric AS avg_price_year,
        COUNT(*) AS n_price_records
    FROM raw_prices
    GROUP BY year, food_name
),
wages AS (
    SELECT
        year,
        AVG(avg_wage)::numeric AS avg_wage_year
    FROM data_academy_content.t_barbora_svobodova_project_sql_primary_final
    WHERE avg_wage IS NOT NULL
    GROUP BY year
),
years AS (
    SELECT MIN(year) AS first_year, MAX(year) AS last_year
    FROM prices
)
SELECT
    p.year,
    p.food_name,
    ROUND(p.avg_price_year, 2) AS avg_price,
    p.n_price_records,
    ROUND(p.avg_price_year, 2) AS avg_price,
    ROUND(w.avg_wage_year, 2) AS avg_wage,
    ROUND((w.avg_wage_year / NULLIF(p.avg_price_year, 0))::numeric, 2) AS purchasable_units
FROM prices p
JOIN wages w USING (year)
CROSS JOIN years y
WHERE p.year IN (y.first_year, y.last_year)
ORDER BY p.year, p.food_name;
