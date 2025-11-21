WITH yearly_growth AS (
    SELECT
        year,
        ROUND(
            ((avg_price - LAG(avg_price) OVER (ORDER BY year))
             / NULLIF(LAG(avg_price) OVER (ORDER BY year),0) * 100)::numeric, 2
        ) AS price_growth,
        ROUND(
            ((avg_wage - LAG(avg_wage) OVER (ORDER BY year))
             / NULLIF(LAG(avg_wage) OVER (ORDER BY year),0) * 100)::numeric, 2
        ) AS wage_growth,
        ROUND(
            (((avg_price - LAG(avg_price) OVER (ORDER BY year))
             / NULLIF(LAG(avg_price) OVER (ORDER BY year),0) * 100) -
            ((avg_wage - LAG(avg_wage) OVER (ORDER BY year))
             / NULLIF(LAG(avg_wage) OVER (ORDER BY year),0) * 100))::numeric, 2
        ) AS diff_growth
    FROM data_academy_content.t_barbora_svobodova_project_sql_primary_final
)
SELECT year, price_growth, wage_growth, diff_growth
FROM yearly_growth
WHERE diff_growth > 10
ORDER BY year;
