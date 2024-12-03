
WITH combined_rides AS (
    SELECT
        DATE(pickup_datetime) AS ride_date,
        COUNT(*) AS ride_count,
        AVG(trip_miles) AS avg_distance
    FROM
        taxi_trips
    WHERE
        DATE(pickup_datetime) BETWEEN '2023-01-01' AND '2023-12-31'
        AND trip_miles IS NOT NULL
    GROUP BY
        ride_date
    UNION ALL
    SELECT
        DATE(pickup_datetime) AS ride_date,
        COUNT(*) AS ride_count,
        AVG(trip_miles) AS avg_distance
    FROM
        uber_trips
    WHERE
        DATE(pickup_datetime) BETWEEN '2023-01-01' AND '2023-12-31'
        AND trip_miles IS NOT NULL
    GROUP BY
        ride_date
),
aggregated_rides AS (
    SELECT
        ride_date,
        SUM(ride_count) AS total_rides,
        AVG(avg_distance) AS avg_distance
    FROM
        combined_rides
    GROUP BY
        ride_date
),
busiest_days AS (
    SELECT
        ar.ride_date,
        ar.total_rides,
        ar.avg_distance,
        COALESCE(dw.precipitation, 0) AS precipitation,
        COALESCE(dw.average_wind_speed, 0) AS wind_speed
    FROM
        aggregated_rides ar
    LEFT JOIN
        daily_weather dw
    ON
        ar.ride_date = dw.date
)
SELECT
    ride_date,
    total_rides,
    ROUND(avg_distance, 2) AS avg_distance,
    ROUND(precipitation, 2) AS precipitation,
    ROUND(wind_speed, 2) AS wind_speed
FROM
    busiest_days
ORDER BY
    total_rides DESC
LIMIT 10;
