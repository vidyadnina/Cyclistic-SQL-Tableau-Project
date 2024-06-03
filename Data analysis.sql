--counting total rides taken
SELECT  member_type, COUNT(*) as count_of_rides
FROM    cyclistic.tripdata_cleaned
GROUP BY member_type;

--checking the average, min and max ride length across all member types and comparing to the values per group

SELECT  ROUND(AVG(ride_length_minutes),2) as avg_ride_length,
        ROUND(MIN(ride_length_minutes),2) as min_ride_length,
        ROUND(MAX(ride_length_minutes),2) as max_ride_length
from cyclistic.tripdata_cleaned;

SELECT  ROUND(AVG(ride_length_minutes),2) as avg_ride_length,
        ROUND(MIN(ride_length_minutes),2) as min_ride_length,
        ROUND(MAX(ride_length_minutes),2) as max_ride_length,
        member_type
from    cyclistic.tripdata_cleaned
GROUP BY member_type;


--checking what day is the most popular across all groups for each member types
SELECT  day_of_week, COUNT(*) AS count_day
FROM    cyclistic.tripdata_cleaned
GROUP BY day_of_week
ORDER BY count_day desc;

SELECT  member_type, day_of_week, COUNT(*) AS count_day
FROM    cyclistic.tripdata_cleaned
GROUP BY member_type, day_of_week
ORDER BY count_day desc;

--checking what day and hour of the day has the most busy traffic for each member types

SELECT  member_type, CASE WHEN (day_of_week) in ("SAT","SUN") THEN "Weekend"
        ELSE "Weekday"
        END AS weekday
        , EXTRACT(hour from started_at) as hour,count(*) as count_hour_c
FROM    cyclistic.tripdata_cleaned
WHERE   member_type = "casual"
GROUP BY member_type, weekday,hour
ORDER BY count_hour_c desc;

SELECT  member_type, CASE WHEN (day_of_week) in ("SAT","SUN") THEN "Weekend"
        ELSE "Weekday"
        END AS weekday
        , EXTRACT(hour from started_at) as hour,count(*) as count_hour_m
FROM    cyclistic.tripdata_cleaned
WHERE   member_type = "member"
GROUP BY member_type,weekday,hour
ORDER BY count_hour_m desc;

--checking what type of bike is used the most
SELECT  rideable_type,COUNT(*) as count_bike_type
FROM    cyclistic.tripdata_cleaned
GROUP BY rideable_type;

SELECT  member_type, rideable_type,COUNT(*) as count_bike_type
FROM    cyclistic.tripdata_cleaned
GROUP BY member_type,rideable_type
ORDER BY count_bike_type desc;

--checking what starting & end stations are most popular for both member types
-- we check for start and end stations for casual members first
SELECT  member_type, start_station_name, count(*) as count_start_c
FROM    cyclistic.tripdata_cleaned
WHERE   member_type = "casual"
GROUP BY member_type,start_station_name
ORDER BY count_start_c desc
LIMIT 20;

SELECT  member_type, end_station_name, count(*) as count_end_c
FROM    cyclistic.tripdata_cleaned
WHERE   member_type = "casual"
GROUP BY member_type, end_station_name
ORDER BY count_end_c desc
LIMIT 20;

--and then we also check for members
SELECT  member_type, start_station_name, count(*) as count_start_m
FROM    cyclistic.tripdata_cleaned
WHERE   member_type = "member"
GROUP BY member_type, start_station_name
ORDER BY count_start_m desc
LIMIT 20;

SELECT  member_type, end_station_name, count(*) as count_end_m
FROM    cyclistic.tripdata_cleaned
WHERE   member_type = "member"
GROUP BY member_type, end_station_name
ORDER BY count_end_m desc
LIMIT 20;

--check popular routes
SELECT  start_station_name || ' to ' || end_station_name as route, count(*) as count_route_c
FROM    cyclistic.tripdata_cleaned
WHERE   member_type = "casual"
GROUP BY route
ORDER BY count_route_c desc;

SELECT  start_station_name || ' to ' || end_station_name as route, count(*) as count_route_m
FROM    cyclistic.tripdata_cleaned
WHERE   member_type = "member"
GROUP BY route
ORDER BY count_route_m desc;

--check for same routes between casuals and members
WITH  route_c AS
      (SELECT start_station_name || ' to ' || end_station_name as route
      FROM    cyclistic.tripdata_cleaned
      WHERE   member_type = "casual"
      GROUP BY route),
      route_m AS
      (SELECT  start_station_name || ' to ' || end_station_name as route
      FROM    cyclistic.tripdata_cleaned
      WHERE   member_type = "member"
      GROUP BY route)
SELECT  route, count(*) as count_route
FROM    route_c
INNER JOIN route_m
USING   (route)
GROUP BY route
ORDER BY count_route desc;

--this returns a value of 1, thus we can't rely on similarity between routes for analysis.

--see if there's common popular start and end station between casual and members
WITH  start_c AS
      (SELECT start_station_name, count(*) as count_start_c, rank() over (order by count(start_station_name) desc) as rank_c
      FROM    cyclistic.tripdata_cleaned
      WHERE   member_type = "casual"
      GROUP BY start_station_name
      ORDER BY count_start_c desc
      LIMIT 20),
      start_m AS
      (SELECT start_station_name, count(*) as count_start_m, rank() over (order by count(start_station_name) desc) as rank_m
      FROM    cyclistic.tripdata_cleaned
      WHERE   member_type = "member"
      GROUP BY start_station_name
      ORDER BY count_start_m desc
      LIMIT 20)
SELECT  start_station_name, count_start_c, rank_c, count_start_m, rank_m
FROM    start_c
INNER JOIN start_m
USING   (start_station_name);

WITH  end_c AS
      (SELECT end_station_name, count(*) as count_end_c, rank() over (order by count(end_station_name) desc) as rank_c
      FROM    cyclistic.tripdata_cleaned
      WHERE   member_type = "casual"
      GROUP BY end_station_name
      ORDER BY count_end_c desc
      LIMIT 20),
      end_m AS
      (SELECT end_station_name, count(*) as count_end_m, rank() over (order by count(end_station_name) desc) as rank_m
      FROM    cyclistic.tripdata_cleaned
      WHERE   member_type = "member"
      GROUP BY end_station_name
      ORDER BY count_end_m desc
      LIMIT 20)
SELECT  end_station_name, count_end_c, rank_c, count_end_m, rank_m
FROM    end_c
INNER JOIN end_m
USING   (end_station_name);

