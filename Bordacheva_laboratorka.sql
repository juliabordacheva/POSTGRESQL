
---1 запрос Вывести список названий департаментов и количество главных врачей в каждом из этих департаментов

(SELECT
   department.name,
   COUNT (DISTINCT chief_doc_id) as chief_doc_count

FROM department, employee
WHERE
 department.id = employee.department_id
 GROUP BY department.name);



---2 запрос Вывести список департаментов, в которых работают 3 и более сотрудников (id и название департамента, количество сотрудников)
 (
   SELECT
      department.id,
      department.name,
      COUNT (employee.id) as chief_doc_count
   FROM department
     LEFT JOIN employee
     ON department.id = employee.department_id
     GROUP BY department.id, department.name
     HAVING COUNT (employee.id) >=3
   );


----3 запрос Вывести список департаментов с максимальным количеством публикаций  (id и название департамента, количество публикаций)

   WITH department_public AS

   (
   SELECT
      department.id,
      department.name,
      SUM(employee.num_public) as total_public_num
   FROM department
     JOIN employee
     ON department.id = employee.department_id
     GROUP BY department.id, department.name
     ORDER BY total_public_num DESC
   )
SELECT * FROM
department_public WHERE total_public_num = (
  SELECT total_public_num FROM department_public LIMIT 1
     );
 ----- 4 запрос Вывести список сотрудников с минимальным количеством публикаций в своем департаменте (id и название департамента, имя сотрудника, количество публикаций)
  WITH mp AS (
	SELECT
  		MIN(employee.num_public) AS num_public,
  		employee.department_id
	FROM employee
	GROUP BY employee.department_id
)
SELECT department.id, department.name, employee.name, employee.num_public FROM mp
FULL OUTER JOIN employee ON employee.num_public = mp.num_public
JOIN department ON department.id = employee.department_id
WHERE department.id = mp.department_id AND employee.num_public = mp.num_public
ORDER BY department.id;


----5 запрос Вывести список департаментов и среднее количество публикаций для тех департаментов, в которых работает более одного главного врача (id и название департамента, среднее количество публикаций)

SELECT
	department.id,
	department.name,
	AVG(employee.num_public) AS avg
FROM department
JOIN employee  ON department.id = employee.department_id
GROUP BY department.id, department.name
HAVING COUNT(DISTINCT(employee.chief_doc_id)) > 1;


