-- Create retirement_titles table
SELECT a.emp_no, a.first_name, a.last_name, b.title, b.from_date, b.to_date
INTO retirement_titles
FROM employees a
INNER JOIN title b on a.emp_no = b.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY a.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (a.emp_no) a.emp_no, 
	a.first_name,
	a.last_name,
	a.title
INTO unique_titles
FROM retirement_titles a
ORDER BY a.emp_no, a.to_date DESC;

-- Retrieve the number of employees by their most recent job title who are about to retire
SELECT count(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count(title) DESC;

/* Create a Mentorship Eligibility table that holds the employees who are eligible to participate
	in a mentorship program. */
SELECT DISTINCT ON (a.emp_no) a.emp_no,
	a.first_name,
	a.last_name,
	a.birth_date,
	b.from_date,
	b.to_date,
	c.title
INTO mentorship_eligibilty
FROM employees a
INNER JOIN dept_emp b on a.emp_no = b.emp_no
INNER JOIN title c on a.emp_no = c.emp_no
WHERE (a.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (b.to_date = '9999-01-01')
ORDER BY a.emp_no ASC;