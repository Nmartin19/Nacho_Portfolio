
                          
-- CovidDeaths and CovidVacinations tables are selected for easy access and visualization when executing queries.
-- The output is ordered by country and date in ascending order to facilitate tracking the pandemic's evolution over time. 


Select * From PortfolioProject..CovidDeaths
ORDER BY location, date

Select * From PortfolioProject..Covidvaccinations
ORDER BY location, date


-- Columns new_cases, new_deaths, and people_vaccinated are converted from nvarchar to FLOAT data type to prevent aritmethic overflow in future calculations and aggregations.

ALTER TABLE CovidDeaths
ALTER COLUMN new_cases FLOAT

ALTER TABLE CovidDeaths
ALTER COLUMN new_deaths FLOAT

ALTER TABLE CovidVaccinations
ALTER COLUMN people_vaccinated FLOAT



--Q1.-- What is the case fatality rate (CFR) in the top 10 countries most affected by COVID-19 by total number of confirmed cases?

-- This query calculates the Case Fatality Rate (CFR): the percentage of confirmed COVID-19 cases that resulted in death


DROP VIEW IF EXISTS VW_Case_fatality_rate   -- The DROP VIEW statement allows for dropping and recreating the view as needed
GO                                          -- GO Separates the initial comments batch from CREATE VIEW statement
CREATE VIEW VW_Case_fatality_rate AS        -- Creating views simplifies query complexity and stores data for future visualizations in Excel and Power BI, improving performance.
Select 
      TOP 10 location, 
	  population, 
	  SUM(new_cases) as Total_confirmed_cases, 
	  SUM(new_deaths) as total_deaths, 
	  ROUND(SUM(new_deaths) / SUM(new_cases) * 100, 2) as Case_fatality_rate  -- Case fatality rate (CFR) is a key epidemiological indicator that measures disease severity among detected cases
From PortfolioProject..CovidDeaths
Where continent is not null           -- Excluding continents and World
group by location, population
ORDER BY Total_confirmed_cases DESC   -- The ORDER BY clause is allowed when creating the view with TOP, as it determines the order of rows returned by the query. Without TOP, ORDER BY cannot be used in a view creation.

GO   -- "GO" Ends the CREATE VIEW batch statement


-- Calling the previous view to simplify the query's logic. The query is prepared for export to Power Query (Excel) or Power BI for visualization, improving performance.

Select *
FROM VW_Case_fatality_rate



--Q2.-- What are the top 10 countries with the highest number of confirmed cases and deaths, both in absolute terms and relative to population size?

-- This query analyzes COVID-19 impact in two ways:

-- 1. Absolute numbers: Total confirmed cases and deaths
-- 2. Population-adjusted metrics: Percentage of population confirmed as a positive of COVID, mortality rate
-- Note: Population-adjusted metrics offer better comparability between countries with different population sizes


DROP VIEW IF EXISTS VW_COVID_Mortality_Analysis   
GO 
CREATE VIEW VW_COVID_Mortality_Analysis AS    -- creating a view simplifies the query's complexity and facilitates future export to Power Query (Excel) and Power BI
Select 
     Top 10 location, 
	 population, 
	 (population - SUM(new_cases)) as Total_population_not_confirmed,
	 ROUND((population - SUM(new_cases)) / population *100, 2) as Percentage_population_not_confirmed,
	 SUM(new_cases) as Total_confirmed_cases, 
	 ROUND(SUM(new_cases) / population * 100, 2) as confirmed_case_rate_per_population,    -- Using "confirmed case rate" instead of "infection rate". "infection rate" includes both confirmed and unconfirmed cases, which is imprecise.
	 SUM(new_deaths) as total_deaths, 
	 ROUND(SUM(new_deaths) / population * 100, 2) as Mortality_rate_per_population,    --  Simple mortality rate: deaths/population - does not consider infection spread
         ROUND((SUM(new_deaths) / SUM(new_cases)) * (SUM(new_cases) / population), 4) as Population_adjusted_mortality_rate  -- Combined metric that considers case fatality rate (deaths/cases) and confirmed case rate (cases/population), which measures disease severity and disease spread, respectively.
From PortfolioProject..CovidDeaths
Where continent is not null
GROUP BY location, population
ORDER BY Total_confirmed_cases DESC

GO    


-- Calling the previous view. The query is prepared for export to Power Query (Excel) or Power BI for visualization, improving performance.

Select *
FROM VW_COVID_Mortality_Analysis



-- Q3.-- Which are the top 10 countries with the highest confirmed case rate per population?

-- This query identifies the top 10 countries with the highest Percentage of people confirmed positive of Covid relative to their population 


DROP VIEW IF EXISTS VW_Highest_confirmed_case_rate_per_population
GO
CREATE VIEW VW_Highest_confirmed_case_rate_per_population as
Select 
     Top 10 location, 
	 population, 
	 SUM(new_cases) as Total_confirmed_cases, 
	 ROUND(SUM(new_cases) / population * 100, 2) as confirmed_case_rate_per_population, 
         SUM(new_deaths) as total_deaths, 
	 ROUND(SUM(new_deaths) / population * 100, 2) as Mortality_rate_per_population,
     ROUND((SUM(new_deaths) / SUM(new_cases)) * (SUM(new_cases) / population), 4) as Population_adjusted_mortality_rate
From PortfolioProject..CovidDeaths
Where continent is not null
GROUP BY location, population
ORDER BY confirmed_case_rate_per_population DESC

GO


-- Calling the previous view to simplify the query's logic. Ready for export to visualization tools.

Select *
FROM VW_Highest_confirmed_case_rate_per_population



--Q4.-- How have the monthly averages of total confirmed cases and deaths evolved from January 2020 to April 2021 in the top 10 most affected countries?

-- The first Subquery calculates the monthly average of new cases and new deaths, grouped by location and month ('yy-MM').
-- Second subquery identifies the top 10 countries by total number of confirmed cases in descending order.


DROP VIEW IF EXISTS VW_Monthly_AVG_New_cases_new_deaths
GO
CREATE VIEW VW_Monthly_AVG_New_cases_new_deaths AS
Select 
      location, 
      year_month, 
	  AVG_new_cases, 
	  AVG_new_deaths
FROM (
      Select 
	    location, 
	    format(date, 'yy-MM') as year_month, 
	    ROUND(AVG(new_cases), 0) as AVG_new_cases, 
            ROUND(AVG(new_deaths), 0) as AVG_new_deaths
      From PortfolioProject..CovidDeaths
      Where continent is not null 
      GROUP BY location, format(date, 'yy-MM')
     ) CovidDeaths
Where location IN ( 
                   Select 
			TOP 10 location 
	           from PortfolioProject..CovidDeaths
                   Where continent is not null
                   Group by location
	               ORDER BY SUM(new_cases) DESC
                  )
ORDER BY location, year_month                 -- The ORDER BY clause is omitted the first time the view is created.
                                              -- After executing the view, ORDER BY can be included in the query for sorting.
GO



-- Calling the previous view to simplify the query's logic. The query is prepared for export to Power Query (Excel) or Power BI for visualization, improving performance.

Select *
FROM VW_Monthly_AVG_New_cases_new_deaths
ORDER BY location, year_month



--Q5.-- What trends are observed in new cases and new deaths from January 2020 to April 2021, and how do they align with the vaccine rollout timeline?

-- This query provides the total number of new cases, new deaths, and newly vaccinated individuals per Month from January 2020 to April 2021
-- Column new_people_vaccinated is calculated as it was not included in the original dataset.



DROP VIEW IF EXISTS VW_Evolution_cases_deaths_people_vaccinated_Jan_Apr;
GO
CREATE VIEW VW_Evolution_cases_deaths_people_vaccinated_Jan_Apr AS
Select 
      location, 
      year_month, 
      SUM(new_cases) as total_new_cases, 
      SUM(new_deaths) as total_new_deaths, 
      SUM(new_people_vaccinated) as total_new_people_vaccinated
From (
      Select 
	    D.location as location, 
	    format(D.date, 'yy-MM') as year_month, 
	    SUM(D.new_cases) as new_cases, 
	    SUM(D.new_deaths) as new_deaths,
	    V.people_vaccinated as Running_total_people_vaccinated,
            ABS((V.people_vaccinated - LAG(V.people_vaccinated) OVER (Partition by format(D.date, 'yy-MM') ORDER BY format(D.date, 'yy-MM')))) as new_people_vaccinated
	                                -- LAG retrieves the value from the previous month in column V.people_vaccinated to calculate how many new people were vaccinated.
	                                -- Since V.people_vaccinated column is a running total, we subtract the previous month's value from the current one to get the number of new people vaccinated for that month.
	                                -- ABS ensures the result is positive, avoiding any negative values from the difference.
      From PortfolioProject..CovidDeaths D
      JOIN PortfolioProject..CovidVaccinations V ON D.location = V.location AND D.date = V.date
      Where D.continent is not null
      GROUP BY D.location, format(D.date, 'yy-MM'), V.people_vaccinated
	  Having format(D.date, 'yy-MM') >= '20-12' AND format(D.date, 'yy-MM') <= '21-04'   -- Filtering to include vaccination data from December 2020 to April 2021, the period for which vaccination data is available,
	                                                                                     -- using the abbreviated date format YY-MM (e.g., 20-12, 21-01) without day precision.
	  ) CovidDeaths   
 Where location IN (
                     Select 
			  TOP 10 location 
	             from PortfolioProject..CovidDeaths
                     Where continent is not null
		     Group by location
		     ORDER BY SUM(new_cases) DESC  
                   )
GROUP BY location, year_month
ORDER BY location, year_month;                             -- The ORDER BY clause is omitted the first time the view is executed.
                                                           -- After executing the view, ORDER BY can be included in the query for sorting.
GO                                                           



-- Calling the previous view. The query is prepared for export to Power Query (Excel) or Power BI for visualization.

Select *                                                     
From VW_Evolution_cases_deaths_people_vaccinated_Jan_Apr
ORDER BY location, year_month;                             


             
-- Q6.-- How did the percentage change in newly vaccinated people compare to percentage changes in new cases and deaths by country (December 2020 - April 2021)?

-- Provide the total percentage increase or decrease in new cases, new deaths, and new people vaccinated for each country from December 2020 to April 2021.



DROP VIEW IF EXISTS VW_Percentage_inc_dec_new_people_vaccinated_new_deaths_new_cases
GO
CREATE VIEW VW_Percentage_inc_dec_new_people_vaccinated_new_deaths_new_cases AS
Select 
      location, 
      ROUND(SUM(percentage_change_new_cases), 2) as percentage_change_cases,
      ROUND(SUM(percentage_change_deaths), 2) as percentage_change_deaths,
      ROUND(SUM(percentage_change_vaccinated), 2) as percentage_change_vaccinated
FROM (
Select location, 
       year_month, 
       total_new_cases,
       CASE
           WHEN LAG(total_new_cases) OVER (partition by location ORDER BY year_month) = 0
	            OR
	            LAG(total_new_cases) OVER (partition by location ORDER BY year_month) is NULL
		        THEN NULL  -- To avoid division by 0 or NULL
			    ELSE ROUND((total_new_cases - LAG(total_new_cases) OVER (Partition by location ORDER BY year_month)) / 
			         LAG(total_new_cases) OVER (Partition by location ORDER BY year_month) * 100, 2) END AS percentage_change_new_cases,  -- Calculating Percentage change of new cases with LAG function: ((current_value - previous_value) / previous_value) * 100
	   total_new_deaths, 
       CASE
           WHEN LAG(total_new_deaths) OVER (partition by location ORDER BY year_month) = 0
	            OR
	            LAG(total_new_deaths) OVER (partition by location ORDER BY year_month) is NULL
		        THEN NULL 
			    ELSE ROUND((total_new_deaths - LAG(total_new_deaths) OVER (Partition by location ORDER BY year_month)) / 
			         LAG(total_new_deaths) OVER (Partition by location ORDER BY year_month) * 100, 2) END AS percentage_change_deaths,  -- Calculating Percentage change of new deaths
	   total_new_people_vaccinated,
	   CASE
           WHEN LAG(total_new_people_vaccinated) OVER (partition by location ORDER BY year_month) = 0
	           OR
	           LAG(total_new_people_vaccinated) OVER (partition by location ORDER BY year_month) is NULL
		       THEN NULL 
			   ELSE ROUND((total_new_people_vaccinated - LAG(total_new_people_vaccinated) OVER (Partition by location ORDER BY year_month)) / 
			        LAG(total_new_people_vaccinated) OVER (Partition by location ORDER BY year_month) * 100, 2) END AS percentage_change_vaccinated  -- Calculating Percentage change of new cases
from VW_Evolution_cases_deaths_people_vaccinated_Jan_Apr) percentage_change
Group by location 
ORDER BY location                       -- The ORDER BY clause is omitted the first time the view is executed.
                                        -- After executing the view, ORDER BY can be included in the query for sorting.

GO


-- Referencing the prior view to streamline the query for better performance when exporting to Excel or Power BI.

Select *                                                     
From VW_Percentage_inc_dec_new_people_vaccinated_new_deaths_new_cases
ORDER BY location  

   
   
--Q7.-- What are the total numbers and percentages of vaccinated VS unvaccinated populations in the top 10 countries?

-- This query provides the total counts of vaccinated and unvaccinated populations and calculate their respective percentages.
-- Note: The unvaccinated population is not available as a direct column, so it is calculated based on total population.


DROP VIEW IF EXISTS VW_vaccinated_VS_unvaccinated
GO
CREATE VIEW VW_vaccinated_VS_unvaccinated AS
SELECT DISTINCT
    t.location,
    c.population,
    SUM(t.total_new_people_vaccinated) as total_new_people_vaccinated,
    ROUND((population - SUM(t.total_new_people_vaccinated)) / population * 100, 2) as percentage_population_nonvaccinated,
    ROUND(SUM(t.total_new_people_vaccinated) / population * 100, 2) as percentage_population_vaccinated
FROM VW_Evolution_cases_deaths_people_vaccinated_Jan_Apr t
JOIN (
    SELECT DISTINCT location, population 
    FROM PortfolioProject..CovidDeaths
) c ON t.location = c.location
GROUP BY t.location, c.population
ORDER BY t.location;

GO

-- Referencing the prior view to streamline the query. Ready for export to visualization tools.

SELECT *
FROM VW_vaccinated_VS_unvaccinated
ORDER BY location;
