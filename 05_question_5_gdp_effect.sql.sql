WITH common_years AS (
    SELECT DISTINCT EXTRACT(YEAR FROM date_from)::INT AS year
    FROM czechia_price
    INTERSECT
    SELECT DISTINCT payroll_year
    FROM czechia_payroll
    INTERSECT
    SELECT DISTINCT year FROM economies WHERE country = 'Czech Republic'
),
avg_wages AS (
    SELECT payroll_year AS year, AVG(value) AS avg_wage
    FROM czechia_payroll
    WHERE value IS NOT NULL
      AND value_type_code = 5958
      AND unit_code = 200
      AND payroll_year IN (SELECT year FROM common_years)
    GROUP BY payroll_year
),
avg_prices AS (
    SELECT EXTRACT(YEAR FROM date_from)::INT AS year, AVG(value) AS avg_price
    FROM czechia_price
    WHERE value IS NOT NULL
      AND EXTRACT(YEAR FROM date_from)::INT IN (SELECT year FROM common_years)
    GROUP BY EXTRACT(YEAR FROM date_from)::INT
),
gdp_data AS (
    SELECT year, gdp
    FROM economies
    WHERE country = 'Czech Republic'
      AND year IN (SELECT year FROM common_years)
),
growth AS (
    SELECT
        g.year,
        g.gdp,
        ROUND(((g.gdp - LAG(g.gdp) OVER (ORDER BY g.year)) / LAG(g.gdp) OVER (ORDER BY g.year) * 100)::numeric, 2) AS gdp_growth,
        ROUND(((w.avg_wage - LAG(w.avg_wage) OVER (ORDER BY w.year)) / LAG(w.avg_wage) OVER (ORDER BY w.year) * 100)::numeric, 2) AS wage_growth,
        ROUND(((p.avg_price - LAG(p.avg_price) OVER (ORDER BY p.year)) / LAG(p.avg_price) OVER (ORDER BY p.year) * 100)::numeric, 2) AS price_growth
    FROM gdp_data g
    JOIN avg_wages w ON g.year = w.year
    JOIN avg_prices p ON g.year = p.year
)
SELECT *
FROM growth
ORDER BY year;
