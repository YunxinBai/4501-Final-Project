
WITH uber_rides AS (
    SELECT 
        DATE(pickup_datetime) AS ride_date,
        strftime('%w', pickup_datetime) AS day_of_week_index,
        COUNT(*) AS trip_count
    FROM 
        uber_trips
    WHERE 
        DATE(pickup_datetime) BETWEEN '2020-01-01' AND '2024-08-31'
    GROUP BY 
        ride_date
),
validated_days AS (
    -- Dynamically calculate the day of the week based on the actual ride_date
    SELECT
        ride_date,
        CASE strftime('%w', ride_date)
            WHEN '0' THEN 'Sunday'
            WHEN '1' THEN 'Monday'
            WHEN '2' THEN 'Tuesday'
            WHEN '3' THEN 'Wednesday'
            WHEN '4' THEN 'Thursday'
            WHEN '5' THEN 'Friday'
            WHEN '6' THEN 'Saturday'
        END AS day_of_week,
        SUM(trip_count) AS total_trips
    FROM 
        uber_rides
    GROUP BY 
        ride_date
),
aggregated_days AS (
    -- Aggregate total trips for each day of the week across all dates
    SELECT 
        day_of_week,
        SUM(total_trips) AS total_trips
    FROM 
        validated_days
    GROUP BY 
        day_of_week
)
SELECT 
    day_of_week,
    total_trips
FROM 
    aggregated_days
ORDER BY 
    total_trips DESC;
