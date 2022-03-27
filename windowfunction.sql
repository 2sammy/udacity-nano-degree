SELECT standard_amt_usd,
SUM(standard_amt_usd) OVER 
(PARTION BY(DATE_TRUNC'year', occurred_at) ORDER BY occurred_at ) AS running_total
FROM orders

SELECT standard_amt_usd,
       DATE_TRUNC('year', occurred_at) as year,
       SUM(standard_amt_usd) OVER (PARTITION BY DATE_TRUNC('year', occurred_at) ORDER BY occurred_at) AS running_total
FROM orders

SELECT id,
       account_id,
       standard_qty,
       DATE_TRUNC('month', occurred_at) AS month,
       DENSE_RANK() OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month', occurred_at)) AS dense_rank,
       SUM(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month', occurred_at)) AS sum_standard_qty,
       COUNT(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month', occurred_at)) AS count_standard_qty,
       AVG(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month', occurred_at)) AS avg_standard_qty,
       MIN(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month', occurred_at)) AS min_standard_qty,
       MAX(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month', occurred_at)) AS max_standard_qty
FROM orders

SELECT id,
       account_id,
       standard_qty,
       DATE_TRUNC('month', occurred_at) AS month,
       DENSE_RANK() OVER (PARTITION BY account_id at) AS dense_rank,
       SUM(standard_qty) OVER (PARTITION BY account_id ) AS sum_std_qty,
       COUNT(standard_qty) OVER (PARTITION BY account_id) AS count_std_qty,
       AVG(standard_qty) OVER (PARTITION BY account_id ) AS avg_std_qty,
       MIN(standard_qty) OVER (PARTITION BY account_id ) AS min_std_qty,
       MAX(standard_qty) OVER (PARTITION BY account_id) AS max_std_qty
FROM orders