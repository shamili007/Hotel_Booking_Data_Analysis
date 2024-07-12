-- Hotel_Booking_Analysis

DROP TABLE IF EXISTS bookings;

CREATE TABLE bookings (
    booking_id INT,
    booking_date DATE,
    hotel VARCHAR(50),
    is_canceled INT,
    adults INT,
    children INT,
    meal VARCHAR(25),
    country VARCHAR(23),
    market_segment VARCHAR(20),
    deposit_type VARCHAR(20),
    agent INT,
    price FLOAT,
    required_car_parking_spaces INT,
    reservation_status VARCHAR(25),
    name VARCHAR(50),
    email VARCHAR(50),
	stays_in_weekend_nights INT
);

SELECT COUNT(*) total_booking
FROM bookings;

-----------------

SELECT
	booking_id,
	country,
	price,
	ROW_NUMBER() OVER(ORDER BY price DESC) as rownumber,
	RANK() OVER(ORDER BY price DESC) as rank,
	DENSE_RANK() OVER(ORDER BY price DESC) as d_rank
FROM bookings
WHERE price IS NOT NULL;

--------------------

-- Q1. Find the customers who have made more than 5 orders and the total number of orders they have made.

SELECT * FROM bookings;

SELECT
	name,
	COUNT(booking_id) as total_orders
FROM bookings
GROUP BY name
HAVING COUNT(booking_id) > 5;

-- Identifying Duplicates

SELECT
	*
FROM
	(SELECT *,
		ROW_NUMBER() OVER(PARTITION BY booking_id ORDER BY booking_id) as rn
		FROM bookings
	) as subquery
WHERE rn = 1;

-- Views
-- Views are used if we do not want to share the complete data to someone
-- We can create views and show only the data that we want to show them

-- Below is the query to create a view where only the bookings from India are available

CREATE VIEW booking_view_ind
AS
SELECT
	*
FROM bookings
WHERE country = 'IND';

SELECT * FROM booking_view_ind;

-- If we want to share only few columns from booking view ind

DROP VIEW IF EXISTS booking_view_ind;

CREATE VIEW booking_view_ind
AS
SELECT
	booking_id,
	booking_date,
	price,
	agent
FROM bookings
WHERE country = 'IND';

-- Removing duplicates by creating a view

CREATE VIEW booking_view
AS
	SELECT
	*
FROM
	(SELECT *,
		ROW_NUMBER() OVER(PARTITION BY booking_id ORDER BY booking_id) as rn
		FROM bookings
	) as subquery
WHERE rn = 1
;

SELECT * FROM booking_view;

-- Replacing null values in price with Avg of price

SELECT
	booking_id,
	booking_date,
	hotel,
	COALESCE(price, (SELECT AVG(price) FROM booking_view))
FROM booking_view;

-----------

-- CTE(Common Table Expression) is like a temporary table

WITH booking_ind
AS
(
SELECT * FROM bookings
WHERE country = 'IND'
)

SELECT COUNT(*) FROM booking_ind;

------------------------------

-- Q2. Identify the number of unique hotels present in the dataset.

SELECT * FROM bookings;

SELECT
	DISTINCT(hotel)
FROM bookings;

--OR

SELECT * FROM
(
	SELECT *,
		ROW_NUMBER() OVER(PARTITION BY hotel ORDER BY hotel) rn
	FROM bookings
)
	WHERE rn = 1;

-- Q3. List all the distinct market segments represented in the bookings.

SELECT
	DISTINCT(market_segment)
FROM bookings;

--OR

SELECT * FROM
(
	SELECT *,
		ROW_NUMBER() OVER(PARTITION BY market_segment ORDER BY market_segment) rn
	FROM bookings
)
	WHERE rn = 1;

--Q4. Count the number of bookings with NULL values for both the 'children' and 'meal' columns

SELECT 
  COUNT(*)
FROM 
  bookings
WHERE 
  children IS NULL 
  AND meal IS NULL;

--Q5. Create a new column 'booking_period' categorizing bookings as 'Weekend' 
-- if stays_in_weekend_nights > 0, otherwise 'Weekday'.

SELECT
	CASE
		WHEN stays_in_weekend_nights > 0 THEN 'weekend'
		ELSE 'weekday'
	END as booking_period
FROM bookings;

--Q6. Classify the bookings as 'High Price' if the price is greater than the average price,
-- otherwise 'Low Price'

SELECT * FROM bookings;

SELECT
	CASE
		WHEN price > (SELECT AVG(price) FROM bookings) THEN 'High Price'
		ELSE 'Low Price'
	END as booking_price_type
FROM bookings;

-- INDEX IN SQL
--Q7. Create INDEX on COUNTRY column and Do Explain and Analyze 

CREATE INDEX index_country ON bookings (COUNTRY);

EXPLAIN ANALYZE -- to see query performance
SELECT * FROM bookings
WHERE COUNTRY = 'IND'

EXPLAIN ANALYZE 
SELECT * FROM bookings;

--Q8. Determine the average number of adults per booking for each hotel.

SELECT 
	AVG(adults) AS avg_adults
FROM bookings
GROUP BY hotel;

--Q9. Identify the countries with an average booking price exceeding $200.

SELECT
	country,
	AVG(price) as avg_booking_price
FROM bookings
GROUP BY country
HAVING AVG(price) > 200;

--Q10. Rank the bookings based on the 'booking_date' in ascending order.

SELECT
	booking_id,
	booking_date,
	ROW_NUMBER() OVER(ORDER BY booking_date) as rn,
	RANK() OVER(ORDER BY booking_date) as r,
	DENSE_RANK() OVER(ORDER BY booking_date) as dr
FROM bookings;

--Q11. Calculate the dense rank of bookings based on the 'country' column.

SELECT
	booking_id,
	country,
	DENSE_RANK() OVER(PARTITION BY country ORDER BY country) as dr
FROM bookings;

--Q12. Find all email addresses containing 'gmail.com'.

SELECT email
FROM bookings
WHERE email LIKE '%gmail.com';

--Q13. Identify bookings with names starting with 'A'.

SELECT 
	*
FROM bookings
WHERE name LIKE 'A%';

--Q14. Calculate the total price generated from bookings.

SELECT SUM(price) as total_price FROM bookings;

--Q15. Determine the minimum and maximum number of required car parking spaces across all bookings

SELECT 
	MIN(required_car_parking_spaces),
	MAX(required_car_parking_spaces)
FROM bookings;

--Q16. Find the average price of bookings for each combination of 'hotel' and 'meal'.

SELECT 
	hotel,
	meal, 
	AVG(price) AS average_price
FROM bookings
GROUP BY hotel, meal;

--Q17. Count the number of bookings where the number of adults is greater than 
-- the average number of adults across all bookings.

SELECT
	COUNT(*)
FROM bookings
WHERE adults > (SELECT AVG(adults) FROM bookings);

-- Additional Analysis Questions
--Q1. What is the overall cancellation rate for hotel bookings?

SELECT 
  AVG(CASE WHEN is_canceled = 1 THEN 1.0 ELSE 0.0 END) * 100 AS cancellation_rate
FROM 
  bookings;

--Q2. Which countries are the top contributors to hotel bookings?

SELECT
	COUNT(booking_id) AS num_bookings,
	country
FROM bookings
GROUP BY country
ORDER BY num_bookings DESC
LIMIT 10;

--Q3. What are the main market segments booking the hotels, such as leisure or corporate?

SELECT
	market_segment,
	COUNT(booking_id) AS num_bookings
FROM bookings
GROUP BY market_segment
ORDER BY num_bookings DESC
LIMIT 10;

--Q4. What percentage of bookings require car parking spaces?

SELECT 
  COUNT(CASE WHEN required_car_parking_spaces = 1 THEN 1 ELSE NULL END) AS num_bookings_with_parking,
  COUNT(*) AS total_bookings,
  ROUND(COUNT(CASE WHEN required_car_parking_spaces = 1 THEN 1 ELSE NULL END) / COUNT(*) * 100, 2) AS percentage_with_parking
FROM 
  bookings;