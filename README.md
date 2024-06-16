# Google Capstone Project: Cyclistic 

### Project summary:
- Cyclistic is a company providing bike-sharing services.
- There is a flexibility on Cyclistic’s pricing plans: single-ride pass, full-day pass (both referred to as casual riders), and annual memberships (referred to as Cyclistic members).
- Cyclistic’s finance analyst concluded that annual members are much more profitable compared to casual riders, and that growing the number of annual members is key to future growth.
- The marketing team has a goal of converting casual riders into annual members. I will be acting as a junior data analyst in the marketing team. There are a few questions to be solved:
    - How do annual members and casual riders use Cyclistic bikes differently?
    - Why would casual riders buy Cyclistic annual memberships?
    - How can Cyclistic use digital media to influence casual riders to become members?

### Data Exploration
After downloading six months' worth of trip data spanning from November 2023 to April 2024, the first step to examine the data is to combine them first. As the data consist of million of rows, I chose Google BigQuery's SQL tool for its capability to handle large volumes of data.

First, we append the data by creating a new table using the UNION function.
![image](https://github.com/vidyadnina/Cyclistic-capstone-project/assets/171537335/18ac7598-a3f8-437d-a166-397c6bcf055c)

After that, we could start to observe the data. I first checked if there are columns with null values.
![image](https://github.com/vidyadnina/Cyclistic-capstone-project/assets/171537335/aecbcee6-4391-4127-bfbe-22fcdeb1218f)
![image](https://github.com/vidyadnina/Cyclistic-capstone-project/assets/171537335/1e0bca5a-9581-4741-9979-847b64a2bce5)

There are four columns that has null values. We could go ahead and eliminate rows with nulls by creating a new table.
![image](https://github.com/vidyadnina/Cyclistic-capstone-project/assets/171537335/dafc6dbe-be8a-49d1-b98a-61db9747fea7)

After that, I checked if there are typos in a few columns:
![image](https://github.com/vidyadnina/Cyclistic-capstone-project/assets/171537335/1c9e8763-5be4-45ba-a1d7-8d212abf459a)
![image](https://github.com/vidyadnina/Cyclistic-capstone-project/assets/171537335/b1c4b764-9110-4e4c-9305-2b1faa78951a)

![image](https://github.com/vidyadnina/Cyclistic-capstone-project/assets/171537335/043a44e7-ce91-4aa0-bcb1-23e76091de32)




### Data Analysis

The full visualization of this analysis is created using Tableau and could be accessed [here.](https://public.tableau.com/views/Cyclisticcapstone_Vidya/Dashboard1?:language=en-US&publish=yes&:sid=&:display_count=n&:origin=viz_share_link)










