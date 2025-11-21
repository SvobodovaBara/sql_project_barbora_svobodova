WITH wage_change AS (
    SELECT
        year,
        industry_branch_name,
        avg_wage,
        ROUND((avg_wage - LAG(avg_wage) OVER (PARTITION BY industry_branch_name ORDER BY year))::numeric, 2) AS wage_diff
    FROM data_academy_content.t_barbora_svobodova_project_sql_primary_final
)
SELECT *
FROM wage_change
ORDER BY industry_branch_name, year;
