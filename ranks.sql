SELECT ROW_NUMBER() OVER(ORDER BY date_time) AS rank,
       date_time
FROM   db;