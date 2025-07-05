CREATE DATABASE assesment;
USE assesment;
-- City Table
CREATE TABLE city (
    id INT PRIMARY KEY,
    city_name VARCHAR(100),
    lat FLOAT,
    long  FLOAT,
    country_id INT
);

-- Customer Table
CREATE TABLE customer (
    id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city_id INT,
    customer_address VARCHAR(255),
    next_call_date DATE,
    ts_inserted DATETIME
);

-- Country Table
CREATE TABLE country (
    id INT PRIMARY KEY,
    country_name VARCHAR(100),
    country_name_eng VARCHAR(100),
    country_code VARCHAR(10)
);

-- Insert into city table
INSERT INTO city (id, city_name, lat, long, country_id) VALUES
(1, 'Berlin', 52.520008, 13.404954, 1),
(2, 'Belgrade', 44.787197, 20.457273, 2),
(3, 'Zagreb', 45.815399, 15.961328, 3),
(4, 'New York', 40.730610, -73.935242, 4),
(5, 'Los Angeles', 34.052235, -118.243683, 4),
(6, 'Warsaw', 52.237049, 21.017532, 5);

-- Insert into customer table
INSERT INTO customer (id, customer_name, city_id, customer_address, next_call_date, ts_inserted) VALUES
(1, 'Jewelry Store', 4, 'Long Street 120', '2020-01-21', '2020-01-09 14:01:20.000'),
(2, 'Bakery', 1, 'Kurfürstendamm 25', '2020-01-21', '2020-01-09 17:52:15.000'),
(3, 'Café', 1, 'Tauentzienstraße 44', '2020-01-21', '2020-01-10 08:42:09.000'),
(4, 'Restaurant', 3, 'Ulica lipa 15', '2020-01-21', '2020-01-10 09:20:21.000');

-- Insert into country table
INSERT INTO country (id, country_name, country_name_eng, country_code) VALUES
(1, 'Deutschland', 'Germany', 'DEU'),
(2, 'Srbija', 'Serbia', 'SRB'),
(3, 'Hrvatska', 'Croatia', 'HRV'),
(4, 'United States of America', 'United States of America', 'USA'),
(5, 'Polska', 'Poland', 'POL'),
(6, 'España', 'Spain', 'ESP'),
(7, 'Rossiya', 'Russia', 'RUS');



SELECT 
    co.country_name_eng AS country_name,
    ci.city_name,
    cu.customer_name
FROM 
    country co
LEFT JOIN city ci ON co.id = ci.country_id
LEFT JOIN customer cu ON ci.id = cu.city_id;

SELECT 
    co.country_name_eng AS country_name,
    ci.city_name,
    cu.customer_name
FROM 
    country co
INNER JOIN city ci ON co.id = ci.country_id
LEFT JOIN customer cu ON ci.id = cu.city_id;


