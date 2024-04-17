SELECT *
FROM Appointment
ORDER BY date, time;

SELECT customer_id, SUM(amount) AS total_spent
FROM Payment
GROUP BY customer_id
HAVING total_spent > 50;

SELECT *
FROM Appointment
WHERE customer_id = 4
    LIMIT 5;