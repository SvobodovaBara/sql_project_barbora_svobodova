DROP TABLE IF EXISTS data_academy_content.t_barbora_svobodova_project_sql_primary_final;

CREATE TABLE data_academy_content.t_barbora_svobodova_project_sql_primary_final AS
WITH common_years AS (
    SELECT DISTINCT EXTRACT(YEAR FROM date_from)::INT AS year
    FROM czechia_price
    INTERSECT
    SELECT DISTINCT payroll_year
    FROM czechia_payroll
),
wages AS (
    SELECT
        p.payroll_year AS year,
        p.industry_branch_code,
        ib.name AS industry_branch_name,
        AVG(p.value) AS avg_wage
    FROM czechia_payroll p
    LEFT JOIN czechia_payroll_industry_branch ib
        ON p.industry_branch_code = ib.code
    WHERE p.value IS NOT NULL
      AND p.value_type_code = 5958
      AND p.unit_code = 200
      AND p.payroll_year IN (SELECT year FROM common_years)
    GROUP BY p.payroll_year, p.industry_branch_code, ib.name
),
prices AS (
    SELECT
        EXTRACT(YEAR FROM cp.date_from)::INT AS year,
        cp.category_code,
        pc.name AS category_name,
        AVG(cp.value) AS avg_price
    FROM czechia_price cp
    LEFT JOIN czechia_price_category pc
        ON cp.category_code = pc.code
    WHERE cp.value IS NOT NULL
      AND EXTRACT(YEAR FROM cp.date_from)::INT IN (SELECT year FROM common_years)
    GROUP BY EXTRACT(YEAR FROM cp.date_from)::INT, cp.category_code, pc.name
)
SELECT
    w.year,
    w.industry_branch_code,
    w.industry_branch_name,
    w.avg_wage,
    p.category_code,
    p.category_name,
    p.avg_price
FROM wages w
JOIN prices p
    ON w.year = p.year
ORDER BY w.year, w.industry_branch_name, p.category_name;
