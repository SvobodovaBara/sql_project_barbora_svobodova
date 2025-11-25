WITH growth AS (
    SELECT
        year,
        avg_price,
        avg_wage,
        LAG(avg_price) OVER (ORDER BY year) AS prev_price,
        LAG(avg_wage) OVER (ORDER BY year) AS prev_wage
    FROM (
        SELECT
            year,
            AVG(avg_price)::numeric AS avg_price,
            AVG(avg_wage)::numeric AS avg_wage
        FROM data_academy_content.t_barbora_svobodova_project_sql_primary_final
        GROUP BY year
    ) AS annual
)
SELECT
    year,
    ROUND(((avg_price - prev_price)/NULLIF(prev_price,0)*100)::numeric,2) AS price_growth,
    ROUND(((avg_wage - prev_wage)/NULLIF(prev_wage,0)*100)::numeric,2) AS wage_growth,
    ROUND((((avg_price - prev_price)/NULLIF(prev_price,0)*100) -
           ((avg_wage - prev_wage)/NULLIF(prev_wage,0)*100))::numeric,2) AS diff_growth
FROM growth
ORDER BY year;
