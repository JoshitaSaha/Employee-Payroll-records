-- Step 1: Create the database
CREATE DATABASE employee_payroll;

-- Step 2: Select and use the database
USE employee_payroll;
-- create table departments
CREATE TABLE departments (
    department_id VARCHAR(10) PRIMARY KEY,
    department_name VARCHAR(50),
    manager_id VARCHAR(10),
    location VARCHAR(50)
);
-- create table employees
CREATE TABLE employees (
    emp_id VARCHAR(10) PRIMARY KEY,
    emp_name VARCHAR(50),
    department_id VARCHAR(10),
    position VARCHAR(50),
    base_salary DECIMAL(10, 2),
    hire_date DATE,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);
-- create table payroll records
CREATE TABLE payroll_records (
    payroll_id VARCHAR(10) PRIMARY KEY,
    emp_id VARCHAR(10),
    pay_period VARCHAR(7), -- Format: YYYY-MM
    bonus DECIMAL(10, 2),
    deductions DECIMAL(10, 2),
    tax_rate DECIMAL(4, 2),
    net_pay DECIMAL(10, 2),
    payment_status VARCHAR(15),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);
USE employee_payroll;

-- Populate Departments
INSERT INTO departments (department_id, department_name, manager_id, location) VALUES
('D01', 'Engineering', 'E102', 'Building A'),
('D02', 'Human Resources', 'E105', 'Building B'),
('D03', 'Finance', 'E104', 'Building C');

-- Populate Employees
INSERT INTO employees (emp_id, emp_name, department_id, position, base_salary, hire_date) VALUES
('E101', 'Alice Smith', 'D01', 'Software Engineer', 75000.00, '2021-03-15'),
('E102', 'Bob Jones', 'D01', 'Senior Developer', 95000.00, '2019-06-01'),
('E103', 'Charlie Brown', 'D02', 'HR Specialist', 55000.00, '2022-01-10'),
('E104', 'Diana Prince', 'D03', 'Financial Analyst', 68000.00, '2020-11-20'),
('E105', 'Evan Wright', 'D02', 'HR Manager', 85000.00, '2018-04-05');

-- Populate Payroll Records
INSERT INTO payroll_records (payroll_id, emp_id, pay_period, bonus, deductions, tax_rate, net_pay, payment_status) VALUES
('P1001', 'E101', '2026-08', 1000.00, 500.00, 0.20, 5800.00, 'Paid'),
('P1002', 'E102', '2026-08', 1500.00, 800.00, 0.22, 7015.00, 'Paid'),
('P1003', 'E103', '2026-08', 300.00, 300.00, 0.15, 4000.00, 'Paid'),
('P1004', 'E104', '2026-08', 800.00, 450.00, 0.18, 5013.33, 'Paid'),
('P1005', 'E105', '2026-08', 1200.00, 700.00, 0.20, 6083.33, 'Pending');

-- Task 1: Insert a New Employee Record
INSERT INTO employees (emp_id, emp_name, department_id, position, base_salary, hire_date)
VALUES ('E106', 'Fiona Gallagher', 'D01', 'QA Engineer', 62000.00, '2023-02-01');
SELECT *FROM employees

-- Task 2: Update Employee Salary Across Department
UPDATE employees
SET base_salary = base_salary * 1.05
WHERE department_id = 'D01';
SELECT *FROM employees

SELECT *FROM payroll_records
-- Task 3: Delete Unprocessed/Cancelled Payroll Entry
DELETE FROM payroll_records
WHERE payroll_id = 'P1005' AND payment_status = 'Pending';

-- Task 4: Retrieve All Payroll Records for a Specific Employee
SELECT * FROM payroll_records
WHERE emp_id = 'E101';

-- Task 5: Find Employees with Total Monthly Compensation Above Department Average
SELECT e.emp_id, e.emp_name, e.base_salary
FROM employees e
WHERE e.base_salary > (
    SELECT AVG(base_salary) 
    FROM employees 
    WHERE department_id = e.department_id
);

-- Task 6: CTAS - Create Summary Table for Monthly Department Expenditure
CREATE TABLE dept_payroll_summary AS
SELECT 
    d.department_name,
    COUNT(e.emp_id) AS employee_count,
    SUM(p.net_pay) AS total_net_payout,
    AVG(p.net_pay) AS average_net_payout
FROM departments d
JOIN employees e ON d.department_id = e.department_id
JOIN payroll_records p ON e.emp_id = p.emp_id
GROUP BY d.department_name;
SELECT *FROM dept_payroll_summary
-- Task 7: List Employees with Their Manager Details
SELECT 
    e.emp_id,
    e.emp_name AS employee_name,
    e.position,
    d.department_name,
    m.emp_name AS manager_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
LEFT JOIN employees m ON d.manager_id = m.emp_id;

-- Task 8: Identify Employees with Pending Payroll Status
SELECT e.emp_id, e.emp_name, p.payroll_id, p.pay_period, p.payment_status
FROM employees e
JOIN payroll_records p ON e.emp_id = p.emp_id
WHERE p.payment_status = 'Pending';