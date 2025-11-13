WITH common_years AS (
    SELECT DISTINCT EXTRACT(YEAR FROM date_from)::INT AS year
    FROM czechia_price
    INTERSECT
    SELECT DISTINCT payroll_year
    FROM czechia_payroll
),
avg_wages AS (
    SELECT 
        payroll_year AS year,
        AVG(value) AS avg_wage
    FROM czechia_payroll
    WHERE value IS NOT NULL
      AND value_type_code = 5958
      AND unit_code = 200
      AND payroll_year IN (SELECT year FROM common_years)
    GROUP BY payroll_year
),
avg_prices AS (
    SELECT 
        EXTRACT(YEAR FROM date_from)::INT AS year,
        AVG(value) AS avg_price
    FROM czechia_price
    WHERE value IS NOT NULL
      AND EXTRACT(YEAR FROM date_from)::INT IN (SELECT year FROM common_years)
    GROUP BY EXTRACT(YEAR FROM date_from)::INT
),
wage_price_growth AS (
    SELECT
        w.year,
        ROUND(((w.avg_wage - LAG(w.avg_wage) OVER (ORDER BY w.year))
              / LAG(w.avg_wage) OVER (ORDER BY w.year) * 100)::numeric, 2) AS wage_growth,
        ROUND(((p.avg_price - LAG(p.avg_price) OVER (ORDER BY p.year))
              / LAG(p.avg_price) OVER (ORDER BY p.year) * 100)::numeric, 2) AS price_growth,
        ROUND((((p.avg_price - LAG(p.avg_price) OVER (ORDER BY p.year))
              / LAG(p.avg_price) OVER (ORDER BY p.year) * 100) -
              ((w.avg_wage - LAG(w.avg_wage) OVER (ORDER BY w.year))
              / LAG(w.avg_wage) OVER (ORDER BY w.year) * 100))::numeric, 2) AS diff_growth
    FROM avg_wages w
    JOIN avg_prices p ON w.year = p.year
)
SELECT *
FROM wage_price_growth
WHERE diff_growth > 10
ORDER BY year;
