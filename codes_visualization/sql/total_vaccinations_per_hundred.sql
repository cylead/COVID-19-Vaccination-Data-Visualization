
DROP TABLE IF EXISTS #vaccination;
CREATE TABLE #vaccination(
	continent VARCHAR(50),
	location VARCHAR(50),
	date DATE,
	total_vaccinations_per_hundred FLOAT,
);

INSERT INTO #vaccination
SELECT continent, location, date, total_vaccinations_per_hundred
FROM dbo.covid_data 
WHERE continent <> '' AND date > '2021-01-09'
ORDER BY location, date;

SELECT* FROM #vaccination;

--Declare necessary variables
DECLARE   @SQLQuery AS NVARCHAR(MAX)
DECLARE   @PivotColumns AS NVARCHAR(MAX)

--Get unique values of pivot column  
SELECT   @PivotColumns= COALESCE(@PivotColumns + ',','') + QUOTENAME(date)
FROM (SELECT DISTINCT date FROM #vaccination)
AS PivotExample

SELECT   @PivotColumns

--Create the dynamic query with all the values for pivot column at runtime
SET   @SQLQuery = 
    N'SELECT location, ' +   @PivotColumns + '
    FROM #vaccination 
    PIVOT( SUM(total_vaccinations_per_hundred) 
          FOR date IN (' + @PivotColumns + ')) AS P'
 
SELECT   @SQLQuery
--Execute dynamic query
EXEC sp_executesql @SQLQuery

SELECT continent, location, MAX(total_vaccinations_per_hundred) AS total_vaccinations_per_hundred, MAX(people_fully_vaccinated_per_hundred) AS people_fully_vaccinated_per_hundred
FROM dbo.covid_data 
WHERE dbo.covid_data.continent <> '' 
GROUP BY continent, location
ORDER BY location;


SELECT continent, location, date, new_vaccinations_smoothed, new_vaccinations_smoothed_per_million, population
FROM dbo.covid_data 
WHERE dbo.covid_data.continent = 'Europe'  
AND date > '2021-01-09' 
ORDER BY location;