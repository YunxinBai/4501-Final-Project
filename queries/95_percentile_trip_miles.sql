
WITH combined_trips AS (
    SELECT 
        trip_miles
    FROM 
        taxi_trips
    WHERE 
        DATE(pickup_datetime) BETWEEN '2024-01-01' AND '2024-01-31'
        AND trip_miles IS NOT NULL
    UNION ALL
    SELECT 
        trip_miles
    FROM 
        uber_trips
    WHERE 
        DATE(pickup_datetime) BETWEEN '2024-01-01' AND '2024-01-31'
        AND trip_miles IS NOT NULL
),
sorted_distances AS (
    SELECT 
        trip_miles,
        ROW_NUMBER() OVER (ORDER BY trip_miles) AS row_number,
        COUNT(*) OVER () AS total_rows
    FROM 
        combined_trips
)

SELECT 
    trip_miles
FROM 
    sorted_distances
WHERE 
    row_number = CAST(0.95 * total_rows AS INT);
