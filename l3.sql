--3.1

SELECT COUNT(emp_no) FROM titles
WHERE (from_date <= CURRENT_DATE AND to_date >= CURRENT_DATE);

--3.2
SELECT COUNT( DISTINCT title) FROM titles;

--3.3
SELECT AVG(salary), STDDEV(salary) FROM salaries
WHERE (from_date <= CURRENT_DATE AND to_date >= CURRENT_DATE);
