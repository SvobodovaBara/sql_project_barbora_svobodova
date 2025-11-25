WITH annual AS (
    SELECT
        year,
        AVG(avg_price)::numeric AS avg_price,
        AVG(avg_wage)::numeric AS avg_wage
    FROM data_academy_content.t_barbora_svobodova_project_sql_primary_final
    GROUP BY year
),
yoy AS (
    SELECT
        year,
        ROUND(((avg_price - LAG(avg_price) OVER (ORDER BY year)) / NULLIF(LAG(avg_price) OVER (ORDER BY year),0) * 100)::numeric,2) AS price_growth,
        ROUND(((avg_wage - LAG(avg_wage) OVER (ORDER BY year)) / NULLIF(LAG(avg_wage) OVER (ORDER BY year),0) * 100)::numeric,2) AS wage_growth
    FROM annual
),
gdp_cr AS (
    SELECT
        year,
        gdp,
        ROUND(((gdp - LAG(gdp) OVER (ORDER BY year)) / NULLIF(LAG(gdp) OVER (ORDER BY year),0) * 100)::numeric,2) AS gdp_growth
    FROM data_academy_content.t_barbora_svobodova_project_sql_secondary_final
    WHERE country_name ILIKE 'Czech%'
),
combined AS (
    SELECT
        y.year,
        g.gdp,
        g.gdp_growth,
        y.price_growth,
        y.wage_growth,
        LEAD(y.price_growth) OVER (ORDER BY y.year) AS price_growth_next_year,
        LEAD(y.wage_growth) OVER (ORDER BY y.year) AS wage_growth_next_year
    FROM yoy y
    JOIN gdp_cr g USING (year)
)
SELECT
    year,
    gdp,
    gdp_growth,
    price_growth,
    wage_growth,
    price_growth_next_year,
    wage_growth_next_year,
    ROUND((price_growth - wage_growth)::numeric,2) AS diff_price_vs_wage,
    ROUND((price_growth_next_year - wage_growth_next_year)::numeric,2) AS diff_price_vs_wage_next_year
FROM combined
ORDER BY year;


