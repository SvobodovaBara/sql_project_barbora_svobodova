WITH growth AS (
    SELECT
        p.year,
        s.gdp,
        ROUND(((s.gdp - LAG(s.gdp) OVER (ORDER BY p.year)) / NULLIF(LAG(s.gdp) OVER (ORDER BY p.year),0) * 100)::numeric, 2) AS gdp_growth,
        ROUND(((p.avg_wage - LAG(p.avg_wage) OVER (ORDER BY p.year)) / NULLIF(LAG(p.avg_wage) OVER (ORDER BY p.year),0) * 100)::numeric, 2) AS wage_growth,
        ROUND(((p.avg_price - LAG(p.avg_price) OVER (ORDER BY p.year)) / NULLIF(LAG(p.avg_price) OVER (ORDER BY p.year),0) * 100)::numeric, 2) AS price_growth
    FROM data_academy_content.t_barbora_svobodova_project_sql_primary_final p
    JOIN data_academy_content.t_barbora_svobodova_project_sql_secondary_final s
      ON p.year = s.year
)
SELECT *
FROM growth
ORDER BY year;

