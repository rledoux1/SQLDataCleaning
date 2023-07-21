--Data Cleaning Portfolio--


Select *
from PortfolioProject.dbo.VW_Carsales_data$

--Standardize Date Format

Select ad_date  
from PortfolioProject.dbo.VW_Carsales_data$

Select ad_date, CONVERT(date, ad_date)
from PortfolioProject.dbo.VW_Carsales_data$

UPDATE VW_Carsales_data$
SET ad_date = CONVERT(date, ad_date)

ALTER TABLE VW_Carsales_data$
ADD AdDateConverted Date;

UPDATE VW_Carsales_data$
SET AdDateConverted = CONVERT(date, ad_date)

Select AdDateConverted, CONVERT(date, ad_date)
from PortfolioProject.dbo.VW_Carsales_data$

------Populate City Data ------

Select city
from PortfolioProject.dbo.VW_Carsales_data$
WHERE city is null

Select *
from PortfolioProject.dbo.VW_Carsales_data$
order by advertisement_number

---using self join for duplicates if advertisement_number, not the same row as custoemr id is = to duplicate city --

SELECT a.advertisement_number, a.city, b.advertisement_number, b.city
FROM PortfolioProject.dbo.VW_Carsales_data$ a
JOIN PortfolioProject.dbo.VW_Carsales_data$ B
	ON a.advertisement_number = b.advertisement_number
	AND a.[customer_id] <> b.[customer_id]
WHERE a.city is null

---there was 1 row where city was null, it need to be filled to match b.city---

SELECT a.advertisement_number, a.city, b.advertisement_number, b.city, ISNULL (a.city, b.city)
FROM PortfolioProject.dbo.VW_Carsales_data$ a
JOIN PortfolioProject.dbo.VW_Carsales_data$ B
	ON a.advertisement_number = b.advertisement_number
	AND a.[customer_id] <> b.[customer_id]
WHERE a.city is null

UPDATE a
SET city = ISNULL (a.city, b.city)
FROM PortfolioProject.dbo.VW_Carsales_data$ a
JOIN PortfolioProject.dbo.VW_Carsales_data$ B
	ON a.advertisement_number = b.advertisement_number
	AND a.[customer_id] <> b.[customer_id]
WHERE a.city is null

------- Delete Unused Columns - not recommended on raw data in real business (get permission) -----

SELECT *
FROM PortfolioProject.dbo.VW_Carsales_data$

ALTER TABLE PortfolioProject.dbo.VW_Carsales_data$
DROP COLUMN ad_date, TRY_USD, F18, F1, unnamed

ALTER TABLE PortfolioProject.dbo.VW_Carsales_data$
DROP COLUMN ad_dateconverted