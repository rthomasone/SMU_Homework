-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "Departments" (
    "dept_no" varchar(20)   NOT NULL,
    "dept_name" varchar(50)   NULL,
    "last_updated" timestamp   NULL default current_timestamp,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "Dept_Emp" (
    "dept_emp_id" SERIAL NOT NULL,
    "emp_no" int   NOT NULL,
    "dept_no" varchar(20)   NOT NULL,
    "last_updated" timestamp   NULL default current_timestamp,
    CONSTRAINT "pk_Dept_Emp" PRIMARY KEY (
        "dept_emp_id"
     )
);

CREATE TABLE "Dept_Manager" (
    "dept_man_id" SERIAL NOT NULL,
    "emp_no" int   NOT NULL,
    "dept_no" varchar(20)   NOT NULL,
    "last_updated" timestamp   NULL default current_timestamp,
    CONSTRAINT "pk_Dept_Manager" PRIMARY KEY (
        "dept_man_id"
     )
);

CREATE TABLE "Employee" (
    "emp_no" int   NOT NULL,
    "emp_title_id" varchar(50)   NOT NULL,
    "birth_date" date   NULL,
    "first_name" varchar(50)   NULL,
    "last_name" varchar(50)   NULL,
    "sex" varchar(1)   NULL,
    "hire_date" date   NULL,
    "last_updated" timestamp   NULL default current_timestamp,
    CONSTRAINT "pk_Employee" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "Salaries" (
    "salary_id" SERIAL NOT NULL,
    "emp_no" int   NOT NULL,
    "salary" int   NULL,
    "last_updated" timestamp   NULL default current_timestamp,
    CONSTRAINT "pk_Salaries" PRIMARY KEY (
        "salary_id"
     )
);

CREATE TABLE "Titles" (
    "title_id" varchar(50)   NOT NULL,
    "title" varchar(50)   NULL,
    "last_updated" timestamp   NULL default current_timestamp,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "title_id"
     )
);

ALTER TABLE "Dept_Emp" ADD CONSTRAINT "fk_Dept_Emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employee" ("emp_no");

ALTER TABLE "Dept_Emp" ADD CONSTRAINT "fk_Dept_Emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_Manager" ADD CONSTRAINT "fk_Dept_Manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employee" ("emp_no");

ALTER TABLE "Dept_Manager" ADD CONSTRAINT "fk_Dept_Manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Employee" ADD CONSTRAINT "fk_Employee_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "Titles" ("title_id");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employee" ("emp_no");


