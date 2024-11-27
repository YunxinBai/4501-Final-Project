
CREATE TABLE IF NOT EXISTS hourly_weather (
    datetime TEXT NOT NULL,
    temperature FLOAT,
    precipitation FLOAT,
    wind_speed FLOAT
);

CREATE TABLE IF NOT EXISTS daily_weather (
    date TEXT NOT NULL,
    avg_precipitation FLOAT,
    avg_wind_speed FLOAT,
    total_snowfall FLOAT
);

CREATE TABLE IF NOT EXISTS taxi_trips (
    pickup_datetime TEXT NOT NULL,
    dropoff_datetime TEXT NOT NULL,
    pu_lat FLOAT,
    pu_lon FLOAT,
    do_lat FLOAT,
    do_lon FLOAT,
    trip_miles FLOAT,
    total_amount FLOAT
);

CREATE TABLE IF NOT EXISTS uber_trips (
    pickup_datetime TEXT NOT NULL,
    dropoff_datetime TEXT NOT NULL,
    pu_lat FLOAT,
    pu_lon FLOAT,
    do_lat FLOAT,
    do_lon FLOAT,
    trip_miles FLOAT,
    total_amount FLOAT
);
