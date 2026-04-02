--1.historický žebříček nejúspěšnějších dvojic v dějinách Formule 1--
SELECT 
    "Winner" AS jezdec, 
    "Car" AS staj, 
    COUNT(*) AS pocet_vyher
FROM GrandPrix_races_details
WHERE "Winner" IS NOT NULL 
  AND "Winner" != ''  -- Tato řádka pojistí, že tam nebudou ani prázdné texty
  AND "Car" IS NOT NULL
GROUP BY "Winner", "Car"
HAVING pocet_vyher > 5
ORDER BY pocet_vyher DESC;
--všechny vítěze (i ty, co vyhráli jen jednou)--
SELECT 
    "Winner" AS jezdec, 
    "Car" AS staj, 
    COUNT(*) AS pocet_vyher
FROM GrandPrix_races_details
WHERE "Winner" IS NOT NULL 
  AND "Winner" != ''  -- Tato řádka pojistí, že tam nebudou ani prázdné texty
  AND "Car" IS NOT NULL
GROUP BY "Winner", "Car"
ORDER BY pocet_vyher DESC;
--2.analýza národností--
SELECT 
    d."Nationality", 
    COUNT(*) AS celkovy_pocet_vitezstvi
FROM GrandPrix_races_details r
JOIN GrandPrix_drivers_details d ON r."Winner" = d."Driver"
WHERE r."Winner" IS NOT NULL
GROUP BY d."Nationality"
ORDER BY celkovy_pocet_vitezstvi DESC
LIMIT 10;
--3.Kdo má nejvíc nejrychlejších kol?--
SELECT 
    "Driver", 
    COUNT(*) AS pocet_nejrychlejsich_kol
FROM GrandPrix_fastest_laps_details
WHERE "Time" IS NOT NULL
GROUP BY "Driver"
ORDER BY pocet_nejrychlejsich_kol DESC
LIMIT 10;
--4.Kolik různých jezdců dokázalo v každém roce zajet nejrychlejší kolo?--
SELECT 
    year, 
    COUNT(DISTINCT "Driver") AS pocet_ruznych_rekordmanu
FROM GrandPrix_fastest_laps_details
GROUP BY year
ORDER BY year DESC;
--5.seřazení okruhů podle počtu odjetých Velkých cen--
SELECT 
    "Grand Prix", 
    COUNT(*) AS celkovy_pocet_zavodu,
    MIN(year) AS prvni_zavod,
    MAX(year) AS posledni_zavod
FROM GrandPrix_races_details
WHERE "Grand Prix" IS NOT NULL
GROUP BY "Grand Prix"
ORDER BY celkovy_pocet_zavodu DESC
LIMIT 15;
--6.Který jezdec vyhrál na konkrétním okruhu?--
SELECT 
    "Winner", 
    COUNT(*) AS vitezstvi_v_monaku
FROM GrandPrix_races_details
WHERE "Grand Prix" LIKE '%Monaco%'  -- Najde vše, co obsahuje slovo Monaco
  AND "Winner" IS NOT NULL
GROUP BY "Winner"
ORDER BY vitezstvi_v_monaku DESC;
