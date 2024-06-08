--Cohort Analysis
WITH FirstPurchase AS (
    SELECT 
        customer_id,
        MIN(purchase_date) AS first_purchase_date
    FROM 
        purchases
    GROUP BY 
        customer_id
),
CohortAnalysis AS (
    SELECT 
        p.customer_id,
        p.purchase_date,
        DATE_TRUNC('month', fp.first_purchase_date) AS cohort_month,
        DATE_TRUNC('month', p.purchase_date) AS purchase_month
    FROM 
        purchases p
    JOIN 
        FirstPurchase fp ON p.customer_id = fp.customer_id
)
SELECT 
    cohort_month,
    purchase_month,
    COUNT(DISTINCT customer_id) AS customers_count
FROM 
    CohortAnalysis
GROUP BY 
    cohort_month, purchase_month
ORDER BY 
    cohort_month, purchase_month
