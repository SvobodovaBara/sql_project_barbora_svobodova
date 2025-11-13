# Projekt SQL
Barbora Svobodová

## Úvod
Na vašem analytickém oddělení nezávislé společnosti se snažíme zodpovědět několik výzkumných otázek týkajících se dostupnosti základních potravin. Výsledky budou prezentovány tiskovému oddělení a následně na konferenci.

## Cíl projektu
Připravit robustní datové podklady, které umožní porovnání dostupnosti potravin na základě průměrných příjmů za určité časové období.  

## Datové zdroje

### Primární tabulky
- `czechia_payroll` – mzdy v různých odvětvích za několik let
- `czechia_payroll_calculation` – číselník kalkulací
- `czechia_payroll_industry_branch` – číselník odvětví
- `czechia_payroll_unit` – číselník jednotek
- `czechia_payroll_value_type` – číselník typů hodnot
- `czechia_price` – ceny vybraných potravin
- `czechia_price_category` – číselník kategorií potravin

### Číselníky sdílených informací o ČR
- `czechia_region` – kraje ČR
- `czechia_district` – okresy ČR

### Dodatečné tabulky
- `countries` – informace o zemích (město, měna, populace)
- `economies` – HDP, GINI, daňová zátěž apod.

## Výzkumné otázky
1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?  
3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)? 
4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)? 
5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?

## Výstupy projektu
- **Primární tabulka:** `t_barbora_svobodova_project_sql_primary_final` – data mezd a cen potravin pro ČR (sjednocené na společné roky)  
- **Sekundární tabulka:** `t_barbora_svobodova_project_sql_secondary_final` – dodatečná data o dalších evropských státech (HDP, GINI, populace)  

## Struktura repozitáře
