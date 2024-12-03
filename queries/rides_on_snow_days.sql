
WITH combined_rides AS (
    SELECT
        DATE(pickup_datetime) AS ride_date,
        COUNT(*) AS ride_count
    FROM
        taxi_trips
    WHERE
        DATE(pickup_datetime) BETWEEN '2020-01-01' AND '2024-08-31'
    GROUP BY
        ride_date
    UNION ALL
    SELECT
        DATE(pickup_datetime) AS ride_date,
        COUNT(*) AS ride_count
    FROM
        uber_trips
    WHERE
        DATE(pickup_datetime) BETWEEN '2020-01-01' AND '2024-08-31'
    GROUP BY
        ride_date
),
aggregated_rides AS (
    SELECT
        ride_date,
        SUM(ride_count) AS total_rides
    FROM
        combined_rides
    GROUP BY
        ride_date
)
SELECT
    dw.date AS snow_date,
    dw.snowfall AS total_snowfall,
    COALESCE(ar.total_rides, 0) AS total_hired_trips
FROM
    daily_weather dw
LEFT JOIN
    aggregated_rides ar
ON
    dw.date = ar.ride_date
WHERE
    dw.snowfall > 0
ORDER BY
    dw.snowfall DESC
LIMIT 10;
