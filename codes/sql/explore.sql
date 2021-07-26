USE covid19;

-- Check the data
SELECT * 
FROM dbo.covid_data
ORDER BY 3, 4;

-- Infection rate by country
SELECT continent, location, MAX(total_cases_per_million)/10000.0 AS total_cases_per_hundred_latest
FROM dbo.covid_data
WHERE dbo.covid_data.continent <> ''
GROUP BY continent, location
ORDER BY total_cases_per_hundred_latest DESC;

-- Infection rate by continent
SELECT location, MAX(total_cases_per_million)/10000.0 AS total_cases_per_hundred_latest
FROM dbo.covid_data
WHERE dbo.covid_data.continent = ''
GROUP BY location
ORDER BY total_cases_per_hundred_latest DESC;

-- Death rate (total) by country
SELECT continent, location, MAX(total_deaths_per_million)/10000.0 AS total_deaths_per_hundred_latest
FROM dbo.covid_data
WHERE dbo.covid_data.continent <> ''
GROUP BY continent, location
ORDER BY total_deaths_per_hundred_latest DESC;

-- Death rate (total) by continent
SELECT location, MAX(total_deaths_per_million)/10000.0 AS total_deaths_per_hundred_latest
FROM dbo.covid_data
WHERE dbo.covid_data.continent = ''
GROUP BY location
ORDER BY total_deaths_per_hundred_latest DESC;

-- Death rate (infected) by country
SELECT continent, location, MAX(total_deaths_per_million)/NULLIF(MAX(total_cases_per_million), 0)*100 AS death_rate_latest
FROM dbo.covid_data
WHERE dbo.covid_data.continent <> ''
GROUP BY continent, location
ORDER BY death_rate_latest DESC;

-- Death rate (infected) by continent
SELECT location, MAX(total_deaths_per_million)/NULLIF(MAX(total_cases_per_million), 0)*100 AS death_rate_latest
FROM dbo.covid_data
WHERE dbo.covid_data.continent = ''
GROUP BY location
ORDER BY death_rate_latest DESC;

-- Reproduction rate by country
SELECT continent, location, MAX(reproduction_rate) AS max_reproduction_rate
FROM dbo.covid_data
WHERE dbo.covid_data.continent <> ''
GROUP BY continent, location
ORDER BY max_reproduction_rate DESC;

-- Stringency index of Sweden
SELECT continent, location, date, stringency_index
FROM dbo.covid_data
WHERE dbo.covid_data.continent <> ''  AND location = 'Sweden'
ORDER BY continent, location, date;

-- ICU data (lots of missing values)
SELECT continent, location, MAX(icu_patients_per_million)/10000.0 AS icu_patients_per_hundred
FROM dbo.covid_data
WHERE dbo.covid_data.continent <> '' 
GROUP BY continent, location
ORDER BY icu_patients_per_hundred DESC;

-- Total tests so far
SELECT continent, location, MAX(total_tests_per_thousand) AS total_tests_per_thousand_latest
FROM dbo.covid_data 
WHERE dbo.covid_data.continent <> ''
GROUP BY continent, location
ORDER BY total_tests_per_thousand_latest DESC;

-- Total vaccination
SELECT continent, location, MAX(total_vaccinations_per_hundred) AS total_vaccinations_per_hundred_latest
FROM dbo.covid_data 
WHERE dbo.covid_data.continent <> ''
GROUP BY continent, location
ORDER BY total_vaccinations_per_hundred_latest DESC;

-- Fully vaccinated rate and their population
SELECT continent, location, MAX(people_fully_vaccinated_per_hundred) AS people_fully_vaccinated_per_hundred_latest, MAX(population) AS population
FROM dbo.covid_data 
WHERE dbo.covid_data.continent <> ''
GROUP BY continent, location
ORDER BY people_fully_vaccinated_per_hundred_latest DESC;

-- Fully vaccinated rate of country with more than 5 million population
SELECT continent, location, MAX(people_fully_vaccinated_per_hundred) AS people_fully_vaccinated_per_hundred_latest, MAX(population) AS population
FROM dbo.covid_data 
WHERE dbo.covid_data.continent <> '' AND dbo.covid_data.population > 5000000
GROUP BY continent, location
ORDER BY people_fully_vaccinated_per_hundred_latest DESC;

-- Hospital beds 
SELECT continent, location, MAX(hospital_beds_per_thousand) AS hospital_beds_per_thousand
FROM dbo.covid_data
WHERE dbo.covid_data.continent <> '' 
GROUP BY continent, location
ORDER BY hospital_beds_per_thousand DESC;