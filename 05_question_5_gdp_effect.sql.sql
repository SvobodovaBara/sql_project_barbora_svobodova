WITH annual AS (
    -- agregace dat na úroveň roku (mzdy + ceny)
    SELECT
        year,
        AVG(avg_price)::numeric AS avg_price,
        AVG(avg_wage)::numeric AS avg_wage
    FROM data_academy_content.t_barbora_svobodova_project_sql_primary_final
    GROUP BY year
),
growth AS (
    -- přidání předchozího roku
    SELECT
        year,
        avg_price,
        avg_wage,
        LAG(avg_price) OVER (ORDER BY year) AS prev_price,
        LAG(avg_wage) OVER (ORDER BY year) AS prev_wage
    FROM annual
),
yoy AS (
    -- výpočet meziročního růstu cen a mezd
    SELECT
        year,
        ROUND(((avg_price - prev_price)/NULLIF(prev_price,0)*100)::numeric,2) AS price_growth,
        ROUND(((avg_wage - prev_wage)/NULLIF(prev_wage,0)*100)::numeric,2) AS wage_growth
    FROM growth
),
gdp AS (
    -- meziroční růst HDP pro ČR
    SELECT
        year,
        gdp,
        LAG(gdp) OVER (ORDER BY year) AS prev_gdp
    FROM data_academy_content.t_barbora_svobodova_project_sql_secondary_final
    WHERE country_name = 'Czech Republic'   -- ověř si přesný název
)
SELECT
    y.year,
    ROUND(((g.gdp - g.prev_gdp)/NULLIF(g.prev_gdp,0)*100)::numeric,2) AS gdp_growth,
    y.price_growth,
    y.wage_growth,
    (y.price_growth - y.wage_growth) AS diff_price_vs_wage
FROM yoy y
JOIN gdp g USING (year)
ORDER BY y.year;

