WITH prices_per_year AS (
    SELECT
        EXTRACT(YEAR FROM cp.date_from)::INT AS year,
        pc.name AS category_name,
        AVG(cp.value) AS avg_price
    FROM czechia_price cp
    LEFT JOIN czechia_price_category pc
        ON cp.category_code = pc.code
    WHERE cp.value IS NOT NULL
    GROUP BY EXTRACT(YEAR FROM cp.date_from)::INT, pc.name
),
price_growth AS (
    SELECT
        category_name,
        year,
        avg_price,
        (avg_price - LAG(avg_price) OVER (PARTITION BY category_name ORDER BY year))
        / LAG(avg_price) OVER (PARTITION BY category_name ORDER BY year) * 100 AS percent_growth
    FROM prices_per_year
)
SELECT category_name,
       ROUND(AVG(percent_growth)::numeric, 2) AS avg_annual_percent_growth
FROM price_growth
WHERE percent_growth IS NOT NULL
GROUP BY category_name
ORDER BY avg_annual_percent_growth ASC
LIMIT 1;
