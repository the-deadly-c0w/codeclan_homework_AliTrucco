
-- 1

SELECT *
FROM employees 
WHERE department = 'Human Resources';



--2

select first_name, last_name, country
from employees 
where department = 'Legal';


--3


SELECT count(*)
FROM employees 
WHERE country = 'Portugal';



--4

SELECT count(*)
FROM employees 
WHERE country = 'Portugal' OR country = 'Spain';



--5


SELECT count(*)
FROM pay_details
WHERE local_account_no IS NULL;



--6





--7

SELECT first_name, last_name
FROM employees
ORDER BY last_name ASC NULLS LAST;


-- 8 

select first_name, last_name, country
from employees 
ORDER BY country ASC NULLS LAST, last_name ASC NULLS LAST;


-- 9

SELECT *
FROM employees
ORDER BY salary DESC
LIMIT 10;



-- 10 


SELECT first_name, last_name, salary
FROM employees 
WHERE country = 'Hungary'
ORDER BY salary ASC NULLS LAST 
LIMIT 1;


-- 11

SELECT count(first_name)
FROM employees 
WHERE first_name ~ '^F'


-- 12

SELECT *
FROM employees 
WHERE email ~ '...yahoo';



-- 13


SELECT count(*)
FROM employees 
WHERE country NOT IN ('France', 'German') AND pension_enrol = TRUE;




-- 14


SELECT *
FROM employees 
WHERE department = 'Engineering' AND fte_hours = 1
ORDER BY salary DESC NULLS LAST 
LIMIT 1;


-- 15

SELECT first_name, last_name, salary, fte_hours,
	salary * fte_hours AS effective_yearly_salary 
FROM employees
ORDER BY effective_yearly_salary DESC NULLS LAST;


-- 16

SELECT first_name, last_name, department, 
	concat(first_name, ' ', last_name, ' - ', department) AS badge_label
FROM employees
WHERE first_name IS NOT NULL
	AND last_name IS NOT NULL
	AND department IS NOT NULL;


-- 17

SELECT first_name, last_name, department, 
	concat(first_name, ' ', last_name, ' - ', department, ' (joined ', EXTRACT(YEAR FROM start_date), ')') AS badge_label
FROM employees
WHERE first_name IS NOT NULL
	AND last_name IS NOT NULL
	AND department IS NOT NULL
	AND start_date IS NOT NULL;

-- 18

SELECT first_name, last_name, salary,
	CASE 
		WHEN salary < 40000 THEN 'low'
		WHEN salary >= 40000 THEN 'high'
	END
	AS salary_class
FROM employees