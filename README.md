<p align="center">
<img src="https://raw.githubusercontent.com/Nmartin19/github-resources/main/covid19_data_analysis_banner..png" alt="COVID-19 Data Analysis Banner" width="100%"/>
</p>

#  Exploratory Data Analysis (EDA) on COVID-19 World Trends


## 📊 Quick Overview

Comprehensive analysis of global COVID-19 trends focusing on the top 10 most affected countries. The project analyzes cases, deaths, and vaccination patterns to identify key insights using SQL and Excel. 
This analysis explores how vaccination programs influenced case and death rates across different countries during the pandemic.


## 🛠️ Technologies Used

<p align="left">
<img src="https://img.icons8.com/color/48/000000/microsoft-sql-server.png" alt="SQL Server & SSMS" width="45" height="45"/>
<img src="https://upload.wikimedia.org/wikipedia/commons/3/34/Microsoft_Office_Excel_%282019%E2%80%93present%29.svg" alt="Excel" width="45" height="45"/>



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

    Q5. What trends are observed in new cases and deaths from January 2020 to April 2021, and how do they align with the vaccine rollout timeline?

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

        • However, the United States and India showed different patterns, with cases continuing to rise during the summer months. 
  
        • The U.S. experienced a brief decline in August and September 2020, while India saw a continuous increase throughout the summer, peaking in September. India's cases then declined from October 2020 until March 2021, when they surged again.


    - The second, more severe wave began in October 2020, reaching its peak in December 2020 and January 2021. 

        • During this period, the U.S., United Kingdom, Brazil, Turkey, Russia, Spain, and Germany experienced their highest monthly averages of both cases and deaths. 

        • Some countries, including Italy, France, and India showed peaks in November 2020, before experiencing a decrease in subsequent months.


    - A third wave emerged in March and April 2021 in most countries. 

        • Brazil recorded its highest monthly averages during this period, with 70,887 cases in March and 2,742 deaths in April 2021. 

        • India similarly saw both metrics peak in April 2021, reporting 231,443 cases and 1,630 deaths. 

        • Italy and France also experienced peaks in both cases and deaths in March and April 2021, with Germany and Turkey, also showed comparable trends.


    * Russia, Spain, the United Kingdom, and the United States showed a progressive decrease in monthly averages from the beginning of 2021 through April, suggesting they did not experience this third wave durig March-April 2021. 



Q5.-- What trends are observed in new cases and deaths from January 2020 to April 2021, and how do they align with the vaccine rollout timeline?

QUERY: Lines 177 - 215

    - Western nations (except Italy) demonstrated a clear pattern: as vaccination rates increased, monthly deaths decreased. 

       • This trend was particularly evident in France, Germany, Spain, UK and US, where vaccination programs coincided with declining new monthly deaths, despite varying infection levels. 

       • France presents a particular interesting case, where the increase in new people vaccinated coincided with a decrease in deaths, despite a significant increase in new confirmed cases. 

       • The case of westerns nations, and especially France, demonstrates the positive effect of vaccine administration in reducing mortality among confirmed cases. 


    - Notable exceptions emerged in several countries. 

       • Italy, deviated from the trend observed in other Western European countries, experiencing an increase in deaths from 9,183 to 11,647 between February and March 2021. 

       • Additionally, concerning patterns were observed in Brazil, India, and Turkey, where despite ongoing vaccination efforts, outcomes were less favorable, suggesting impacts from healthcare capacity limitations and the presence of virus variants.


    - Vaccination success varied by country:

       • Most effective when combined with strong public health measures

       • Results differed based on healthcare infrastructure and timing

    *Note: These patterns are observational and would require statistical analysis to establish definitive causation.*



Q6:-- How did the percentage change in newly vaccinated people compare to percentage changes in new cases and deaths by country (December 2020 - April 2021)?

QUERY: Lines 233 - 273

    * The analysis from December 2020 to April 2021 reveals two distinct vaccination impact patterns across countries. 

      - Several nations showed clear vaccination success: 

        • France reduced deaths by 28% despite rising cases (+109%), while implementing a substantial vaccination campaign (+484000%).
 
        • Germany reduced deaths by 57% despite 34% increase in confirmed cases during its vaccination campaign (+1271% new people vaccinated). 

        • Similarly, the United States and United Kingdom achieved significant decreases in both cases and deaths alongside successful vaccination programs.


     - However, some countries faced different outcomes:

        • India experienced dramatic increases across all metrics, with cases rising by 672% and deaths by 756%, despite vaccination growth of 735%. 

        • Brazil and Turkey showed similar trends, with both countries seeing increases in cases and deaths despite significant vaccination progress.


    * - Vaccination effectiveness varied by country, influenced by:

       • Healthcare capacity

       • Public health measures

       • Local conditions



Q7.-- What are the total numbers and percentages of vaccinated versus unvaccinated populations in the top 10 countries?

Query: Lines 290 - 307

    • The United States leads vaccinations (67.7%, 224M people), followed by UK (56.39%, 38.2M) 

    • European vaccination rates: Italy (40.0%), Germany (31.27%), France (27.17%), Spain (24.32%), Turkey (22.82%). 

    • In contrast, highly populous countries show significantly lower vaccination coverage. 

    • India has vaccinated 133.6 million people, representing only 9.68% of its 1.38 billion population. 

    • Similarly, Russia and Brazil report low vaccination rates of 8.3% and 13.12% respectively.

    • Significant global inequalities in vaccine distribution and administration: 

    - Unvaccinated population contrast: U.S. (32.3%) vs Russia (91.7%) and India (90.32%)

    *Note: Data includes both partial and complete vaccination schedules



## 📊 Conclusions <a name="conclusions"></a>


1 The analysis reveals a clear division between Western and developing nations in their COVID-19 response effectiveness. 

     • Western nations like the U.S. and UK achieved success in vaccination campaigns and death reduction.

     • In contrast, populous nations like India and Brazil struggled despite significant vaccination efforts.


2 Vaccination rate disparities highlight this divide:

     • India and Russia: Over 90% of population unvaccinated

     • United States: Only 32.3% unvaccinated


3 Healthcare infrastructure emerged as a critical factor. Nations with robust healthcare systems managed better outcomes even with high case numbers.

     • Highest Case Fatality Rates: Italy, UK, and Brazil. Suggests varying healthcare response capabilities


4 Population size didn't always correlate with virus incidence:

     • Smaller countries like Andorra and San Marino showed higher infection percentages

     • The United States was a notable exception among large countries


5 The pandemic evolved through three distinct waves, with varying regional impacts:

     • Western nations generally controlled their third wave through vaccination (March-April 2021)

     • India and Brazil faced peak numbers during the same period.

     • This temporal pattern, combined with vaccination data, revealed that successful outcomes required both high vaccination rates and strong healthcare systems, as demonstrated by France's 28% reduction in deaths despite rising cases.



## 💡 Data-Driven Recommendations <a name="recommendations"></a>


    • Set up real-time alert systems monitoring both absolute numbers and population-adjusted rates (cases/population), using historical data from successful countries as benchmark thresholds for early intervention.

    • Prioritize resource distribution (vaccines, medical supplies, personnel) based on a composite index combining population density, healthcare infrastructure capacity, and current Case Fatality Rates.

    • Track pandemic response effectiveness using a combined metric of vaccination rates, death reduction, and healthcare system capacity, using successful cases like France (28% death reduction despite rising cases) as benchmarks.

    • Develop predictive risk models combining population metrics, healthcare capacity, and epidemiological data to identify vulnerable regions before they reach critical levels



## 🔄 Limitations & Future Scope <a name="limitations"></a>


    - Data Limitations

      • Time frame constraints: Limited to January 2020 - April 2021, with vaccination data only available from December 2020

      • Data reliability: Potential underreporting and varying testing capacities across countries affect data quality

    - Future Scope

      • Comprehensive healthcare analysis: Investigate relationship between healthcare infrastructure (hospital beds, facilities) and COVID-19 outcomes

      • Demographic impact study: Analyze how population characteristics (age, density) influenced mortality and transmission rates

      • Enhanced statistical approach: Develop statistical models to establish causation and create standardized metrics for cross-country comparison



## 📈 Visualizations

    Coming soon! 


## 👨‍💻 About Me

Junior Data Analyst passionate about uncovering insights through data analysis. Looking to collaborate on data analysis projects in SaaS, gaming, or healthcare sectors.


### 🔗 Contact/collaborations

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=flat&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/juan-ignacio-mart%C3%ADn-viveros-8a26a423/)
