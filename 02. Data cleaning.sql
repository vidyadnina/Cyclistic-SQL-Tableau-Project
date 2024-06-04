DROP TABLE IF EXISTS cyclistic.tripdata_cleaned
CREATE TABLE cyclistic.tripdata_cleaned
AS 
(SELECT
  ride_id,rideable_type,start_station_name, end_station_name, start_lat, start_lng,end_lat, end_lng, member_casual AS member_type,
  CASE 
    WHEN EXTRACT (DAYOFWEEK FROM started_at) = 1 THEN 'SUN'
    WHEN EXTRACT (DAYOFWEEK FROM started_at) = 2 THEN 'MON'
    WHEN EXTRACT (DAYOFWEEK FROM started_at) = 3 THEN 'TUE'
    WHEN EXTRACT (DAYOFWEEK FROM started_at) = 4 THEN 'WED'
    WHEN EXTRACT (DAYOFWEEK FROM started_at) = 5 THEN 'THU'
    WHEN EXTRACT (DAYOFWEEK FROM started_at) = 6 THEN 'FRI'
    WHEN EXTRACT (DAYOFWEEK FROM started_at) = 7 THEN 'SAT'
  END AS day_of_week,
  started_at,ended_at,
  TIMESTAMP_DIFF (ended_at, started_at, minute) AS ride_length_minutes

FROM cyclistic.tripdata_nonulls

WHERE TIMESTAMP_DIFF (ended_at, started_at, minute) > 1);
