WITH wages AS (
    SELECT
        p.payroll_year AS year,
        ib.name AS industry_branch_name,
        AVG(p.value) AS avg_wage
    FROM czechia_payroll p
    LEFT JOIN czechia_payroll_industry_branch ib
        ON p.industry_branch_code = ib.code
    WHERE p.value IS NOT NULL
      AND p.value_type_code = 5958   -- průměrná mzda
      AND p.unit_code = 200           -- Kč
    GROUP BY p.payroll_year, ib.name
),
wage_change AS (
    SELECT
        year,
        industry_branch_name,
        avg_wage,
        ROUND((avg_wage - LAG(avg_wage) OVER (PARTITION BY industry_branch_name ORDER BY year))::numeric, 2) AS wage_diff
    FROM wages
)
SELECT *
FROM wage_change
ORDER BY industry_branch_name, year;
