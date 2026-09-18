# Employee-Payroll-records
Employee Payroll Management System built with MySQL. Features relational schema design, automated financial tracking, complex SQL analytical queries, and department-level expenditure aggregation.
# Employee Payroll Database Project

A comprehensive MySQL-based database project designed to manage employee records, organizational departments, and monthly payroll processing. This repository contains the relational schema, sample data, and analytical SQL scripts for tracking compensation, aggregate expenditures, and pending payments.

---

## 🛠️ Database Schema

The database consists of three main relational tables:

1. **`departments`**: Stores department details, locations, and assigned managers.
2. **`employees`**: Contains employee personal info, job titles, base salaries, and hire dates.
3. **`payroll_records`**: Records compensation breakdowns including base pay, bonuses, deductions, tax rates, net pay, and payment statuses.

---

## 🚀 Getting Started

### 1. Prerequisites
* MySQL Server (v8.0 or higher)
* MySQL Workbench or any SQL client interface

### 2. Database & Table Setup
Run the following commands to initialize the database and create the required tables:

```sql
-- Initialize Database
CREATE DATABASE IF NOT EXISTS employee_payroll;
USE employee_payroll;

-- Create Departments Table
CREATE TABLE departments (
    department_id VARCHAR(10) PRIMARY KEY,
    department_name VARCHAR(50),
    manager_id VARCHAR(10),
    location VARCHAR(50)
);

-- Create Employees Table
CREATE TABLE employees (
    emp_id VARCHAR(10) PRIMARY KEY,
    emp_name VARCHAR(50),
    department_id VARCHAR(10),
    position VARCHAR(50),
    base_salary DECIMAL(10, 2),
    hire_date DATE,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Create Payroll Records Table
CREATE TABLE payroll_records (
    payroll_id VARCHAR(10) PRIMARY KEY,
    emp_id VARCHAR(10),
    pay_period VARCHAR(7),
    bonus DECIMAL(10, 2),
    deductions DECIMAL(10, 2),
    tax_rate DECIMAL(4, 2),
    net_pay DECIMAL(10, 2),
    payment_status VARCHAR(15),
🔍 Key Tasks & Analytical Queries
This repository includes scripts to perform essential data operations and business intelligence reporting:

CRUD Operations: Insert new hires, update department-wide salaries, and delete cancelled/pending records.

Correlated Subqueries: Identify employees earning above their specific department's average compensation.

CTAS Aggregations: Generate permanent summary tables (dept_payroll_summary) containing total net payouts and average salary metrics per department.

Relational Joins & Self-Joins: Extract complete manager-employee organizational structures and trace outstanding payroll statuses.

💡 Future Enhancements
Add SQL triggers to calculate net_pay dynamically upon transaction insertion.

Build an audit_logs table to track salary adjustment histories over time.

Implement support for multi-tier tax brackets and hourly overtime tracking.
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);
