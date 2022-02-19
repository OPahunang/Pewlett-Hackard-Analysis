-- Delivery 1
-- retirement_titles TABLE

SELECT employees.emp_no,
	employees.first_name,
	employees.last_name,
	titles.title,
	titles.from_date,
	titles.to_date
INTO retirement_titles
FROM employees
INNER JOIN titles
ON employees.emp_no = titles.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;

SELECT * FROM retirement_titles

-- Use Dictinct with Orderby to remove duplicate rows
-- unique_titles TABLE

SELECT DISTINCT ON (retirement_titles.emp_no) retirement_titles.emp_no,
retirement_titles.first_name,
retirement_titles.last_name,
retirement_titles.title

INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no ASC, to_date DESC;

SELECT * FROM unique_titles

-- Count of employees about to retire by job title
-- retiring_titles TABLE

SELECT Count (unique_titles.emp_no),unique_titles.title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(title) DESC;

SELECT * FROM retiring_titles

-- Mentorship Eligibility that holds employees who are eligible
-- mentorship_eligibilty TABLE

SELECT DISTINCT ON (employees.emp_no) employees.emp_no,
employees.first_name,
employees.last_name,
employees.birth_date,
dept_emp.from_date,
dept_emp.to_date,
titles.title
INTO mentorship_eligibility
FROM employees 
INNER JOIN dept_emp 
ON dept_emp.emp_no = employees.emp_no
INNER JOIN titles 
ON employees.emp_no = titles.emp_no 
WHERE (dept_emp.to_date = '9999-01-01')
AND (employees.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no;

SELECT * FROM mentorship_eligibility