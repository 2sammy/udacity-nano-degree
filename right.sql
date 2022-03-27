SELECT channel,
AVG(event_count) AS avg_event_count
FROM {
    SELECT DATE_TRUNC("Day " , occurred_at) AS Day,
    channel, COUNT(*) AS event_count
    FROM web_events
    GROUP BY 1, 2
}sub
GROUP BY 1
ORDER BY 2 DESC

SELECT channel, AVG(events) AS avg_event_count
(SELECT DATE_TRUNC('day', occurred_at) AS day,
channel, COUNT(*) AS events
FROM web_events
GROUP BY 1,2
) sub
GROUP BY 1
ORDER BY 2

SELECT *
FROM (SELECT DATE_TRUNC('day' occurred_at) AS day,
channel, COUNT(*) AS events
FROM web_events
GROUP by 1
ORDER BY 2)

SELECT *
FROM(
    SELECT DATE_TRUNC('day', occurred_at) AS day,
    channel, COUNT(*) AS events
    FROM web_events
    GROUP BY 1,2
    ORDER BY 3 DESC
)sub
GROUP BY 1, 2, 3
ORDER BY 2 DESC;

SELECT*
FROM orders
WHERE DATE_TRUNC('month', occurred_at)=
(SELECT DATE_TRUNC('month', MIN(occurred_at)) AS mean_month
FROM orders )
ORDER BY occurred_at
GROUP by 1

SELECT T1.name, MAX(T1.COUNT)
FROM(
SELECT accounts.name, web_events.channel,COUNT(*)
FROM accounts
JOIN web_events
ON web_events.account_id= accounts.id
GROUP BY accounts.name,web_events.channel
ORDER BY accounts.name, COUNT(*)) AS TI
GROUP BY 1