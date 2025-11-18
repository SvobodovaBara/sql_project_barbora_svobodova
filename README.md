
# Projekt SQL – Dostupnost potravin v ČR

## Úvod
Na vašem analytickém oddělení nezávislé společnosti se snažíme zodpovědět několik výzkumných otázek týkajících se dostupnosti základních potravin. Výsledky budou prezentovány tiskovému oddělení a následně na konferenci.

## Cíl projektu
Připravit robustní datové podklady, které umožní porovnání dostupnosti potravin na základě průměrných příjmů za určité časové období.

## Datové zdroje
### Primární tabulky

- **czechia_payroll** – mzdy v různých odvětvích za několik let  
- **czechia_payroll_calculation** – číselník kalkulací  
- **czechia_payroll_industry_branch** – číselník odvětví  
- **czechia_payroll_unit** – číselník jednotek  
- **czechia_payroll_value_type** – číselník typů hodnot  
- **czechia_price** – ceny vybraných potravin  
- **czechia_price_category** – číselník kategorií potravin  

### Číselníky sdílených informací o ČR

- **czechia_region** – kraje ČR  
- **czechia_district** – okresy ČR  

### Dodatečné tabulky

- **countries** – informace o zemích (město, měna, populace)  
- **economies** – HDP, GINI, daňová zátěž apod.

## Výzkumné otázky
- Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
- Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
- Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
- Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
- Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce    výraznějším růstem?

## Výstupy projektu
- **Primární tabulka:** `t_barbora_svobodova_project_sql_primary_final` – data mezd a cen potravin pro ČR (sjednocené na společné roky)  
- **Sekundární tabulka:** `t_barbora_svobodova_project_sql_secondary_final` – dodatečná data o dalších evropských státech (HDP, GINI, populace)  

## SQL skripty
- `t_barbora_svobodova_project_sql_primary_final.sql` – vytvoření primární tabulky  
- `t_barbora_svobodova_project_sql_secondary_final.sql` – vytvoření sekundární tabulky  
- `01_question_1_wage_trends.sql` – mzdy v odvětvích  
- `02_question_2_milk_bread.sql` – koupitelný objem mléka a chleba  
- `03_question_3_lowest_price_growth.sql` – nejpomaleji zdražující kategorie potravin  
- `04_question_4_food_price_vs_wage.sql` – roky s růstem cen > růst mezd  
- `05_question_5_gdp_effect.sql` – vliv HDP na mzdy a ceny potravin  

Shrnutí výsledků

Analýza ukazuje, že mzdy v ČR dlouhodobě rostou, i když ne rovnoměrně napříč odvětvími, zatímco dostupnost základních potravin, jako je mléko a chléb, se díky růstu mezd postupně zlepšila.
Nejstabilnější cenový vývoj vykazují některé základní potraviny, zatímco jiné, například maso, zdražují rychleji.
V datech se objevuje i období, kdy ceny potravin rostly výrazně rychleji než mzdy, což vedlo ke snížení kupní síly obyvatel. Růst HDP má obecně pozitivní vliv na mzdy, ale jeho dopad na ceny potravin je méně přímý a často opožděný.
