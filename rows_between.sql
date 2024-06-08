--Cumulative
SELECT 
    transaction_date,
    transaction_amount,
    SUM(transaction_amount) OVER (ORDER BY transaction_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum
FROM 
    transactions
ORDER BY 
    transaction_date
--Moving Average
SELECT 
    transaction_date,
    transaction_amount,
    AVG(transaction_amount) OVER (ORDER BY transaction_date ROWS BETWEEN 4 PRECEDING AND CURRENT ROW) AS moving_average
FROM 
    transactions
ORDER BY 
    transaction_date
