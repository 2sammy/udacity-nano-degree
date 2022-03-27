select first_name,
last_name,
phone_number,
    LEFT(phone_number, 3) AS area_code
    RIGHT(phone_number, 7) AS phone_number
    RIGHT(phone_number, LENGHT(phone_number)-4) AS length_code
    FROM customer_data

SELECT name,
LEFT(name, STRIPOS)

/*CONCAT: Adds two or more expressions togethe */
CONCAT(month, '-', day, '-', year) AS date