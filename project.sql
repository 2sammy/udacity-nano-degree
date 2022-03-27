/* Query 1 */
/* Query 1 returns each categories in the family friendly collections and their corresponding total rental count */

SELECT
    category_name,
    SUM(rental_count) AS count_sum
FROM
(
        SELECT
            film_title,
            category_name,
            COUNT(rent) AS rental_count
        FROM
(
                SELECT
                    f.title AS film_title,
                    c.name AS category_name,
                    r.rental_id AS rent
                FROM
                    category AS c
                    JOIN film_category AS fc ON c.category_id = fc.category_id
                    JOIN film AS f ON f.film_id = fc.film_id
                    JOIN inventory AS i ON i.film_id = f.film_id
                    JOIN rental AS r ON r.inventory_id = i.inventory_id
                WHERE
                    c.name in (
                        'Animation',
                        'Children',
                        'Classics',
                        'Comedy',
                        'Family',
                        'Music'
                    )
            ) sub
        GROUP BY
            1,
            2
        ORDER BY
            category_name,
            film_title
    ) AS T4
GROUP BY
    1
ORDER BY
    2;
     

/* Query 2 */
/* This query returns the classifications of all the movies category in family friendly collection based on their watch time(duration) */

SELECT
    DISTINCT(filmlen_groups),
    COUNT(title) OVER (PARTITION BY filmlen_groups) AS filmcount_bylencategory
FROM
    (
        SELECT
            title,
            length,
            CASE
                WHEN length <= 60 THEN '1 hour or less'
                WHEN length > 60
                AND length <= 120 THEN 'Between 1-2 hours'
                WHEN length > 120
                AND length <= 180 THEN 'Between 2-3 hours'
                ELSE 'More than 3 hours'
            END AS filmlen_groups
        FROM
            film
    ) t1
ORDER BY
    filmlen_groups;


/* Querry 3 */
/* This querry returns total number of rental made by each store for the two buainess year provided. */

SELECT
    rental_year,
    store_id,
    SUM(count_rentals) as rental_sum
FROM
    (
        SELECT
            DATE_PART('month', r.rental_date) AS Rental_month,
            DATE_PART('year', r.rental_date) AS Rental_year,
            s.store_id AS store_id,
            COUNT(*) AS Count_rentals
        FROM
            store AS s
            JOIN staff AS st ON st.store_id = s.store_id
            JOIN rental AS r ON r.staff_id = st.staff_id
        GROUP BY
            1,
            2,
            3
        ORDER BY
            4 DESC
    ) AS T6
GROUP BY
    1,
    2
ORDER BY
    2,
    1;


/* Query 4 */
/* This query returns top 10 paying customers of the DVD rental Enterprise and the number of times they made the payments. */

SELECT
    T1.full_name AS full_name,
    T1.pay_amount AS pay_amount,
    pay_countpermon
FROM
    (
        SELECT
            c.first_name || ' ' || c.last_name AS full_name,
            DATE_TRUNC ('month', p.payment_date) AS pay_mon,
            COUNT(*) AS pay_countpermon,
            SUM(p.amount) AS pay_amount
        FROM
            payment AS p
            JOIN customer AS c ON p.customer_id = c.customer_id
        GROUP BY
            1,
            2
    ) AS T1
    INNER JOIN (
        SELECT
            c.first_name || ' ' || c.last_name AS full_name,
            SUM(p.amount) AS pay_amount
        Ff
            payment AS p
            JOIN customer AS c ON p.customer_id = c.customer_id
        GROUP BY
            1
        ORDER BY
            2 DESC
        LIMIT
            10
    ) AS T2 ON T1.full_name = T2.full_name
ORDER BY
    2 DESC
LIMIT
    10; 