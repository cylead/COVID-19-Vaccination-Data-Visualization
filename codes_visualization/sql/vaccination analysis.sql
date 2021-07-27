-- In this file, we want to evaluate the quality of the vaccination data 

SELECT continent, location, date, total_vaccinations, people_vaccinated, people_fully_vaccinated, new_vaccinations, 
	   new_vaccinations_smoothed, total_vaccinations_per_hundred, people_vaccinated_per_hundred, 
	   people_fully_vaccinated_per_hundred, new_vaccinations_smoothed_per_million
FROM dbo.covid_data 
WHERE dbo.covid_data.continent <> ''
AND date > '2021-01-10'
AND location = 'United Arab Emirates'
ORDER BY continent, location;


SELECT continent, location, date, total_vaccinations, people_vaccinated, people_fully_vaccinated,  
	   total_vaccinations_per_hundred, people_vaccinated_per_hundred, 
	   people_fully_vaccinated_per_hundred
FROM dbo.covid_data 
WHERE dbo.covid_data.continent <> ''
AND date > '2021-01-10'
-- AND continent = 'Europe'
-- AND total_vaccinations_per_hundred = 0
AND people_vaccinated_per_hundred = 0
-- AND location = 'United Arab Emirates'
ORDER BY continent, location;

SELECT continent, location, count(total_vaccinations_per_hundred)
FROM dbo.covid_data 
WHERE dbo.covid_data.continent <> ''
AND date > '2021-01-10'
AND total_vaccinations_per_hundred > 0
AND people_vaccinated_per_hundred = 0
GROUP BY continent, location;

SELECT continent, location, count(total_vaccinations_per_hundred)
FROM dbo.covid_data 
WHERE dbo.covid_data.continent <> ''
AND date > '2021-01-10'
AND total_vaccinations_per_hundred = 0
AND people_vaccinated_per_hundred > 0
GROUP BY continent, location;

