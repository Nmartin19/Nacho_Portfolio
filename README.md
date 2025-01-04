<p align="center">
<img src="https://raw.githubusercontent.com/Nmartin19/github-resources/main/covid19_data_analysis_banner..png" alt="COVID-19 Data Analysis Banner" width="100%"/>
</p>

#  COVID-19 Global Trends: EDA analysis


## 📊 Quick Overview

Exploratory data analysis (EDA) of global COVID-19 trends focusing on the top 10 most affected countries by total case numbers. The project utilizes SQL and Excel to analyze cases, deaths, and vaccination patterns to identify key insights. This analysis explores how vaccination programs influenced case and death rates in the top 10 countries from January 2020 to April 2021, providing valuable insights into the pandemic's impact and response effectiveness.


## 🛠️ Technologies Used

<p align="left">
<img src="https://img.icons8.com/color/48/000000/microsoft-sql-server.png" alt="SQL Server & SSMS" width="45" height="45"/>
<img src="https://upload.wikimedia.org/wikipedia/commons/3/34/Microsoft_Office_Excel_%282019%E2%80%93present%29.svg" alt="Excel" width="45" height="45"/>

![Microsoft Excel](https://img.shields.io/badge/Microsoft_Excel-217346?style=for-the-badge&logo=microsoft-excel&logoColor=white)
![SQL Server](https://img.shields.io/badge/Microsoft%20SQL%20Server-CC2927?style=for-the-badge&logo=microsoft%20sql%20server&logoColor=white)
![Power Pivot](https://img.shields.io/badge/Power_Pivot-217346?style=for-the-badge&logo=microsoft&logoColor=white)
![Power Query](https://img.shields.io/badge/Power_Query-217346?style=for-the-badge&logo=microsoft&logoColor=white)

### SQL Server & SSMS

- Data type optimization and conversion
- Aggregation functions (SUM, AVG, ROUND)
- GROUP BY with multiple dimensions
- JOINs for data integration
- Advanced filtering with HAVING clause
- Advanced date formatting and manipulation
- subqueries and nested queries
- Window functions (LAG) for temporal analysis
- Views for modular code organization and reusability
- Window functions (LAG) for temporal analysis
- NULL handling and edge cases
- Performance optimization through indexed views
- Case statements for conditional logic
- Cross-table data relationships


### Excel Modern Stack

- Power Query:
  
 * Data import from SQL views
 * Data transformation and loading
   
- Power Pivot:
  
 * Data modeling with multiple tables relationships
 * DAX formulas for date formatting
 * Integration of multiple data sources
   
- Data Model:
  
 * Cross-table relationships
 * PivotTables within data model
 * Cross-filtering data segmentation
   
- Interactive Dashboard:
  
 * Dynamic PivotCharts
 * Data slicers with cross-filtering
 * KPI cards and metrics
 * Professional design hierarchy

## 📌 Table of Contents

1. [Scope & Project Aims](#scope)

2. [Data Source](#data-source)

3. [Data Preparation](#data-preparation)

4. [Data Dictionary](#data-dictionary)

5. [Key Questions](#key-questions)

6. [Queries & Insights](#queries)

7. [Conclusions](#conclusions)

8. [Recommendations](#recommendations)

9. [Limitations & Future Scope](#limitations)



## 🎯 Scope & Project Aims <a name="scope"></a>


This project performs an Exploratory Data Analysis (EDA) on global COVID-19 trends, analyzing:

  - Case fatality rates in most affected countries

  - Vaccination impact on cases and deaths

  - Population-adjusted metrics

  - Temporal evolution of the pandemic


## 📂 Data Source <a name="data-source"></a>


  - Source: ourworldindata.org

  - Dataset: Available through [Alex the Analyst's GitHub repository](https://bit.ly/3xNwzGK)

  - Time period: January 2020 - April 2021

  - Coverage: 219 different locations (world, continents, and countries)



## 🔄 Data Preparation <a name="data-preparation"></a>


* The dataset was split into two Excel files for efficient analysis:

  - [COVIDdeaths.xlsx](https://github.com/Nmartin19/Covid19-EDA-Global-Trends/blob/main/Datasets/CovidDeaths.xlsx) (85,172 rows): COVID-19 deaths data

  - [COVIDvaccinations.xlsx](https://github.com/Nmartin19/Covid19-EDA-Global-Trends/blob/main/Datasets/CovidVaccinations.xlsx) (85,172 rows): Vaccination administration data


### ⚙️ Processing Steps:


- Unnecessary columns removed in excel

- Files imported to Microsoft SQL Server Express (version 16.0.1125.1)

- Data types optimized for analysis

- No extensive cleaning required



## 📖 Data Dictionary <a name="data-dictionary"></a>


  * Key fields used in the analysis:

     - CovidDeaths.xlsx:

           • location (nvarchar): geographic location (world, continents, countries)
           • date (datetime): date of observation.
           • population (float): Total population
           • new_cases (float): daily count of new confirmed COVID-19 cases
           • new_deaths (float): daily count of new COVID-19 deaths

       Other key fields

           • total_cases (float): running total of confirmed COVID-19 cases
           • total_deaths (float): running total of COVID-19 deaths

    - CovidVaccinations.xlsx:

          • location (nvarchar): geographic location (world, continents, countries)
          • date (datetime): date of observation
          • population (float): total population
          • people_vaccinated (float): Running total of people who received at least one vaccine dose 

      Other key fields

          • total_vaccinations (float): running total of vaccine doses administered
          • new_vaccinations (float): daily count of vaccine doses administered 
          • people_fully_vaccinated (float): running total of people who completed vaccination protocol
          • new_test (nvarchar): Daily count of new COVID-19 tests
          • total_test (nvarchar): Running total of COVID-19 tests
          • median_age (float): Median age of population
          • handwashing_facilitites (float): percentage of population with basic handwashing facilities
          • hospital_beds_per_thousand (float): number of hospital beds per 1,000 people


## ❓ Key Questions for Data Exploration <a name="key-questions"></a>


    Q1. What is the case fatality rate (CFR) in the top 10 countries most affected by COVID-19 by total number of confirmed cases?

    Q2. What are the top 10 countries with the highest number of confirmed cases and deaths, both in absolute terms and relative for population size?

    Q3. Which are the top 10 countries with the highest confirmed case rate per population?

    Q4. How have the monthly averages of total confirmed cases and deaths evolved from January 2020 to April 2021 in the top 10 most affected countries?

    Q5. What trends emerged in new cases and new deaths during the vaccination period (December 2020 - April 2021)?

    Q6. How did the percentage change in newly vaccinated people compare to percentage changes in new cases and deaths by country (December 2020 - April 2021)?

    Q7. What are the total numbers and percentages of vaccinated versus unvaccinated populations in the top 10 countries?



## 🔍 Queries & Insights <a name="queries"></a>


> 📁 [View complete SQL code here](/covid19_analysis_queries.sql)


Q1.-- What is the case fatality rate (CFR) in the top 10 countries most affected by COVID-19 by total number of confirmed cases?

QUERY: lines 32-46

    • Italy, the United Kingdom, and Brazil have the highest CFRs among the top 10 countries, with rates of 3.00%, 2.88%, and 2.75%, respectively, indicating a significant risk of death for infected individuals.

    • Germany, Russia, and Spain have CFRs of 2.44%, 2.28%, and 2.22%, suggesting lower but still notable risks compared to the leaders.

    • France, the United States, India, and Turkey round out the list of the top 10 countries with the highest CFRs, demonstrating varying levels of risk across different countries.

    • Overall, Italy, the UK, and Brazil exhibit the highest probabilities of death for COVID-19 infections, emphasizing the severity of the situation in these countries.



Q2.--  What are the top 10 countries with the highest number of confirmed cases and deaths, both in absolute terms and relative to population size?

QUERY: lines 65-83

    • Countries leading in absolute numbers don't necessarily show the highest rates when adjusted for population size.

    • Covid-19 caused severe impact in Italy which shows the highest mortality rate (0.20%) despite ranking 5th in confirmed cases (6.65%). 

    • Similarly, United Kingdom shows 2nd highest mortality rate (0.19%, tied with Brazil) despite ranking 6th in confirmed cases (6.53%). 

    • Other notable cases are United States (1st in case rate with 9.77%) and 2nd in mortality rate (0.17% tied with Spain), and Spain (3rd in case rate 7.54% and 2nd in mortality rate (0.17%)).

    • France shows different pattern with confirmed case rate of 8.33% (2nd) but ranks 6th in mortality rate (0.15%).

    • Lower mortality rates in countries like India (despite high absolute numbers) might indicate potential underreporting and/or Demographic advantages (e.g., younger population)



Q3.-- Which are the top 10 countries with the highest confirmed case rate per population?

QUERY: lines 98-114

    • Among the top 10 countries by total confirmed cases, only the United States appears in the top 10 (ranking 9th) for the percentage of the population confirmed positive (9.77%).

    • Andorra leads this ranking with a confirmed case rate of 17.13%. This means that 17.13% of the Andorra's population (13.232 out of 77265) was confirmed (or tested) as positive of Covid.

    • Within these countries, San Marino and Czechia shows the highest mortality rates (0.27% of population), followed by Montenegro (0.24%) and Slovenia (0.20%). The United States ranks 5th with a mortality rate of 0.17%.

    • This analysis highlights the significant impact of COVID-19 in the United States, where one might expect a lower proportion of positive cases compared to countries with smaller populations like Andorra or San Marino.

    • The high confirmed case rate in the U.S., despite its large population, indicates particularly widespread transmission of the virus. 



Q4.-- How have the monthly averages of total confirmed cases and deaths evolved from January 2020 to April 2021 in the top 10 most affected countries?

QUERY: Lines 130 - 158

    * Between January 2020 and April 2021, distinct COVID-19 waves were observed globally.

     - The first wave began in March and April 2020, followed by a summer decline in most regions. 

        • However, the United States and India showed different patterns in their monthly averages, with cases continuing to rise during the summer months. 
  
        • The U.S. experienced a brief decline in August and September 2020, while India saw a continuous increase throughout the summer, peaking in September, then declining from October 2020 until March 2021.


    - The second, more severe wave began in October 2020, with monthly averages peaking in December 2020 and January 2021. 

        • During this period, the U.S., United Kingdom, Brazil, Turkey, Russia, Spain, and Germany experienced their highest monthly averages of both cases and deaths. 

        • Some countries, including Italy, France, and India showed peaks in November 2020, before experiencing a decrease in subsequent months.


    - A third wave emerged in March and April 2021. 

        • Brazil recorded its highest monthly averages during this period, with 70,887 cases in March and 2,742 deaths in April 2021. 

        • India's monthly averages peaked in April 2021 with 231,443 cases and 1,630 deaths. 

        • Italy and France also saw peak monthly averages during this period, with Germany and Turkey, showing comparable trends.


    * Russia, Spain, the United Kingdom, and the United States showed decreasing monthly averages from early 2021 through April, avoiding this third wave. 



Q5.-- What trends emerged in new cases and new deaths during the vaccination period (December 2020 - April 2021)?

QUERY: Lines 177 - 215

    - Western nations (except Italy) demonstrated a clear pattern: as vaccination rates increased, monthly deaths decreased. 

       • The United Kingdom and United States saw remarkable progress, vaccinating millions and dramatically reducing monthly deaths.

       • France and Germany had some success in decreasing deaths, despite fluctuations in case numbers. 

       • Italy and Spain experienced mixed results, with temporary increases in deaths before an overall decrease


    - Notable exceptions emerged in several countries. 

       • Concerning patterns were observed in Brazil, India, and Turkey, where despite ongoing vaccination efforts, outcomes were less favorable, suggesting impacts from healthcare capacity limitations and the presence of new virus variants.
       

    - Vaccination success varied by country:

       • Most effective when combined with strong public health measures

       • Results differed based on healthcare infrastructure and timing


Q6:-- How did the percentage change in newly vaccinated people compare to percentage changes in new cases and deaths by country (December 2020 - April 2021)?

QUERY: Lines 233 - 273

    • Western nations demonstrated successful vaccination campaigns with varying but positive outcomes.
    
    • The United States achieved striking results:

      • Increased vaccinations by 1096%
      
      • Reduced deaths by 92%
      
      • Reduced cases by 85%

    • The United Kingdom achieved remarkable reductions:

      • 87% decrease in deaths
      
      • 128% decrease in cases
      
      • With just a 2.85% vaccination increase, demonstrating the effectiveness of their public health measures

    • India and Brazil, countries with massive populations, faced particularly challenging outcomes:

      • Showed increases in both cases and deaths despite vaccination efforts
      
      • Turkey showed similar concerning trends


    • Factors influencing these results:

      • Healthcare infrastructure limitations
      
      • Limited access to vaccine stock relative to population needs (as most vaccine patents and production were concentrated in Western nations)
      
      • Emergence of more virulent variants


    • The contrasting patterns between Western and non-Western nations reflect:

      • Potential inequalities in vaccine distribution
      
      • Ineffective implementation strategies
      
      • Varying public health measures
      
      • Geographical and population challenges 



Q7.-- What are the total numbers and percentages of vaccinated versus unvaccinated populations in the top 10 countries?

Query: Lines 290 - 307

    • The United States and the United Kingdom vaccinated high percentages of their populations, enabling significant declines in COVID-19 deaths.
    
    • In contrast, many European countries exhibited more moderate vaccination coverage but still managed to reduce mortality, likely aided by effective policies and the lack of emergence of new variants at the time.
    
    • Highly populous nations like India, Russia, and Brazil struggled to vaccinate even 14% of their population, facing surges in cases and deaths due to:

      • Infrastructure challenges
      
      • Insufficient vaccine supply

    • These divergent outcomes underscore the critical need to address global inequities in:

      • Vaccine access
      
      • Vaccine administration

    • This requires more equitable and collaborative public health strategies globally.



## 📊 Conclusions <a name="conclusions"></a>

    • Variations in COVID-19 mortality across countries suggest factors beyond just healthcare capacity, such as demographics and reporting, significantly impact outcomes.
    
    • The U.S. was the nation most severely affected, with the highest case count and infection rate.
    
    • The pandemic unfolded in three distinct waves, with the second wave in late 2020 being the most severe globally.
    
    • Early vaccine access in Western nations like the U.S. and UK proved crucial in reducing deaths before variant emergence, though did not fully stop virus transmission.
    
    • Global inequities in vaccine distribution and healthcare infrastructure capacity posed major challenges in coordinating an effective worldwide pandemic response.
    
    • Factors like variant emergence, delayed vaccine supply, and implementation issues contributed to high death rates despite rising vaccinations in some countries.



## 💡 Data-Driven Recommendations <a name="recommendations"></a>

    • Strengthen standardized international COVID-19 data tracking to enable robust cross-country analysis.
    
    • Enhance real-time monitoring systems using benchmarks from successful countries for early interventions.
    
    • Refine resource distribution protocols based on a composite index of population, healthcare capacity, and mortality rates.
    
    • Develop more robust metrics to effectively track pandemic response, accounting for vaccination, mortality reduction, and healthcare capacity.
    
    • Accelerate predictive risk models combining population, healthcare, and epidemiological data to proactively identify vulnerable regions.
    
    • Require comprehensive reporting on vaccination strategy implementation and lessons learned.
    
    • Increase investment in capacity building for health systems in low/middle-income countries.
    
    • Allocate funding for collaborative research on sociodemographic impacts on COVID-19 mortality disparities.
    

 
## 🔄 Limitations & Future Scope <a name="limitations"></a>


    - Data Limitations

      • Time frame constraints: Limited to January 2020 - April 2021, with vaccination data only available from December 2020

      • Data reliability: Potential underreporting and varying testing capacities across countries affect data quality

    - Future Scope

      • Comprehensive healthcare analysis: Investigate relationship between healthcare infrastructure (hospital beds, facilities) and COVID-19 outcomes

      • Demographic impact study: Analyze how population characteristics (age, density) influenced mortality and transmission rates

      • Enhanced statistical approach: Develop statistical models to establish causation and create standardized metrics for cross-country comparison



## 📈 Visualizations

   [📊 Dashboard](./Visualizations/Dashboard_Covid19_Global_Trends.png)

   [📊 Dashboard and charts_excel_files](./Visualizations/Dashboard%20and%20charts.xlsx)


## Usage Rights and Restrictions

  This project is licensed under a modified MIT License. In brief:

  - You are free to use, copy, modify, and distribute this software, subject to certain conditions.
  - Attribution is required.
  - Specific guidelines apply to the use of visualizations, SQL code, and datasets.

  For full details on usage rights and restrictions, please refer to the [LICENSE.md](LICENSE.md) file in this repository.


## 👨‍💻 About Me

Data Analyst passionate about uncovering insights through data analysis. Looking to collaborate on data analysis projects in SaaS, gaming, or healthcare sectors.
For a more comprehensive narrative overview of the project and my background and experience, please visit my portfolio website at  [https://nmartinviveros.wixsite.com/nmartin/my-blog]


### 🔗 Contact/collaborations

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=flat&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/juan-ignacio-mart%C3%ADn-viveros-8a26a423/)
