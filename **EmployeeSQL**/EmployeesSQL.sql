--DROP TABLE departments
CREATE TABLE departments
(
  dept_no varchar(10) NOT NULL,
  dept_name varchar(50) NOT NULL,
  CONSTRAINT pk_departments PRIMARY KEY(dept_no)
);

--DROP TABLE dept_emp
CREATE TABLE dept_emp
(
  emp_no int   NOT NULL,
  dept_no varchar(10)   NOT NULL,
  from_date date   NOT NULL,
  to_date date   NOT NULL
);

--DROP TABLE dept_manager
CREATE TABLE dept_manager
(
  dept_no varchar(10),
  emp_no int,
  from_date date,
  to_date date
);

--DROP TABLE employees
CREATE TABLE employees
(
  emp_no int NOT NULL,
  birth_date date   NOT NULL,
  first_name varchar(30)   NOT NULL,
  last_name varchar(30)   NOT NULL,
  gender varchar(30)   NOT NULL,
  hire_date date,
  CONSTRAINT pk_employees PRIMARY KEY (emp_no)
);

--DROP TABLE salaries
CREATE TABLE salaries
(
  emp_no int,
  salary int,
  from_date date,
  to_date date,
  CONSTRAINT pk_salaries PRIMARY KEY (emp_no)
);

--DROP TABLE titles
CREATE TABLE titles
(
  emp_no int,
  title varchar(30),
  from_date date,
  to_date date
);

ALTER TABLE dept_emp ADD CONSTRAINT fk_dept_emp_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

ALTER TABLE dept_emp ADD CONSTRAINT fk_dept_emp_dept_no FOREIGN KEY(dept_no)
REFERENCES departments (dept_no);

ALTER TABLE dept_manager ADD CONSTRAINT fk_dept_manager_dept_no FOREIGN KEY(dept_no)
REFERENCES departments (dept_no);

ALTER TABLE dept_manager ADD CONSTRAINT fk_dept_manager_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

ALTER TABLE salaries ADD CONSTRAINT fk_salaries_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

ALTER TABLE titles ADD CONSTRAINT fk_titles_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

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