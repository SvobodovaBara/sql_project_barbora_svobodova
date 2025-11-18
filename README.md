
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


1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
    Data ukazují, že průměrné mzdy v České republice dlouhodobě rostou, i když ne rovnoměrně napříč odvětvími. Většina odvětví       vykazuje stabilní růst, ale například v období hospodářské krize došlo u některých odvětví k mírnému poklesu. Celkový trend      je však pozitivní – průměrná mzda se od roku 2006 do posledního sledovaného roku zvýšila o více než 50 %. Obecně lze tedy        říci, že kupní síla obyvatel postupně roste, i když rozdíly mezi odvětvími přetrvávají.
   
2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období?
   Data ukazují, že na začátku sledovaného období v roce 2006 bylo možné za průměrnou mzdu koupit přibližně 850 kg chleba nebo 1    200 litrů mléka. Na konci sledovaného období v roce 2021 to bylo již více než 1 300 kg chleba nebo 1 900 litrů mléka.            Přestože ceny potravin v průběhu let rostly, růst mezd byl výraznější. Obecně lze tedy říci, že kupní síla obyvatel se v         oblasti základních potravin zlepšila.
   
3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)? 
   Analýza meziročních změn cen ukazuje, že nejpomaleji zdražují základní potraviny, jako je mléko a některé obilné produkty.       Jejich průměrný meziroční nárůst se pohybuje kolem 2–3 %, což je výrazně méně než u masa nebo u některých mléčných výrobků.      Tyto položky tak vykazují stabilnější cenový vývoj. Obecně lze říci, že základní potraviny mají nejnižší cenovou volatilitu.
  
4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
   Ano, například v roce 2008 a znovu v roce 2012 ceny potravin vzrostly meziročně o více než 10 %, zatímco mzdy rostly jen o 3–    5 %. V těchto letech se kupní síla obyvatel snížila, protože růst cen převážil nad růstem příjmů. Tento jev se projevil          zejména u masa a mléčných výrobků. Obecně lze tedy říci, že v některých krizových obdobích byla dostupnost potravin pro          domácnosti horší.

5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na      cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?
   Data ukazují, že růst HDP má jasný vliv na mzdy, zatímco na ceny potravin působí méně přímo. V letech, kdy HDP České             republiky rostlo výrazněji (např. 2015–2018 s růstem přes 4 % ročně), došlo současně i k rychlejšímu růstu mezd – průměrně o     6–8 %. Dopad na ceny potravin je spíše opožděný: v některých letech se vyšší HDP projevil v mírném zdražení potravin, ale        často až s ročním zpožděním. Obecně lze tedy říci, že HDP koreluje především s růstem mezd, zatímco vliv na ceny potravin je     slabší a méně konzistentní.
