-- 1. Query to create a flight_routes table.
-- This table stores details about flight routes, including route ID, flight number, departure and arrival airports, plane ID, and distance.
CREATE TABLE flight_routes (
    route_id INT PRIMARY KEY, -- Unique identifier for each route
    flight_number VARCHAR(10) NOT NULL, -- Flight number, must start with 'FL'
    departure_airport VARCHAR(50) NOT NULL, -- Airport where the flight departs
    arrival_airport VARCHAR(50) NOT NULL, -- Airport where the flight arrives
    plane_id INT, -- ID of the aircraft used for the route
    distance_in_miles DECIMAL(10,2), -- Distance between departure and arrival airports in miles
    CONSTRAINT chk_flight_number CHECK (flight_number LIKE 'FL%'), -- Ensures flight number starts with 'FL'
    CONSTRAINT chk_distance_in_miles CHECK (distance_in_miles > 0) -- Ensures distance is greater than 0
);

-- 2. Query to display passengers who traveled on routes 1 to 25.
-- Retrieves all passengers who traveled on routes with IDs between 1 and 25.
SELECT *
FROM flight_passengers
WHERE route_id BETWEEN 1 AND 25;

-- 3. Query to identify the number of passengers and total revenue in business class.
-- Calculates the total number of passengers and revenue generated from business class tickets.
SELECT COUNT(*) AS passenger_count, -- Counts the number of passengers
       SUM(ticket_price * tickets_booked) AS total_revenue -- Calculates total revenue
FROM ticket_bookings
WHERE class_type = 'Business'; -- Filters records for business class only

-- 4. Query to display full names of travelers.
-- Concatenates the first and last names of travelers to display their full names.
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM travelers;

-- 5. Query to extract registered travelers who have booked a ticket.
-- Retrieves all travelers who have booked a ticket by joining the travelers and ticket_bookings tables.
SELECT *
FROM travelers t
INNER JOIN ticket_bookings b ON t.traveler_id = b.traveler_id;

-- 6. Query to identify traveler's first and last names based on their traveler ID and airline brand.
-- Retrieves the first and last names of travelers who booked tickets with the airline brand 'Emirates'.
SELECT t.first_name, t.last_name
FROM travelers t
INNER JOIN ticket_bookings b ON t.traveler_id = b.traveler_id
WHERE b.airline_brand = 'Emirates';

-- 7. Query to identify travelers who have traveled in Economy Plus class.
-- Retrieves the IDs of travelers who have traveled in the 'Economy Plus' class.
SELECT traveler_id
FROM flight_passengers
WHERE class_type = 'Economy Plus'
GROUP BY traveler_id
HAVING COUNT(*) > 0;

-- 8. Query to check if revenue has exceeded $10,000.
-- Checks if the total revenue from all ticket bookings exceeds $10,000.
SELECT IF(SUM(ticket_price * tickets_booked) > 10000, 'Yes', 'No') AS revenue_exceeded_10000
FROM ticket_bookings;

-- 9. Query to create and grant access to a new database user.
-- Creates a new database user and grants them full privileges on all databases and tables.
CREATE USER 'db_user'@'localhost' IDENTIFIED BY 'secure_password';
GRANT ALL PRIVILEGES ON *.* TO 'db_user'@'localhost';

-- 10. Query to find the maximum ticket price for each class using window functions.
-- Calculates the maximum ticket price for each class type using a window function.
SELECT class_type, 
       MAX(ticket_price) OVER(PARTITION BY class_type) AS max_ticket_price
FROM ticket_bookings;

-- 11. Query to extract passengers who traveled on route ID 4.
-- Retrieves all passengers who traveled on the route with ID 4.
SELECT *
FROM flight_passengers
WHERE route_id = 4;

-- 12. Query to view the execution plan for the flight_passengers table for route ID 4.
-- Provides the execution plan for the query retrieving passengers on route ID 4.
EXPLAIN SELECT * FROM flight_passengers WHERE route_id = 4;

-- 13. Query to calculate the total price of all tickets booked by a traveler across different plane IDs using the ROLLUP function.
-- Calculates the total price of tickets booked by each traveler for each plane, with subtotals and a grand total.
SELECT traveler_id, 
       plane_id, 
       SUM(ticket_price * tickets_booked) AS total_price
FROM ticket_bookings
GROUP BY traveler_id, plane_id WITH ROLLUP;

-- 14. Query to create a view for business class travelers along with the airline brand.
-- Creates a view containing details of travelers who booked tickets in the 'Business' class, along with the airline brand.
CREATE VIEW business_class_travelers AS
SELECT t.*, b.airline_brand
FROM travelers t
INNER JOIN ticket_bookings b ON t.traveler_id = b.traveler_id
WHERE b.class_type = 'Business';
