/*
COVID 19 DATA EXPLORATION  
SKILLS USED: JOINS CTE'S, TEMP TABLES, WINDOWS FUNCTIONS, AGGREGATE FUNCTIONS, CREATING VIEWS, CONVERTING DATA TYPES, NULLING VALUES
*/

SELECT *
FROM COVID_DEATHS

-- SELECT *
-- FROM COVID_VACCINATIONS

-- SELECTING THE DATA THAT WE ARE GOING TO BE USING

SELECT LOCATION, TO_DATE(DATE_, 'DD/MM/YYYY') TOTAL_CASES, NEW_CASES, TOTAL_DEATHS, POPULATION
FROM COVID_DEATHS
WHERE CONTINENT IS NOT NULL
ORDER BY 1, 2

-- LOOKING AT TOTAL CASES VS TOTAL DEATHS
-- SHOWS CHANCES OF DYING WHEN CONTRACTING COVID IN THE UNITED KINGDOM

SELECT LOCATION, TO_DATE(DATE_, 'DD/MM/YYYY'), TOTAL_CASES, TOTAL_DEATHS, (TOTAL_DEATHS/TOTAL_CASES)*100 AS DEATH_PERCENTAGE
FROM COVID_DEATHS
WHERE LOCATION LIKE '%Kingdom%'
AND CONTINENT IS NOT NULL
ORDER BY 1, 2

-- LOOKING AT TOTAL CASES VS POPULATION
-- SHOWS WHAT PERCENTAGE OF UNITED KINGDOM CONTRACTED COVID

SELECT LOCATION, TO_DATE(DATE_, 'DD/MM/YYYY'), TOTAL_CASES, POPULATION, (TOTAL_CASES/POPULATION)*100 AS CONTRACTION_PERCENTAGE 
FROM COVID_DEATHS
WHERE LOCATION LIKE '%Kingdom%'
AND CONTINENT IS NOT NULL
ORDER BY 1, 2

-- SHOWS WHAT PERCENTAGE OF POPULATION CONTRACTED COVID

SELECT LOCATION, TO_DATE(DATE_, 'DD/MM/YYYY') TOTAL_CASES, POPULATION, (TOTAL_CASES/POPULATION)*100 AS CONTRACTION_PERCENTAGE 
FROM COVID_DEATHS
--WHERE LOCATION LIKE '%Kingdom%'
WHERE CONTINENT IS NOT NULL
ORDER BY 1, 2

-- LOOKING AT COUNTRIES WITH HIGHEST INFECTION RATE PER TO POPULATION

SELECT LOCATION, POPULATION, MAX(TOTAL_CASES) AS "HIGHTEST INFECTION COUNT", NVL(MAX(TOTAL_CASES/POPULATION*100), '0') AS "HIGHEST CONTRACTION PERCENTAGE"
FROM COVID_DEATHS
--WHERE LOCATION LIKE '%Kingdom%'
GROUP BY LOCATION, POPULATION
ORDER BY "HIGHEST CONTRACTION PERCENTAGE" DESC

-- SHOWING COUNTRIES WITH HIGHEST DEATHCOUNT PER POPULATION

SELECT LOCATION, NVL(MAX(TOTAL_DEATHS), 0) AS "TOTAL DEATH COUNT"
FROM COVID_DEATHS
--WHERE LOCATION LIKE '%Kingdom%'
WHERE CONTINENT IS NOT NULL
GROUP BY LOCATION
ORDER BY "TOTAL DEATH COUNT" DESC

-- BREAKING THINGS DOWN BY CONTINENT

-- SHOWS CONTINENTS WITH THE HIGHEST DEATH COUNT PER POPULATION

SELECT CONTINENT, NVL(MAX(TOTAL_DEATHS), 0) AS "TOTAL DEATH COUNT"
FROM COVID_DEATHS
-- WHERE LOCATION LIKE '%Kingdom%'
WHERE CONTINENT IS NOT NULL
GROUP BY CONTINENT
ORDER BY "TOTAL DEATH COUNT" DESC

-- LOOKING AT CONTINENTS WITH HIGHEST INFECTION RATE COMPARED TO POPULAITON

SELECT CONTINENT, MAX(POPULATION) AS POPULATION, MAX(TOTAL_CASES) AS "HIGHTEST INFECTION COUNT", NVL(MAX(TOTAL_CASES/POPULATION*100), '0') AS "HIGHEST INFECTION RATE PERCENTAGE"
FROM COVID_DEATHS
--WHERE LOCATION LIKE '%Kingdom%'
WHERE CONTINENT IS NOT NULL
GROUP BY CONTINENT
ORDER BY "HIGHEST INFECTION RATE PERCENTAGE" DESC

-- GLOBAL NUMBERS

-- SHOWS TOTAL WORLDWIDE DEATHS AND WORLDWIDE DEATH PERCENTAGE

SELECT SUM(NEW_CASES) AS TOTAL_CASES, SUM(NEW_DEATHS) AS TOTAL_DEATHS, SUM(NEW_DEATHS)/SUM(NEW_CASES)*100 AS "DEATH PERCENTAGE" 
FROM Covid_Deaths
-- WHERE LOCATION LIKE '%Kingdom%'
WHERE CONTINENT IS NOT NULL
ORDER BY 1, 2

-- TOTAL POPULATION VS VACCINATIONS 
-- SHOWS PERCENTAGE OF POPULATION THAT HAS RECIEVED AT LEAST ONE COVID VACCINE 

SELECT DEA.CONTINENT, DEA.LOCATION, TO_DATE(DEA.DATE_, 'DD/MM/YYYY') AS "DATE" , DEA.POPULATION, VAC.NEW_VACCINATIONS, 
SUM(VAC.NEW_VACCINATIONS) OVER (PARTITION BY DEA.LOCATION ORDER BY DEA.LOCATION, TO_DATE(DEA.DATE_, 'DD/MM/YYYY')) AS "ROLLING PEOPLE VACCINATED"
FROM COVID_DEATHS DEA INNER JOIN COVID_VACCINATIONS VAC
ON DEA.LOCATION = VAC.LOCATION
AND DEA.DATE_ = VAC.DATE_
WHERE DEA.CONTINENT IS NOT NULL
ORDER BY 2, 3

-- USE CT

WITH POPVSVAC (CONTINENT, LOCATION, DATE_, POPULATION, NEW_VACCINATIONS, ROLLING_PEOPLE_VACCINATED)
AS
(
SELECT DEA.CONTINENT, DEA.LOCATION, TO_DATE(DEA.DATE_, 'DD/MM/YYYY') AS "DATE" , DEA.POPULATION, VAC.NEW_VACCINATIONS, 
SUM(VAC.NEW_VACCINATIONS) OVER (PARTITION BY DEA.LOCATION ORDER BY DEA.LOCATION, TO_DATE(DEA.DATE_, 'DD/MM/YYYY')) AS ROLLING_PEOPLE_VACCINATED
FROM COVID_DEATHS DEA INNER JOIN COVID_VACCINATIONS VAC
ON DEA.LOCATION = VAC.LOCATION
AND DEA.DATE_ = VAC.DATE_
WHERE DEA.CONTINENT IS NOT NULL
ORDER BY 2, 3
)

SELECT CONTINENT, LOCATION, DATE_, POPULATION, NEW_VACCINATIONS, ROLLING_PEOPLE_VACCINATED, ROLLING_PEOPLE_VACCINATED/POPULATION*100 AS PERCENTAGE_PEOPLE_VACCINATED
FROM POPVSVAC

-- CREATING VIEW TO STORE DATA FOR VISUALISATIONS 

CREATE VIEW PERCENTAGE_PEOPLE_VACCINATED AS
SELECT DEA.CONTINENT, DEA.LOCATION, TO_DATE(DEA.DATE_, 'DD/MM/YYYY') AS "DATE" , DEA.POPULATION, VAC.NEW_VACCINATIONS, 
SUM(VAC.NEW_VACCINATIONS) OVER (PARTITION BY DEA.LOCATION ORDER BY DEA.LOCATION, TO_DATE(DEA.DATE_, 'DD/MM/YYYY')) AS ROLLING_PEOPLE_VACCINATED
FROM COVID_DEATHS DEA INNER JOIN COVID_VACCINATIONS VAC
ON DEA.LOCATION = VAC.LOCATION
AND DEA.DATE_ = VAC.DATE_
WHERE DEA.CONTINENT IS NOT NULL
ORDER BY 2, 3