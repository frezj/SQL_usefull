--Percent of Grand Total
SELECT 
    department_id,
    employee_id,
    salary,
    ROUND(100.0 * salary / SUM(salary) OVER (PARTITION BY department_id), 2) AS salary_percentage
FROM 
    employees
ORDER BY 
    department_id, salary DESC;
