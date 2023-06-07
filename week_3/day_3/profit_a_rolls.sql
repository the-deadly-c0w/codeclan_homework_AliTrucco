



-------- 1 

SELECT count(id)
FROM employees
WHERE grade IS NULL AND salary IS NULL 


-------- 2

SELECT 
	department,
	concat(first_name, ' ', last_name)
FROM employees
ORDER BY department, last_name;


------- 3

SELECT 
	concat(first_name, ' ', last_name),
	salary
FROM employees
WHERE last_name ~ ('^A')
ORDER BY salary DESC NULLS LAST
LIMIT 10;


------- 4

SELECT 
	department,
	count(id) AS n_start_2003
FROM employees
WHERE start_date BETWEEN '2003-01-01' AND '2003-12-31'
GROUP BY department



------- 5

SELECT 
	department,
	fte_hours,
	count(id)
FROM employees
GROUP BY fte_hours, department
ORDER BY department ASC, fte_hours ASC;



------- 6


SELECT 
	pension_enrol,
	count(id)
FROM employees
GROUP BY pension_enrol




------- 7

SELECT 
	*
FROM employees
WHERE pension_enrol = FALSE 
ORDER BY salary DESC NULLS LAST
LIMIT 1;


------ 8

-- Get a table of country, number of employees in that country,
-- and the average salary of employees in that country for any countries
-- in which more than 30 employees are based. Order the table by average salary descending.


SELECT 
	country,
	count(id),
	round(avg(salary), 2)
FROM employees
GROUP BY country
HAVING count(id) > 30
ORDER BY avg(salary) DESC;


------ 9 


-- Return a table containing each employees first_name, last_name, 
-- full-time equivalent hours (fte_hours), salary, and a new column effective_yearly_salary 
-- which should contain fte_hours multiplied by salary. Return only rows where effective_yearly_salary
-- is more than 30000.


SELECT 
	first_name,
	last_name,
	fte_hours,
	salary,
	fte_hours * salary AS effective_yearly_salary
FROM employees
WHERE fte_hours * salary > 30000;



------- 10



SELECT 
	e.*,
	t.name
FROM employees AS e 
	INNER JOIN teams AS t
	ON t.id = e.team_id
WHERE t.name IN ('Data Team 1', 'Data Team 2');



--------- 11



SELECT 
	e.first_name,
	e.last_name,
	pd.local_tax_code
FROM employees AS e 
	INNER JOIN pay_details AS pd
	ON pd.id = e.pay_detail_id
WHERE pd.local_tax_code IS NULL;



--------- 12


SELECT 
	e.first_name,
	e.last_name,
	(48 * 35 * CAST(charge_cost AS int) - salary) * fte_hours AS expected_profit
FROM employees AS e 
	INNER JOIN teams AS t
	ON t.id = e.team_id;

	
--------- 13

WITH least_common_hours as(
SELECT
	fte_hours
FROM employees
GROUP BY fte_hours
ORDER BY count(id)
LIMIT 1
)
SELECT 
	first_name,
	last_name,
	salary
FROM employees
WHERE country ='Japan' 
	AND fte_hours =(SELECT "fte_hours" FROM least_common_hours)
ORDER BY salary
LIMIT 1;

	
	
----------- 14

SELECT 
	department,
	count(first_name IS NULL)
FROM employees
GROUP BY department
HAVING count(first_name IS NULL) >= 2
ORDER BY count(first_name IS NULL) DESC,
department;
	

----------- 15

SELECT 
	first_name,
	count(first_name)
FROM employees
GROUP BY first_name
HAVING count(first_name) > 1
ORDER BY count(first_name) DESC, first_name ASC;


----------- 16

SELECT 
	department,
	CAST(sum(grade) AS REAL)/ count(id) AS proportion
FROM employees
GROUP BY department;

----- 16 again for all grade types

SELECT 
	department,
	sum(cast(grade = 1 AS int))/ CAST(count(id) AS REAL) AS proportion
FROM employees
GROUP BY department