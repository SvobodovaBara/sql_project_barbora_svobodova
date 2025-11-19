
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
   Na základě dostupných dat o mzdách a cenách potravin lze porovnat kupní sílu mezi prvním a posledním společně sledovaným obdobím, tedy mezi      rokem 2006 a rokem 2018.

   V roce 2006 si mohl průměrný zaměstnanec za svou mzdu koupit:
   přibližně 1 432 litrů mléka, nebo
   asi 1 282 kilogramů chleba.
   V roce 2018 se kupní síla dále zvýšila a za průměrnou mzdu bylo možné pořídit:
   zhruba 1 639 litrů mléka, nebo
   přibližně 1 340 kilogramů chleba.

  Závěr
  Během sledovaného období došlo k růstu cen potravin, avšak růst mezd byl rychlejší.
  To znamená, že kupní síla obyvatel se v případě těchto základních potravin zlepšila — v roce 2018 si lidé mohli za průměrnou mzdu koupit více    chleba i mléka než v roce 2006.
   
3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)? 
   Nejpomaleji zdražuje kategorie cukr krystalový, která meziročně zlevnila o 1,92 %.
  
4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
   Ne, podle dostupných dat žádný takový rok nebyl.

5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na      cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?
   Data ukazují, že růst HDP má jasný vliv na mzdy, zatímco na ceny potravin působí méně přímo. V letech, kdy HDP České             republiky rostlo výrazněji (např. 2015–2018 s růstem přes 4 % ročně), došlo současně i k rychlejšímu růstu mezd – průměrně o     6–8 %. Dopad na ceny potravin je spíše opožděný: v některých letech se vyšší HDP projevil v mírném zdražení potravin, ale        často až s ročním zpožděním. Obecně lze tedy říci, že HDP koreluje především s růstem mezd, zatímco vliv na ceny potravin je     slabší a méně konzistentní.

Informace o výstupních datech

Některé hodnoty meziročního růstu mohou být záporné (např. cukr krystalový -1,92 % nebo roky s poklesem HDP 2009).
Tabulka pro meziroční nárůst cen potravin je v některých případech prázdná (např. otázka 4), takže nelze uvést rok s nárůstem >10 %.
Hodnoty HDP a mezd jsou kompletní, nicméně některé meziroční změny mohou být záporné nebo velmi nízké, což je důležité zohlednit při analýze.
Celkově data ukazují: růst mezd je stabilnější než růst cen potravin, některé potraviny dokonce zaznamenaly meziroční pokles.
