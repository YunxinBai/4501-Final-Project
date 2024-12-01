
CREATE TABLE IF NOT EXISTS hourly_weather (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    date DATETIME NOT NULL,
    precipitation FLOAT,
    wind_speed FLOAT
);

CREATE TABLE IF NOT EXISTS daily_weather (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    date DATE NOT NULL,
    precipitation FLOAT,
    average_wind_speed FLOAT,
    snowfall FLOAT,
    sunrise TIME,
    sunset TIME
);

CREATE TABLE IF NOT EXISTS taxi_trips (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    pickup_datetime DATETIME NOT NULL,
    dropoff_datetime DATETIME NOT NULL,
    pu_lat FLOAT,
    pu_lon FLOAT,
    do_lat FLOAT,
    do_lon FLOAT,
    trip_miles FLOAT,
    total_amount FLOAT,
    fare_amount FLOAT,
    extra FLOAT,
    mta_tax FLOAT,
    tip_amount FLOAT,
    tolls_amount FLOAT,
    improvement_surcharge FLOAT,
    congestion_surcharge FLOAT,
    airport_fee FLOAT
);

CREATE TABLE IF NOT EXISTS uber_trips (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    pickup_datetime DATETIME NOT NULL,
    dropoff_datetime DATETIME NOT NULL,
    pu_lat FLOAT,
    pu_lon FLOAT,
    do_lat FLOAT,
    do_lon FLOAT,
    trip_miles FLOAT,
    fare_amount FLOAT,
    tolls_amount FLOAT,
    bcf FLOAT,
    sales_tax FLOAT,
    tip_amount FLOAT,
    airport_fee FLOAT,
    congestion_surcharge FLOAT
);
