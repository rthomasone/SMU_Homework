--- Query 1
--- List the following details of each employee: employee number, last name, first name, sex, and salary.

select 
	e.emp_no,
	e.last_name,
	e.first_name,
	e.sex,
	s.salary 
from 
	"Employee" e 
	join "Salaries" s on s.emp_no = e.emp_no
order by 
	e.emp_no asc;
	

--- Query 2
--- List first name, last name, and hire date for employees who were hired in 1986.

select 
	emp_no,
	last_name,
	first_name,
	hire_date 
from 
	"Employee" e
where
	extract(year from hire_date) = 1986
order by
	hire_date asc, emp_no asc;


--- Query 3
--- List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.

select
	dm.dept_man_id,
	dm.dept_no,
	d.dept_name,
	dm.emp_no,
	e.last_name,
	e.first_name
from 
	"Dept_Manager" dm
	join "Employee" e on e.emp_no = dm.emp_no
	join "Departments" d on d.dept_no = dm.dept_no
order by 
	dept_no asc, emp_no asc;

--- Query 4
--- List the department of each employee with the following information: employee number, last name, first name, and department name.

select 
	de.dept_emp_id,
	d.dept_no,
	d.dept_name, 
	e.emp_no,
	e.last_name,
	e.first_name
from 
	"Employee" e 
	join "Dept_Emp" de on de.emp_no = e.emp_no
	join "Departments" d on d.dept_no = de.dept_no 
order by 
	d.dept_no asc, e.emp_no asc;


--- Query 5
--- List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."

select 
	e.emp_no,
	e.last_name,
	e.first_name,
	e.sex
from 
	"Employee" e
where
	first_name = 'Hercules'
	and last_name like 'B%'
order by 
	e.emp_no asc;


--- Query 6
--- List all employees in the Sales department, including their employee number, last name, first name, and department name.

select 
	de.dept_emp_id,
	d.dept_no,
	d.dept_name, 
	e.emp_no,
	e.last_name,
	e.first_name
from 
	"Employee" e 
	join "Dept_Emp" de on de.emp_no = e.emp_no
	join "Departments" d on d.dept_no = de.dept_no
where 
	d.dept_name = 'Sales'
order by 
	d.dept_no asc, e.emp_no asc;


--- Query 7
--- List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

select 
	de.dept_emp_id,
	d.dept_no,
	d.dept_name, 
	e.emp_no,
	e.last_name,
	e.first_name
from 
	"Employee" e 
	join "Dept_Emp" de on de.emp_no = e.emp_no
	join "Departments" d on d.dept_no = de.dept_no
where 
	d.dept_name = 'Sales' 
	or d.dept_name = 'Development'
order by 
	d.dept_no asc, e.emp_no asc;


--- Query 8
--- In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

select 
	e.last_name,
	count(e.last_name)
from 
	"Employee" e
group by
	e.last_name 
order by 
	count(e.last_name ) desc;

