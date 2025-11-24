WITH wages AS (
    SELECT
        year,
        industry_branch_name,
        AVG(avg_wage)::numeric AS avg_wage_year,
        COUNT(*) AS n_records
    FROM data_academy_content.t_barbora_svobodova_project_sql_primary_final
    WHERE avg_wage IS NOT NULL
    GROUP BY year, industry_branch_name
),
wage_change AS (
    SELECT
        year,
        industry_branch_name,
        ROUND(avg_wage_year, 2) AS avg_wage,
        n_records,
        -- absolutní meziroční změna
        ROUND(
            (avg_wage_year - LAG(avg_wage_year) OVER (PARTITION BY industry_branch_name ORDER BY year))::numeric,
            2
        ) AS wage_diff,
        -- procentní meziroční změna (bez dělení nulou)
        ROUND(
            (
                (avg_wage_year - LAG(avg_wage_year) OVER (PARTITION BY industry_branch_name ORDER BY year))
                / NULLIF(LAG(avg_wage_year) OVER (PARTITION BY industry_branch_name ORDER BY year), 0)
            ) * 100
        , 2) AS wage_diff_pct
    FROM wages
)
SELECT *
FROM wage_change
WHERE wage_diff IS NOT NULL   -- volitelné: vynechá první rok (kde není předchozí porovnání)
ORDER BY industry_branch_name, year;
