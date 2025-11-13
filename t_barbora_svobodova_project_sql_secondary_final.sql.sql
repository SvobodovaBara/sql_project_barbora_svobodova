-- DROP TABLE pro čistý start
DROP TABLE IF EXISTS data_academy_content.t_barbora_svobodova_project_sql_secondary_final;

-- Vytvoření sekundární tabulky
CREATE TABLE data_academy_content.t_barbora_svobodova_project_sql_secondary_final AS
SELECT
    e.year,
    c.country AS country_name,
    e.gdp,
    e.gini,
    e.population
FROM economies e
JOIN countries c
    ON e.country = c.country
WHERE c.continent = 'Europe'
ORDER BY e.year, country_name;
