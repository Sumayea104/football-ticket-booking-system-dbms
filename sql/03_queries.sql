-- Query 1: Retrieve all upcoming football matches belonging to 'Champions League' and 'Available'
SELECT match_id, fixture, base_ticket_price
FROM Matches
WHERE tournament_category = 'Champions League' 
  AND match_status = 'Available';


-- Query 2: Search for users whose full names start with 'Tanvir' or contain 'Haque' (case-insensitive)
SELECT user_id, full_name, email
FROM Users
WHERE LOWER(full_name) LIKE 'tanvir%' 
   OR LOWER(full_name) LIKE '%haque%';


-- Query 3: Retrieve booking records where payment status is missing, replacing it with 'Action Required'
SELECT booking_id, user_id, match_id, 
       COALESCE(payment_status, 'Action Required') AS systematic_status
FROM Bookings
WHERE payment_status IS NULL;


-- Query 4: Retrieve match booking details along with User's full name and scheduled Match fixture teams
SELECT b.booking_id, u.full_name, m.fixture, b.total_cost
FROM Bookings b
INNER JOIN Users u ON b.user_id = u.user_id
INNER JOIN Matches m ON b.match_id = m.match_id;


-- Query 5: Comprehensive list of all users and their booking IDs, including users with no bookings
SELECT u.user_id, u.full_name, b.booking_id
FROM Users u
LEFT JOIN Bookings b ON u.user_id = b.user_id;


-- Query 6: Find all ticket bookings where the total cost is strictly higher than the average cost
SELECT booking_id, match_id, total_cost
FROM Bookings
WHERE total_cost > (SELECT AVG(total_cost) FROM Bookings);


-- Query 7: Retrieve the top 2 most expensive matches sorted by base price, skipping the absolute highest
SELECT match_id, fixture, base_ticket_price
FROM Matches
ORDER BY base_ticket_price DESC
LIMIT 2 OFFSET 1;