

---- 1

SELECT 
	e.first_name,
	e.last_name,
	t.name
FROM employees AS e
	INNER JOIN teams AS t
	ON t.id = e.team_id;



--------- b 

SELECT 
	e.first_name,
	e.last_name,
	t.name
FROM employees AS e
	INNER JOIN teams AS t
	ON t.id = e.team_id
WHERE e.pension_enrol = TRUE;





-----    c

SELECT 
	e.first_name,
	e.last_name,
	t.name AS team_name,
	t.charge_cost
FROM employees AS e
	INNER JOIN teams AS t
	ON t.id = e.team_id
WHERE CAST(t.charge_cost AS int) > 80;











-------   2


SELECT 
	e.*,
	pd.local_account_no,
	pd.local_sort_code
FROM employees AS e
	INNER JOIN pay_details AS pd
	ON pd.id = e.pay_detail_id

-------b

SELECT 
	e.*,
	pd.local_account_no,
	pd.local_sort_code,
	t.name AS team_name
FROM employees AS e
	INNER JOIN pay_details AS pd
	ON pd.id = e.pay_detail_id
	INNER JOIN teams AS t
	ON t.id = e.team_id
	

	
	
	
	
	
	
	
	
	-----3
	

	
SELECT 
	e.id,
	t.name AS team_name
FROM employees AS e
	INNER JOIN teams AS t
	ON t.id = e.team_id
	
	-----b
	
SELECT 
	t.name AS team_name,
	count(e.id) AS n_employees
FROM employees AS e
	INNER JOIN teams AS t
	ON t.id = e.team_id
GROUP BY t.id
ORDER BY count(e.id) ASC 
	









---------4 

SELECT 
	t.id AS team_id,
	t.name AS team_name,
	count(e.id) AS n_employees
FROM employees AS e
	INNER JOIN teams AS t
	ON t.id = e.team_id
GROUP BY t.id
ORDER BY count(e.id) ASC 


---------b

SELECT 
	t.id,
	t.name,
	CAST(t.charge_cost AS int) * count(e.id) AS total_day_charge
FROM employees AS e
	INNER JOIN teams AS t
	ON t.id = e.team_id
GROUP BY t.id
HAVING CAST(t.charge_cost AS int) * count(e.id) > 5000







------5

SELECT
	count(DISTINCT e.id)
FROM employees AS e
	INNER JOIN employees_committees AS ec
	ON ec.employee_id = e.id
	
	
	
-----6
	
SELECT
	count(e.id)
FROM employees AS e
	LEFT JOIN employees_committees AS ec
	ON ec.employee_id = e.id
WHERE committee_id IS NULL
