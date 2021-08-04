-- In this script, we will explore the vaccination from different manufactures
USE covid19;

SELECT *
FROM dbo.vaccinations_manufactures
;

-- Only 33 countries' data
SELECT COUNT(DISTINCT location)
FROM dbo.vaccinations_manufactures
;

DROP VIEW IF EXISTS latest_vac_manu;

CREATE VIEW latest_vac_manu AS(
SELECT *
FROM dbo.vaccinations_manufactures AS v1
WHERE date = 
(
	SELECT max(v2.date)
	FROM dbo.vaccinations_manufactures AS v2
	WHERE v2.location = v1.location)
);

-- Get the latest data
SELECT * FROM latest_vac_manu;

-- Get the sum of vaccination group by manufactures
SELECT vaccine, SUM(total_vaccinations) AS sum_vaccinations
FROM latest_vac_manu
GROUP BY vaccine
ORDER BY sum_vaccinations DESC;

DROP VIEW IF EXISTS latest_vac_manu_most;

CREATE VIEW latest_vac_manu_most AS(
SELECT *
FROM latest_vac_manu AS l1
WHERE  total_vaccinations = 
(
	SELECT max(l2.total_vaccinations)
	FROM latest_vac_manu AS l2
	WHERE l2.location = l1.location)
);

-- Get the most-vaccinated vaccine for each countries
SELECT *
FROM latest_vac_manu_most;

--Count the number of countries for the most-vaccinated vaccine
SELECT vaccine, COUNT(vaccine) AS number_of_countries
FROM latest_vac_manu_most
GROUP BY vaccine;
