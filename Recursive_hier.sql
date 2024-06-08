--Recursive Hierarchy
WITH RECURSIVE EmployeeHierarchy AS (
    SELECT 
        employee_id,
        manager_id,
        employee_name,
        1 AS level
    FROM 
        employees
    WHERE 
        manager_id IS NULL
    UNION ALL
    SELECT 
        e.employee_id,
        e.manager_id,
        e.employee_name,
        eh.level + 1
    FROM 
        employees e
    INNER JOIN 
        EmployeeHierarchy eh ON e.manager_id = eh.employee_id
)
SELECT 
    employee_id,
    manager_id,
    employee_name,
    level
FROM 
    EmployeeHierarchy
ORDER BY 
    level, employee_id;
