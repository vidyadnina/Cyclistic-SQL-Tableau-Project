# Google Capstone Project: Cyclistic Trip Data Analysis

### Project summary:
- Cyclistic is a company providing bike-sharing services.
- There is a flexibility on Cyclistic’s pricing plans: single-ride pass, full-day pass (both referred to as casual riders), and annual memberships (referred to as Cyclistic members).
- Cyclistic’s finance analyst concluded that annual members are much more profitable compared to casual riders, and that growing the number of annual members is key to future growth.
- The marketing team has a goal of converting casual riders into annual members. I will be acting as a junior data analyst in the marketing team. There are a few questions to be solved:
    - How do annual members and casual riders use Cyclistic bikes differently?
    - Why would casual riders buy Cyclistic annual memberships?
    - How can Cyclistic use digital media to influence casual riders to become members?
 
 ---

### Data Exploration
After downloading six months' worth of trip data spanning from November 2023 to April 2024, the first step to examine the data is to combine them first. As the data consist of million of rows, I chose Google BigQuery's SQL tool for its capability to handle large volumes of data.

1. Appended the data by creating a new table using the UNION function.
![image](https://github.com/vidyadnina/Cyclistic-capstone-project/assets/171537335/18ac7598-a3f8-437d-a166-397c6bcf055c)

2. Checked if there are columns with null values.
   
   ![image](https://github.com/vidyadnina/Cyclistic-capstone-project/assets/171537335/aecbcee6-4391-4127-bfbe-22fcdeb1218f)
   ![image](https://github.com/vidyadnina/Cyclistic-capstone-project/assets/171537335/1e0bca5a-9581-4741-9979-847b64a2bce5)

   There were four columns with null values. We could go ahead and eliminate rows with nulls by creating a new table.
   
   ![image](https://github.com/vidyadnina/Cyclistic-capstone-project/assets/171537335/dafc6dbe-be8a-49d1-b98a-61db9747fea7)

3. Checked if there are any columns with typos.

   ![image](https://github.com/vidyadnina/Cyclistic-capstone-project/assets/171537335/1c9e8763-5be4-45ba-a1d7-8d212abf459a)
   ![image](https://github.com/vidyadnina/Cyclistic-capstone-project/assets/171537335/b1c4b764-9110-4e4c-9305-2b1faa78951a)

   Both bike-type and member-type columns looked good.

   I also checked if there are any discrepancies between the total number of Station IDs and Station Names:

   ![image](https://github.com/vidyadnina/Cyclistic-capstone-project/assets/171537335/043a44e7-ce91-4aa0-bcb1-23e76091de32)

    Assuming one Station ID only represents one station, there seemed to be some typos on both Start Station and End Station Name columns. But after further checking, each stations only had a maximum number of two rows with error, thus we could treat the errors as negligible.
   
   ![image](https://github.com/vidyadnina/Cyclistic-capstone-project/assets/171537335/1604a0c9-95e6-4318-bdae-525b8eacfbaf)
   ![image](https://github.com/vidyadnina/Cyclistic-capstone-project/assets/171537335/0d396975-7dc1-4f71-b92a-02acd9ae2df8)

4. Checked the maximum and minimum ride lengths.

   ![image](https://github.com/vidyadnina/Cyclistic-capstone-project/assets/171537335/e5603071-7c89-4e4f-af8a-67e3c16a6579)

   The maximum ride length seems to be correct, but there is negative minimum ride length. Going forward, we would treat rides with negative minimum ride length as outliers.



---

## Data Cleaning

To get around BigQuery's limitations, I cleaned the data by creating a new table. Rows with nulls were already eliminated in a previous step, so I only needed to clean rows with negative ride length, and I also added a Day of Week colimn..
![image](https://github.com/vidyadnina/Cyclistic-capstone-project/assets/171537335/f3e93e20-ac8e-4bea-b3f8-9460444c4d85)




---

## Data Analysis

The full visualization of this analysis is created using Tableau and could be accessed [here.](https://public.tableau.com/views/Cyclisticcapstone_Vidya/Dashboard1?:language=en-US&publish=yes&:sid=&:display_count=n&:origin=viz_share_link)

The following graphs would be using this color code: light green for Casual Riders and dark blue for Cyclistic Members.

![image](https://github.com/vidyadnina/Cyclistic-capstone-project/assets/171537335/bdde05ec-a7c6-4ed9-91f8-d7a07aaf3d40)



1. Member type distribution: 74.54% of riders are Cyclistic members and 25.46% are casual riders.

   ![image](https://github.com/vidyadnina/Cyclistic-capstone-project/assets/171537335/551d03fb-9122-4726-b1dc-a157edd8337f)

2. Both casual riders and members show preference to classic bikes.

   ![image](https://github.com/vidyadnina/Cyclistic-capstone-project/assets/171537335/31530fdd-8e33-4856-bda7-200bf7262406)
   
3. While the minimum and maximum ride lengths are almost the same, casual riders on average ride for 10 minutes longer than members.
   ![image](https://github.com/vidyadnina/Cyclistic-capstone-project/assets/171537335/ce5bfb92-de20-4d87-aa0c-7392bc487032)

4. Upon analyzing the number of rides taken by casual riders and members per day, it seems that Cyclistic members use the service more during weekdays, peaking on Tuesday - Thursday, while casual riders ride more during the weekends, peaking on Saturday.
   ![image](https://github.com/vidyadnina/Cyclistic-capstone-project/assets/171537335/1a496b9c-fe8d-4a00-8217-cfd73a4347df)

5. Despite the trend difference for number of rides per day, both casual riders and members show similar behaviors if we're grouping the number of rides per hour on Weekdays and Weekends. Both groups' number of rides spiked at 8 AM and 5 PM during Weekdays, and peaked at 2 PM during Weekends.
    ![image](https://github.com/vidyadnina/Cyclistic-capstone-project/assets/171537335/faf557b2-a050-4689-84c6-1feefb940e6f)


6. To further observe the behaviors of casual riders and members, I checked for the most popular routes taken between both groups and the average ride lengths for aforementioned routes.
   ![image](https://github.com/vidyadnina/Cyclistic-capstone-project/assets/171537335/4facc270-7ebc-490d-9c1a-153e503ca494)
   ![image](https://github.com/vidyadnina/Cyclistic-capstone-project/assets/171537335/6bbeeea8-3194-4645-a50a-588500e9b5b8)



8. For future marketing purposes, I also checked for the top 10 starting and ending stations  for both casual riders and members.
   ![image](https://github.com/vidyadnina/Cyclistic-capstone-project/assets/171537335/c728574f-fa7b-4499-b03a-5f56e9d547de)
   ![image](https://github.com/vidyadnina/Cyclistic-capstone-project/assets/171537335/f38148ac-0076-437a-aee8-9840ae6795d8)

   ![image](https://github.com/vidyadnina/Cyclistic-capstone-project/assets/171537335/73415393-52f8-4747-b257-23f558540559)
   ![image](https://github.com/vidyadnina/Cyclistic-capstone-project/assets/171537335/d0b130b8-fde1-4fae-a87d-6d2297991820)

---
## Conclusion
*"How do annual members and casual riders use Cyclistic bikes differently?"*

Key takeaways:
1. Both users prefer classic bikes to electric.
2. While casual riders have less number of rides, on average they ride for longer than members by a difference of ~10 minutes.
3. Cyclistic members ride more during weekdays, peaking on Tuesday - Thursday, while casual riders ride more during the weekends, peaking on Saturday. These findings suggest that casual riders ride more for leisure while current members ride more for school/work.
4. Both groups' number of rides show similar trends of spiking at 8 AM and 5 PM during Weekdays, and peaking at 2 PM during Weekends. 
5. When observing the top routes taken by both groups and their ride length, it reinforces the suggestion that casual riders mostly ride for leisure while members use the service more to ride to school/work.
6. The two groups have a significant difference in their most frequently used starting and ending stations.

---
   
## Recommendations
*"Why would casual riders buy Cyclistic annual memberships?"*

*"How can Cyclistic use digital media to influence casual riders to become members?"*
1. Show classic bikes more when designing ads as there is a preference for the type.
2. Create a promo specially designed to incentivize those who take long rides for leisure: for example, a membership package with discounts or rewards once riders have reached a certain number of ride length.
3. Create demographically targeted ads based on the top starting and ending stations to effectively reach the target audience.
4. Create a community for Cyclistic users unique for those who ride for leisure and those who ride to commute, and include the community activities in social media/promotional ads. These could foster a sense of belonging and engagement, highlighting the diverse and supportive nature of the Cyclistic community, making the service more attractive and relatable to potential new members.




   
















