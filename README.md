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

1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají? Analýza ukazuje, že mzdy v České republice dlouhodobě rostou, ale tempo růstu se liší podle odvětví. V některých sektorech, například v pohostinství nebo zemědělství, byl růst pomalejší než v technologických nebo finančních službách. Pokles mezd se v dostupných datech nevyskytuje, spíše jde o stagnaci v méně výkonných odvětvích. Celkově lze říci, že trend je pozitivní, i když nerovnoměrný.

2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd? Na začátku sledovaného období bylo možné za průměrnou mzdu koupit výrazně méně litrů mléka a kilogramů chleba než na jeho konci. V posledním období se počet jednotek těchto základních potravin zvýšil, což ukazuje na zlepšení jejich dostupnosti. Přestože ceny potravin rostly, růst mezd byl rychlejší, a tím se zvýšila kupní síla obyvatel. Dostupnost základních potravin se tedy v čase zlepšila.

3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)? Z porovnání jednotlivých kategorií vyplývá, že nejpomaleji zdražují některé základní potraviny, například brambory nebo chléb. Tyto položky vykazují nižší meziroční procentuální nárůst cen než například maso nebo mléčné výrobky. To znamená, že jejich cenová stabilita je vyšší a méně zatěžuje rozpočet domácností. Pro spotřebitele jsou tak dlouhodobě dostupnější.

4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)? Ano, v datech se objevuje rok, kdy meziroční nárůst cen potravin překročil růst mezd o více než 10 %. Tento výkyv znamenal snížení reálné kupní síly obyvatel, protože mzdy nedokázaly pokrýt rychlejší zdražování. Taková situace ukazuje na ekonomickou nerovnováhu, která se projevila v dostupnosti základních potravin. V dalších letech se však trend opět stabilizoval.

5. Má výška HDP vliv na změny ve mzdách a cenách potravin?
