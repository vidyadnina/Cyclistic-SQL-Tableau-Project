DROP TABLE IF EXISTS cyclistic.appendedtripdata;

CREATE TABLE cyclistic.appendedtripdata as
(SELECT * FROM cyclistic.`202404tripdata`
union all
SELECT * FROM cyclistic.`202403tripdata`
union all
SELECT * FROM cyclistic.`202402tripdata`
union all
SELECT * FROM cyclistic.`202401tripdata`
union all
SELECT * FROM cyclistic.`202312tripdata`
union all
SELECT * FROM cyclistic.`202311tripdata`);

--checking for nulls
SELECT COUNT(*) - COUNT(ride_id) ride_id,
 COUNT(*) - COUNT(rideable_type) rideable_type,
 COUNT(*) - COUNT(started_at) started_at,
 COUNT(*) - COUNT(ended_at) ended_at,
 COUNT(*) - COUNT(start_station_name) start_station_name,
 COUNT(*) - COUNT(start_station_id) start_station_id,
 COUNT(*) - COUNT(end_station_name) end_station_name,
 COUNT(*) - COUNT(end_station_id) end_station_id,
 COUNT(*) - COUNT(start_lat) start_lat,
 COUNT(*) - COUNT(start_lng) start_lng,
 COUNT(*) - COUNT(end_lat) end_lat,
 COUNT(*) - COUNT(end_lng) end_lng,
 COUNT(*) - COUNT(member_casual) member_casual
FROM cyclistic.appendedtripdata;

--4 columns have rows with nulls. Therefore, we could eliminate those rows by creating a new table 

CREATE TABLE cyclistic.tripdata_nonulls as
(SELECT  * 
FROM    cyclistic.appendedtripdata
WHERE   start_station_name IS NOT NULL AND
        end_station_name IS NOT NULL AND
        end_station_id IS NOT NULL AND
        end_lng IS NOT NULL AND
        start_station_id IS NOT NULL);

--checking how many values are in columns rideable_type & member_casual and also see if there are any typos

SELECT  distinct rideable_type
FROM    cyclistic.tripdata_nonulls;

SELECT  distinct member_casual
FROM    cyclistic.tripdata_nonulls;
-- the data looks good and there's no typo

--checking if there are any duplicate ride_ids

SELECT  COUNT(ride_id) - COUNT(DISTINCT ride_id) AS duplicate_rows
FROM    cyclistic.tripdata_nonulls;
-- there's no duplicates

--checking the minimum and maximum ride lengths
WITH    ride_length_calculate as
(SELECT TIMESTAMP_DIFF(started_at, ended_at, minute) as ride_length_minutes
FROM    cyclistic.tripdata_nonulls)
SELECT  MIN(ride_length_minutes) AS min_ridelength,
        MAX(ride_length_minutes) AS max_ridelength
FROM    ride_length_calculate;

--the maximum looks good, but there is negative ride length. Check how many data have negative ride length. We would treat them as outliers
SELECT  COUNT(*) AS outlier_min
FROM    cyclistic.tripdata_nonulls
WHERE   TIMESTAMP_DIFF(started_at, ended_at,minute) <1;

--See if there are any possible typos in station names
SELECT  count(distinct start_station_id) as count_start_id, count(distinct start_station_name) as count_start_name,
        count(distinct end_station_id) as count_end_id, count(distinct end_station_name) as count_end_name,
FROM cyclistic.tripdata_nonulls;

-- since the number of IDs and names are different, there might be typos. Let's check if it could affect the findings
WITH  count_start_id as
      (SELECT distinct start_station_id, count(distinct start_station_name) as count_name
      FROM cyclistic.tripdata_nonulls
      GROUP BY start_station_id)
SELECT * 
FROM  count_start_id
WHERE count_name > 1;

WITH  count_end_id as
      (SELECT distinct end_station_id, count(distinct end_station_name) as count_name
      FROM cyclistic.tripdata_nonulls
      GROUP BY end_station_id)
SELECT * 
FROM  count_end_id
WHERE count_name > 1;

-- the number of typos is only one per station, so we could treat them as negligible and proceed as is.
