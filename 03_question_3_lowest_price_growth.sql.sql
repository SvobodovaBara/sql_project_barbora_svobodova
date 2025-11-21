WITH price_growth AS (
    SELECT
        category_name,
        year,
        avg_price,
        (avg_price - LAG(avg_price) OVER (PARTITION BY category_name ORDER BY year))
        / NULLIF(LAG(avg_price) OVER (PARTITION BY category_name ORDER BY year), 0) * 100 AS percent_growth
    FROM data_academy_content.t_barbora_svobodova_project_sql_primary_final
)
SELECT category_name,
       ROUND(AVG(percent_growth)::numeric, 2) AS avg_annual_percent_growth
FROM price_growth
WHERE percent_growth IS NOT NULL
GROUP BY category_name
ORDER BY avg_annual_percent_growth ASC
LIMIT 1;
