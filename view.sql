
/* JOINS*/
CREAT VIEW<V1>
AS
SELECT s.name AS Rep_Name,  R.name AS Region_Name,S.id
FROM sales_reps S
JOIN region R
ON S.region_id = R.id
AND R.name = 'Northeast'

CREAT VIEW <V2>
AS
SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_reps_id= s.id
JOIN orders
ON o.account_id = a.id 

CREAT VIEW 3
CREATE VIEW V3
AS
SELECT channel, AVG(events) AS average_events
FROM (SELECT DATE_TRUNC('day',occurred_at) AS day,
                channel, COUNT(*) as events
         FROM web_events 
         GROUP BY 1,2) sub
GROUP BY channel