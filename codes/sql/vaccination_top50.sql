USE covid19;

-- The median of the population is 6.26 million, calculated by excel 
-- Fully vaccinated rate of country with top 50% population
CREATE VIEW fully_vaccinated_top50population
AS 
SELECT continent, location, MAX(people_fully_vaccinated_per_hundred) AS people_fully_vaccinated_per_hundred_latest, MAX(population) AS population
FROM dbo.covid_data 
WHERE dbo.covid_data.continent <> '' AND dbo.covid_data.population > 6260000
GROUP BY continent, location;
-- ORDER BY people_fully_vaccinated_per_hundred_latest DESC;

SELECT * FROM fully_vaccinated_top50population
ORDER BY people_fully_vaccinated_per_hundred_latest DESC;

DROP TABLE IF EXISTS #vaccination;
CREATE TABLE #vaccination(
	continent VARCHAR(50),
	location VARCHAR(50),
	date DATE,
	people_fully_vaccinated_per_hundred FLOAT,
	population INT,
);

INSERT INTO #vaccination
SELECT continent, location, date, people_fully_vaccinated_per_hundred, population
FROM dbo.covid_data 
WHERE dbo.covid_data.continent <> '' AND dbo.covid_data.population > 6260000
ORDER BY location, date
;
SELECT* FROM #vaccination
WHERE location = 'United Arab Emirates';

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
    PIVOT( SUM(people_fully_vaccinated_per_hundred) 
          FOR date IN (' + @PivotColumns + ')) AS P'
 
SELECT   @SQLQuery
--Execute dynamic query
EXEC sp_executesql @SQLQuery


SELECT * FROM fully_vaccinated_top50population
ORDER BY location;