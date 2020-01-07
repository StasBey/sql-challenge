--1. List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT employees.emp_no as "employee number", last_name as "last name", first_name as "first name", gender, salary 
FROM employees 
JOIN salaries ON employees.emp_no = salaries.emp_no;

--2. List employees who were hired in 1986.
SELECT emp_no as "employee number", last_name as "last name", first_name as "first name", gender, hire_date 
FROM employees
WHERE CAST(hire_date AS text) LIKE '1986%';

--3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
SELECT departments.dept_no as "department number", departments.dept_name as "department name", employees.emp_no as "managers employee number", employees.last_name as "last name", employees.first_name as "first name", dept_emp.from_date, dept_emp.to_date
FROM dept_manager
JOIN departments ON dept_manager.dept_no = departments.dept_no
JOIN employees ON employees.emp_no = dept_manager.emp_no
JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
ORDER BY departments.dept_no;

--4. List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT employees.emp_no as "employee number", employees.last_name as "last name", employees.first_name as "first name", departments.dept_name as "department name" 
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON departments.dept_no = dept_emp.dept_no;

--5. List all employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name as "first name", last_name as "last name"
FROM employees
WHERE first_name = 'Hercules' and last_name LIKE 'B%'

--6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT employees.emp_no as "employee number", employees.last_name as "last name", employees.first_name as "first name", departments.dept_name as "department name" 
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON departments.dept_no = dept_emp.dept_no
WHERE departments.dept_name = 'Sales';

--7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT employees.emp_no as "employee number", employees.last_name as "last name", employees.first_name as "first name", departments.dept_name as "department name" 
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON departments.dept_no = dept_emp.dept_no
WHERE departments.dept_name = 'Sales' OR departments.dept_name = 'Development';

--8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name as "last name", COUNT(last_name) as "last name frequency count"
FROM employees
GROUP BY last_name
ORDER BY "last name frequency count" desc;