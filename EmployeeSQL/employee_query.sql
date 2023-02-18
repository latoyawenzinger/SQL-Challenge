-- create table schemas
CREATE TABLE departments (
    dept_no VARCHAR(30) NOT NULL,
    dept_name VARCHAR(100) NOT NULL,
	 PRIMARY KEY (dept_no)
);


CREATE TABLE titles(
    title_id VARCHAR(30) NOT NULL,
    title VARCHAR(50) NOT NULL,
	PRIMARY KEY (title_id)
	
);


CREATE TABLE employees(
    emp_no INT NOT NULL,
    emp_title VARCHAR(30) NOT NULL,
    birth_date DATE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    sex VARCHAR(1) NOT NULL,
    hire_date DATE NOT NULL,
	PRIMARY KEY (emp_no)
	FOREIGN KEY(emp_title) REFERENCES titles(title_id)

);

CREATE TABLE dept_manager(
    dept_no VARCHAR(30) NOT NULL,
    emp_no INT NOT NULL,
	FOREIGN KEY(dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY(emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE dept_emp(
    emp_no INT NOT NULL,
    dept_no VARCHAR(30) NOT NULL,
	FOREIGN KEY(dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY(emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE salaries(
    emp_no INT NOT NULL,
    salary INT NOT NULL,
	FOREIGN KEY(emp_no) REFERENCES employees(emp_no)
);


-- List the employee number, last name, first name, sex, and salary of each employee.
SELECT salaries.emp_no, salaries.salary, employees.last_name, employees.first_name, employees.sex
FROM salaries
INNER JOIN employees ON
employees.emp_no=salaries.emp_no;

-- List the first name, last name, and hire date for the employees who were hired in 1986
SELECT first_name, last_name, hire_date
FROM  employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

-- List the manager of each department along with their department number, department name, employee number, last name, and first name
SELECT employees.last_name, employees.first_name, employees.emp_no, dept_manager.dept_no, departments.dept_name
FROM employees
JOIN dept_manager ON
employees.emp_no=dept_manager.emp_no
JOIN departments ON
dept_manager.dept_no=departments.dept_no;


-- List the department number for each employee along with that employee’s employee number, last name, first name, and department name
SELECT employees.last_name, employees.first_name, employees.emp_no, dept_emp.dept_no, departments.dept_name
FROM employees
JOIN dept_emp ON
employees.emp_no=dept_emp.emp_no
JOIN departments ON
dept_emp.dept_no=departments.dept_no;

-- List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

-- List each employee in the Sales department, including their employee number, last name, and first name.
SELECT emp_no, last_name, first_name
FROM employees
WHERE emp_no IN (
	
	SELECT emp_no
	FROM dept_emp
	WHERE dept_no IN (
		
		SELECT dept_no
		FROM departments
		WHERE dept_name = 'Sales'
	)	
);

-- List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name
SELECT employees.last_name, employees.first_name, employees.emp_no, departments.dept_name
FROM employees
JOIN dept_emp ON
employees.emp_no=dept_emp.emp_no
JOIN departments ON
dept_emp.dept_no=departments.dept_no
WHERE departments.dept_name = 'Sales' OR departments.dept_name = 'Development';
		
-- List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name)





