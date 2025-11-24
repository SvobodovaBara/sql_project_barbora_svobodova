WITH annual AS (
    -- agregace dat na úroveň roku
    SELECT
        year,
        AVG(avg_price)::numeric AS avg_price,
        AVG(avg_wage)::numeric AS avg_wage
    FROM data_academy_content.t_barbora_svobodova_project_sql_primary_final
    GROUP BY year
),
lagged AS (
    -- přidání předchozího roku
    SELECT
        year,
        avg_price,
        avg_wage,
        LAG(avg_price) OVER (ORDER BY year) AS prev_price,
        LAG(avg_wage) OVER (ORDER BY year) AS prev_wage
    FROM annual
),
yearly_growth AS (
    -- výpočet meziročního růstu a rozdílu mezi cenami a mzdami
    SELECT
        year,
        ROUND(((avg_price - prev_price) / NULLIF(prev_price, 0) * 100)::numeric, 2) AS price_growth,
        ROUND(((avg_wage - prev_wage) / NULLIF(prev_wage, 0) * 100)::numeric, 2) AS wage_growth,
        ROUND((((avg_price - prev_price) / NULLIF(prev_price, 0) * 100) -
               ((avg_wage - prev_wage) / NULLIF(prev_wage, 0) * 100))::numeric, 2) AS diff_growth
    FROM lagged
)
SELECT *
FROM yearly_growth
WHERE diff_growth > 10
ORDER BY year;
