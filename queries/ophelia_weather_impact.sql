
WITH RECURSIVE hours AS (
    -- Generate a list of all hours in the 9-day range
    SELECT DATETIME('2023-09-25 00:00:00') AS hour
    UNION ALL
    SELECT DATETIME(hour, '+1 hour')
    FROM hours
    WHERE hour < DATETIME('2023-10-03 23:00:00')
),
hired_rides AS (
    -- Combine hired trips from taxi_trips and uber_trips
    SELECT
        strftime('%Y-%m-%d %H:00:00', pickup_datetime) AS hour,
        COUNT(*) AS trip_count
    FROM taxi_trips
    WHERE DATE(pickup_datetime) BETWEEN '2023-09-25' AND '2023-10-03'
    GROUP BY hour
    UNION ALL
    SELECT
        strftime('%Y-%m-%d %H:00:00', pickup_datetime) AS hour,
        COUNT(*) AS trip_count
    FROM uber_trips
    WHERE DATE(pickup_datetime) BETWEEN '2023-09-25' AND '2023-10-03'
    GROUP BY hour
),
aggregated_rides AS (
    -- Aggregate hired rides per hour
    SELECT
        hour,
        SUM(trip_count) AS total_trips
    FROM hired_rides
    GROUP BY hour
),
weather_data AS (
    -- Aggregate hourly weather data
    SELECT
        strftime('%Y-%m-%d %H:00:00', date) AS hour,
        SUM(precipitation) AS total_precipitation,
        AVG(wind_speed) AS avg_wind_speed
    FROM hourly_weather
    WHERE DATE(date) BETWEEN '2023-09-25' AND '2023-10-03'
    GROUP BY hour
),
final_data AS (
    -- Combine hours, rides, and weather data
    SELECT
        h.hour,
        COALESCE(ar.total_trips, 0) AS total_trips,
        COALESCE(wd.total_precipitation, 0) AS total_precipitation,
        COALESCE(wd.avg_wind_speed, 0) AS avg_wind_speed
    FROM
        hours h
    LEFT JOIN aggregated_rides ar ON h.hour = ar.hour
    LEFT JOIN weather_data wd ON h.hour = wd.hour
)
-- Select and sort the final data
SELECT
    hour,
    total_trips,
    ROUND(total_precipitation, 2) AS total_precipitation,
    ROUND(avg_wind_speed, 2) AS avg_wind_speed
FROM
    final_data
ORDER BY
    hour ASC;
