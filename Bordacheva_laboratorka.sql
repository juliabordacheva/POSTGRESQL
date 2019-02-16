(SELECT
   department.name,
   COUNT (DISTINCT chief_doc_id) as chief_doc_count

FROM department, employee
WHERE
 department.id = employee.department_id
 GROUP BY department.name);


 (
   SELECT
      department.id,
      department.name,
      COUNT (employee.id) as chief_doc_count
   FROM department
     LEFT JOIN employee
     ON department.id = employee.department_id
     GROUP BY department.id
     HAVING COUNT (employee.id) >=3
   );



   (
   SELECT
      department.id,
      department.name,
      SUM(num_public) as max_public_num
   FROM department
     LEFT JOIN employee
     ON department.id = employee.department_id
     GROUP BY department.id
     HAVING  MAX(max_public_num)
   );

   SELECT
   department.id, department.name, employee.name, MIN(num_public) as min_public
FROM(
SELECT department_values.id AS department.id, department_values.name AS department.name, employee_values.name as employee, num_public
    FROM department_values
    JOIN employee_values
        ON department_values.id =employee_values.department_id
)as new_table
GROUP BY department.id;




WITH

dep_public as (
department.id, department.name,  SUM (num_public) as Summary
FROM Department
    LEFT JOIN Employee
    ON Department.id=Employee.department_id
    GROUP BY Department.name, Department.id
    ORDER BY Summary DESC)
SELECT
     Department.id,
    Department.Name,
     Summary
FROM dep_public
    where


