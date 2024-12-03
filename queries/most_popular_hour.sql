
SELECT 
    strftime('%H', pickup_datetime) AS hour,
    COUNT(*) AS trip_count
FROM 
    taxi_trips
WHERE 
    DATE(pickup_datetime) BETWEEN '2020-01-01' AND '2024-08-31'
GROUP BY 
    hour
ORDER BY 
    trip_count DESC;
