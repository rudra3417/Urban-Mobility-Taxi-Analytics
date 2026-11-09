-- Next
Select * from sample;


-- Next
SELECT COUNT(*) AS total_records
FROM dbo.sample;


-- next
SELECT TOP 0 * FROM dbo.sample;


-- next
SELECT
    COUNT(*) AS total_records,
    COUNT(vendorid) AS vendorid_count,
    COUNT(passenger_count) AS passenger_count,
    COUNT(trip_distance) AS trip_distance,
    COUNT(fare_amount) AS fare_amount,
    COUNT(total_amount) AS total_amount
FROM sample;


-- next
SELECT
    COUNT(pulocationid) AS pickup_location,
    COUNT(dolocationid) AS dropoff_location,
    COUNT(payment_type) AS payment_type,
    COUNT(tip_amount) AS tip_amount,
    COUNT(tolls_amount) AS tolls_amount,
    COUNT(airport_fee) AS airport_fee
FROM dbo.sample;


-- next
SELECT
    MIN(trip_distance) AS minimum_distance,
    MAX(trip_distance) AS maximum_distance,
    AVG(trip_distance) AS average_distance
FROM dbo.sample;


-- next
SELECT
    MIN(fare_amount) AS minimum_fare,
    MAX(fare_amount) AS maximum_fare,
    AVG(fare_amount) AS average_fare
FROM dbo.sample;


-- next
SELECT
    MIN(total_amount) AS minimum_total,
    MAX(total_amount) AS maximum_total,
    AVG(total_amount) AS average_total
FROM dbo.sample;


-- next 
SELECT
    MIN(passenger_count) AS minimum_passengers,
    MAX(passenger_count) AS maximum_passengers,
    AVG(passenger_count) AS average_passengers
FROM dbo.sample;


-- next 
SELECT DISTINCT payment_type
FROM dbo.sample;


-- next
SELECT
    payment_type,
    COUNT(*) AS total_trips
FROM dbo.sample
GROUP BY payment_type
ORDER BY total_trips DESC;


-- next
SELECT DISTINCT vendorid
FROM dbo.sample;


-- next
SELECT
    vendorid,
    COUNT(*) AS total_trips
FROM dbo.sample
GROUP BY vendorid
ORDER BY total_trips DESC;


-- next
SELECT
    pulocationid,
    COUNT(*) AS total_trips
FROM dbo.sample
GROUP BY pulocationid
ORDER BY total_trips DESC;


-- next
SELECT
    dolocationid,
    COUNT(*) AS total_trips
FROM dbo.sample
GROUP BY dolocationid
ORDER BY total_trips DESC;


-- next
SELECT
    MIN(tpep_pickup_datetime) AS first_pickup,
    MAX(tpep_pickup_datetime) AS last_pickup
FROM dbo.sample;


-- next
SELECT
    passenger_count,
    COUNT(*) AS total_trips
FROM dbo.sample
GROUP BY passenger_count
ORDER BY passenger_count;


-- next
SELECT
    ratecodeid,
    COUNT(*) AS total_trips
FROM dbo.sample
GROUP BY ratecodeid
ORDER BY total_trips DESC;


-- next
SELECT
    store_and_fwd_flag,
    COUNT(*) AS total_trips
FROM dbo.sample
GROUP BY store_and_fwd_flag;


-- next
SELECT
    trip_distance,
    AVG(fare_amount) AS average_fare
FROM dbo.sample
GROUP BY trip_distance
ORDER BY trip_distance;


-- next 
SELECT *
INTO dbo.yellow_taxi_cleaned
FROM dbo.sample;


-- next
SELECT COUNT(*) AS total_records
FROM dbo.yellow_taxi_cleaned;


-- next
SELECT tpep_pickup_datetime, COUNT(*) AS total
FROM dbo.yellow_taxi_cleaned
GROUP BY tpep_pickup_datetime
HAVING COUNT(*) > 1;


-- next
SELECT *
FROM dbo.yellow_taxi_cleaned
WHERE tip_amount IS NULL;


-- next
SELECT *
FROM dbo.yellow_taxi_cleaned
WHERE fare_amount < 0;


-- next
SELECT COUNT(*) AS negative_total_records
FROM dbo.yellow_taxi_cleaned
WHERE total_amount < 0; 


-- next
SELECT COUNT(*) AS zero_distance_records
FROM dbo.yellow_taxi_cleaned
WHERE trip_distance = 0;


-- next 
SELECT *
FROM dbo.yellow_taxi_cleaned
WHERE trip_distance = 0;


-- next
SELECT COUNT(*) AS zero_passenger_records
FROM dbo.yellow_taxi_cleaned
WHERE passenger_count = 0;


-- next
SELECT *
FROM dbo.yellow_taxi_cleaned
WHERE passenger_count = 0;


-- next
SELECT COUNT(*) AS invalid_time_records
FROM dbo.yellow_taxi_cleaned
WHERE tpep_dropoff_datetime < tpep_pickup_datetime;


-- next
SELECT
    COUNT(*) - COUNT(ratecodeid) AS null_ratecodeid,
    COUNT(*) - COUNT(store_and_fwd_flag) AS null_store_flag,
    COUNT(*) - COUNT(extra) AS null_extra,
    COUNT(*) - COUNT(mta_tax) AS null_mta_tax,
    COUNT(*) - COUNT(improvement_surcharge) AS null_improvement,
    COUNT(*) - COUNT(congestion_surcharge) AS null_congestion
FROM dbo.yellow_taxi_cleaned;


-- next
SELECT COUNT(*) AS negative_distance_records
FROM dbo.yellow_taxi_cleaned
WHERE trip_distance < 0;


--next 
SELECT COUNT(*) AS negative_passenger_records
FROM dbo.yellow_taxi_cleaned
WHERE passenger_count < 0;


-- next 
SELECT COUNT(*) AS negative_tip_records
FROM dbo.yellow_taxi_cleaned
WHERE tip_amount < 0;


-- next
SELECT *
FROM dbo.yellow_taxi_cleaned
WHERE tip_amount IS NULL;


-- next
SELECT *
FROM dbo.yellow_taxi_cleaned
WHERE tolls_amount IS NULL;


-- next
ALTER TABLE dbo.yellow_taxi_cleaned
ALTER COLUMN tpep_pickup_datetime DATETIME2;


-- next
ALTER TABLE dbo.yellow_taxi_cleaned
ALTER COLUMN tpep_dropoff_datetime DATETIME2;


-- enxt
UPDATE dbo.yellow_taxi_cleaned
SET
    tip_amount = ISNULL(tip_amount, 0),
    tolls_amount = ISNULL(tolls_amount, 0),
    airport_fee = ISNULL(airport_fee, 0);

-- next
SELECT
    COUNT(*) - COUNT(tip_amount) AS null_tip,
    COUNT(*) - COUNT(tolls_amount) AS null_tolls,
    COUNT(*) - COUNT(airport_fee) AS null_airport_fee
FROM dbo.yellow_taxi_cleaned;


-- next
ALTER TABLE dbo.yellow_taxi_cleaned
ADD payment_method VARCHAR(30);


-- next
UPDATE dbo.yellow_taxi_cleaned
SET payment_method =
    CASE
        WHEN payment_type = 1 THEN 'Credit Card'
        WHEN payment_type = 2 THEN 'Cash'
        WHEN payment_type = 3 THEN 'No Charge'
        WHEN payment_type = 4 THEN 'Dispute'
        ELSE 'Unknown'
    END;


-- next
SELECT
    payment_type,
    payment_method,
    COUNT(*) AS total_trips
FROM dbo.yellow_taxi_cleaned
GROUP BY payment_type, payment_method
ORDER BY payment_type;


-- next
SELECT *
FROM dbo.yellow_taxi_cleaned
WHERE
    tpep_dropoff_datetime < tpep_pickup_datetime
    OR trip_distance < 0;

-- next
SELECT *
FROM dbo.yellow_taxi_cleaned
WHERE trip_distance > 30;


-- next
SELECT COUNT(*) AS long_distance_trips
FROM dbo.yellow_taxi_cleaned
WHERE trip_distance > 30;


-- next
SELECT *
FROM dbo.yellow_taxi_cleaned
WHERE fare_amount > 200;


-- next
SELECT *
FROM dbo.yellow_taxi_cleaned
WHERE fare_amount > 200
AND trip_distance = 0;


-- next
DELETE FROM dbo.yellow_taxi_cleaned
WHERE trip_distance = 0
AND fare_amount > 200;

-- nect
SELECT
    payment_method,
    COUNT(*) AS negative_fare_count
FROM dbo.yellow_taxi_cleaned
WHERE fare_amount < 0
GROUP BY payment_method;


-- next
SELECT *
FROM dbo.yellow_taxi_cleaned
WHERE fare_amount < 0
AND payment_method = 'Cash';


-- next
DELETE FROM dbo.yellow_taxi_cleaned
WHERE fare_amount < 0
AND payment_method = 'Cash';


-- next
SELECT *
FROM dbo.yellow_taxi_cleaned
WHERE fare_amount < 0
AND payment_method = 'Credit Card';

-- next
DELETE FROM dbo.yellow_taxi_cleaned
WHERE fare_amount < 0
AND payment_method = 'Credit Card';


-- mext
SELECT *
FROM dbo.yellow_taxi_cleaned
WHERE fare_amount < 0
AND payment_method = 'No Charge';


-- next
SELECT COUNT(*) AS records_to_remove
FROM dbo.yellow_taxi_cleaned
WHERE payment_method = 'No Charge'
AND fare_amount <> 0;


-- next
DELETE FROM dbo.yellow_taxi_cleaned
WHERE payment_method = 'No Charge'
AND fare_amount <> 0;


-- next
SELECT
    passenger_count,
    COUNT(*) AS total_trips
FROM dbo.yellow_taxi_cleaned
GROUP BY passenger_count
ORDER BY passenger_count;


-- next
SELECT
    MIN(trip_distance) AS min_distance,
    MAX(trip_distance) AS max_distance,
    AVG(trip_distance) AS avg_distance,
    COUNT(*) AS total_trips
FROM dbo.yellow_taxi_cleaned;


-- next
SELECT *
FROM dbo.yellow_taxi_cleaned
WHERE trip_distance > 30
ORDER BY trip_distance DESC;


-- next
SELECT COUNT(*) AS zero_distance_trips
FROM dbo.yellow_taxi_cleaned
WHERE trip_distance = 0;


-- next

SELECT COUNT(*) AS invalid_records
FROM dbo.yellow_taxi_cleaned
WHERE trip_distance = 0
AND fare_amount > 0;


-- next
DELETE FROM dbo.yellow_taxi_cleaned
WHERE trip_distance = 0
AND fare_amount > 0;


-- next
SELECT
    fare_amount,
    payment_method,
    COUNT(*) AS total_trips
FROM dbo.yellow_taxi_cleaned
WHERE trip_distance = 0
GROUP BY fare_amount, payment_method
ORDER BY fare_amount;


-- next
DELETE FROM dbo.yellow_taxi_cleaned
WHERE trip_distance = 0
AND fare_amount < 0
AND payment_method = 'Dispute';


-- next
DELETE FROM dbo.yellow_taxi_cleaned
WHERE trip_distance = 0
AND fare_amount = 0
AND payment_method = 'Cash';


-- next
SELECT COUNT(*) AS remaining_zero_distance
FROM dbo.yellow_taxi_cleaned
WHERE trip_distance = 0;


-- next
SELECT
    MIN(fare_amount) AS minimum_fare,
    MAX(fare_amount) AS maximum_fare,
    AVG(fare_amount) AS average_fare,
    COUNT(*) AS total_records
FROM dbo.yellow_taxi_cleaned;


-- next
SELECT
    payment_method,
    COUNT(*) AS negative_fare_records,
    MIN(fare_amount) AS minimum_fare,
    MAX(fare_amount) AS maximum_fare
FROM dbo.yellow_taxi_cleaned
WHERE fare_amount < 0
GROUP BY payment_method
ORDER BY negative_fare_records DESC;


-- next
DELETE FROM dbo.yellow_taxi_cleaned
WHERE payment_method = 'Dispute'
AND fare_amount < 0
AND trip_distance < 0.1;


-- next
SELECT
    MAX(total_amount) AS max_total_amount,
    MIN(total_amount) AS min_total_amount,
    AVG(total_amount) AS avg_total_amount
FROM dbo.yellow_taxi_cleaned;


-- next
SELECT COUNT(*) AS high_total_records
FROM dbo.yellow_taxi_cleaned
WHERE total_amount > 200;


-- next
SELECT
    tpep_pickup_datetime,
    tpep_dropoff_datetime,
    trip_distance,
    fare_amount,
    tip_amount,
    tolls_amount,
    total_amount,
    payment_method
FROM dbo.yellow_taxi_cleaned
WHERE total_amount > 200
ORDER BY total_amount DESC;


-- next
DELETE FROM dbo.yellow_taxi_cleaned
WHERE 
    (tpep_pickup_datetime = '2023-01-01 12:53:41'
     AND tpep_dropoff_datetime = '2023-01-01 12:53:50'
     AND trip_distance < 0.02
     AND fare_amount = 250)
    OR
    (tpep_pickup_datetime = '2023-01-01 02:16:32'
     AND tpep_dropoff_datetime = '2023-01-01 02:21:27'
     AND trip_distance = 0.6
     AND tip_amount = 211.5);



DELETE FROM dbo.yellow_taxi_cleaned
WHERE tpep_pickup_datetime = '2023-01-01 02:16:32'
AND tpep_dropoff_datetime = '2023-01-01 02:21:27'
AND tip_amount = 211.5;


-- next
SELECT
    payment_method,
    COUNT(*) AS negative_fare_records
FROM dbo.yellow_taxi_cleaned
WHERE fare_amount < 0
GROUP BY payment_method;


-- next
SELECT
    MAX(tip_amount) AS maximum_tip,
    AVG(tip_amount) AS average_tip,
    MIN(tip_amount) AS minimum_tip
FROM dbo.yellow_taxi_cleaned;


-- next
SELECT
    tpep_pickup_datetime,
    trip_distance,
    fare_amount,
    tip_amount,
    total_amount,
    payment_method
FROM dbo.yellow_taxi_cleaned
WHERE tip_amount > 50
ORDER BY tip_amount DESC;


-- next
SELECT
    tpep_pickup_datetime,
    tpep_dropoff_datetime,
    trip_distance,
    fare_amount,
    extra,
    mta_tax,
    tip_amount,
    tolls_amount,
    total_amount,
    payment_method
FROM dbo.yellow_taxi_cleaned
WHERE tpep_pickup_datetime = '2023-01-01 02:05:03';


-- next
DELETE FROM dbo.yellow_taxi_cleaned
WHERE tpep_pickup_datetime = '2023-01-01 02:05:03'
AND tpep_dropoff_datetime = '2023-01-01 02:18:58'
AND tip_amount > 99
AND fare_amount = 0;


-- next
SELECT COUNT(*) AS negative_extra_records
FROM dbo.yellow_taxi_cleaned
WHERE extra < 0;


-- next
SELECT
    extra,
    COUNT(*) AS record_count
FROM dbo.yellow_taxi_cleaned
WHERE extra < 0
GROUP BY extra
ORDER BY extra;


-- next
SELECT
    tpep_pickup_datetime,
    tpep_dropoff_datetime,
    trip_distance,
    fare_amount,
    extra,
    mta_tax,
    tip_amount,
    total_amount,
    payment_method
FROM dbo.yellow_taxi_cleaned
WHERE extra < -1
ORDER BY extra;


-- next
SELECT
    payment_method,
    COUNT(*) AS record_count
FROM dbo.yellow_taxi_cleaned
WHERE extra = -1
GROUP BY payment_method;


-- next
SELECT COUNT(*) AS final_cleaned_records
FROM dbo.yellow_taxi_cleaned;


-- next
SELECT COUNT(*) AS zero_duration_records
FROM dbo.yellow_taxi_cleaned
WHERE tpep_pickup_datetime = tpep_dropoff_datetime;







------------------------ Data Analysis

SELECT
    COUNT(*) AS total_trips,
    MIN(tpep_pickup_datetime) AS first_pickup,
    MAX(tpep_pickup_datetime) AS last_pickup
FROM dbo.yellow_taxi_cleaned;


-- next
SELECT
    FORMAT(tpep_pickup_datetime, 'HH') AS pickup_hour,
    COUNT(*) AS total_trips
FROM dbo.yellow_taxi_cleaned
GROUP BY FORMAT(tpep_pickup_datetime, 'HH')
ORDER BY total_trips DESC;


-- next
SELECT
    CONVERT(DATE, tpep_pickup_datetime) AS pickup_date,
    COUNT(*) AS total_trips
FROM dbo.yellow_taxi_cleaned
GROUP BY CONVERT(DATE, tpep_pickup_datetime)
ORDER BY pickup_date;


-- next
SELECT
    CONVERT(DATE, tpep_pickup_datetime) AS pickup_date,
    COUNT(*) AS total_trips
FROM dbo.sample
GROUP BY CONVERT(DATE, tpep_pickup_datetime)
ORDER BY pickup_date;


-- next
SELECT
    TOP 10
    PULocationID,
    COUNT(*) AS total_trips
FROM dbo.yellow_taxi_cleaned
GROUP BY PULocationID
ORDER BY total_trips DESC;


-- NEXT
SELECT
    AVG(trip_distance) AS avg_distance,
    MIN(trip_distance) AS min_distance,
    MAX(trip_distance) AS max_distance
FROM dbo.yellow_taxi_cleaned;



-- next
SELECT
    AVG(DATEDIFF(MINUTE, tpep_pickup_datetime, tpep_dropoff_datetime)) AS avg_duration,
    MIN(DATEDIFF(MINUTE, tpep_pickup_datetime, tpep_dropoff_datetime)) AS min_duration,
    MAX(DATEDIFF(MINUTE, tpep_pickup_datetime, tpep_dropoff_datetime)) AS max_duration
FROM dbo.yellow_taxi_cleaned;



-- next
SELECT TOP 10
    tpep_pickup_datetime,
    tpep_dropoff_datetime,
    trip_distance,
    DATEDIFF(MINUTE, tpep_pickup_datetime, tpep_dropoff_datetime) AS duration_minutes
FROM dbo.yellow_taxi_cleaned
ORDER BY duration_minutes DESC;


-- next --------------------(Invakid finding)
SELECT
    COUNT(*) AS long_duration_trips
FROM dbo.yellow_taxi_cleaned
WHERE DATEDIFF(MINUTE, tpep_pickup_datetime, tpep_dropoff_datetime) > 180;


SELECT TOP 20
    tpep_pickup_datetime,
    tpep_dropoff_datetime,
    trip_distance,
    DATEDIFF(MINUTE, tpep_pickup_datetime, tpep_dropoff_datetime) AS duration_minutes
FROM dbo.yellow_taxi_cleaned
WHERE DATEDIFF(MINUTE, tpep_pickup_datetime, tpep_dropoff_datetime) > 180
ORDER BY duration_minutes DESC;



SELECT TOP 20
    tpep_pickup_datetime,
    tpep_dropoff_datetime,
    trip_distance,
    DATEDIFF(MINUTE, tpep_pickup_datetime, tpep_dropoff_datetime) AS duration_minutes
FROM dbo.yellow_taxi_cleaned
WHERE DATEDIFF(MINUTE, tpep_pickup_datetime, tpep_dropoff_datetime) > 180
ORDER BY duration_minutes ASC;


DELETE FROM dbo.yellow_taxi_cleaned
WHERE DATEDIFF(MINUTE, tpep_pickup_datetime, tpep_dropoff_datetime) > 180;


SELECT COUNT(*) AS remaining_long_trips
FROM dbo.yellow_taxi_cleaned
WHERE DATEDIFF(MINUTE, tpep_pickup_datetime, tpep_dropoff_datetime) > 180;



-- next
SELECT
    AVG(DATEDIFF(MINUTE, tpep_pickup_datetime, tpep_dropoff_datetime)) AS avg_duration_minutes,
    MIN(DATEDIFF(MINUTE, tpep_pickup_datetime, tpep_dropoff_datetime)) AS min_duration_minutes,
    MAX(DATEDIFF(MINUTE, tpep_pickup_datetime, tpep_dropoff_datetime)) AS max_duration_minutes
FROM dbo.yellow_taxi_cleaned;



-- next
SELECT
    AVG(fare_amount) AS average_fare,
    MIN(fare_amount) AS minimum_fare,
    MAX(fare_amount) AS maximum_fare
FROM dbo.yellow_taxi_cleaned;


-- next
SELECT
    payment_method,
    COUNT(*) AS total_trips,
    AVG(fare_amount) AS average_fare,
    MIN(fare_amount) AS minimum_fare,
    MAX(fare_amount) AS maximum_fare
FROM dbo.yellow_taxi_cleaned
GROUP BY payment_method
ORDER BY total_trips DESC;



-- next
SELECT
    payment_method,
    SUM(fare_amount) AS total_fare
FROM dbo.yellow_taxi_cleaned
GROUP BY payment_method


-- next
SELECT
    payment_method,
    COUNT(*) AS total_trips
FROM dbo.yellow_taxi_cleaned
GROUP BY payment_method
ORDER BY total_trips DESC;



-- next
SELECT
    payment_method,
    AVG(total_amount) AS average_total_amount
FROM dbo.yellow_taxi_cleaned
GROUP BY payment_method
ORDER BY average_total_amount DESC;



-- next
SELECT
    FORMAT(tpep_pickup_datetime, 'HH') AS pickup_hour,
    SUM(fare_amount) AS total_fare
FROM dbo.yellow_taxi_cleaned
GROUP BY FORMAT(tpep_pickup_datetime, 'HH')
ORDER BY total_fare DESC;


-- next
SELECT
    payment_method,
    AVG(tip_amount) AS average_tip
FROM dbo.yellow_taxi_cleaned
GROUP BY payment_method
ORDER BY average_tip DESC;


-- next
SELECT TOP 10
    PULocationID,
    COUNT(*) AS total_trips,
    AVG(fare_amount) AS average_fare
FROM dbo.yellow_taxi_cleaned
GROUP BY PULocationID
ORDER BY average_fare DESC;


-- next
SELECT
    PULocationID,
    COUNT(*) AS total_trips,
    AVG(fare_amount) AS average_fare
FROM dbo.yellow_taxi_cleaned
GROUP BY PULocationID
HAVING COUNT(*) >= 50
ORDER BY average_fare DESC;



-- next
SELECT
    CASE
        WHEN trip_distance <= 5 THEN '0-5 Miles'
        WHEN trip_distance <= 10 THEN '5-10 Miles'
        WHEN trip_distance <= 20 THEN '10-20 Miles'
        ELSE 'Above 20 Miles'
    END AS distance_range,
    COUNT(*) AS total_trips,
    AVG(fare_amount) AS average_fare
FROM dbo.yellow_taxi_cleaned
GROUP BY
    CASE
        WHEN trip_distance <= 5 THEN '0-5 Miles'
        WHEN trip_distance <= 10 THEN '5-10 Miles'
        WHEN trip_distance <= 20 THEN '10-20 Miles'
        ELSE 'Above 20 Miles'
    END;



-- next  
SELECT
    CASE
        WHEN trip_distance <= 5 THEN '0-5 Miles'
        WHEN trip_distance <= 10 THEN '5-10 Miles'
        WHEN trip_distance <= 20 THEN '10-20 Miles'
        ELSE 'Above 20 Miles'
    END AS distance_range,
    COUNT(*) AS total_trips,
    AVG(DATEDIFF(MINUTE, tpep_pickup_datetime, tpep_dropoff_datetime)) AS average_duration
FROM dbo.yellow_taxi_cleaned
GROUP BY
    CASE
        WHEN trip_distance <= 5 THEN '0-5 Miles'
        WHEN trip_distance <= 10 THEN '5-10 Miles'
        WHEN trip_distance <= 20 THEN '10-20 Miles'
        ELSE 'Above 20 Miles'
    END;



-- next
SELECT TOP 10 *
FROM dbo.yellow_taxi_cleaned
ORDER BY fare_amount DESC;