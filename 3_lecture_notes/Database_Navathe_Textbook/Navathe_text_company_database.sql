create database Navathe_tables;
use Navathe_tables;
SET FOREIGN_KEY_CHECKS=0;

CREATE TABLE EMPLOYEE
( Fname           VARCHAR(10)   NOT NULL,
  Minit           CHAR,
  Lname           VARCHAR(20)      NOT NULL,
  Ssn             CHAR(9)          NOT NULL,
  Bdate           DATE,
  Address         VARCHAR(30),
  Sex             CHAR(1),
  Salary          DECIMAL(5),
  Super_ssn       CHAR(9),
  Dno             INT               NOT NULL,
PRIMARY KEY   (Ssn));

CREATE TABLE DEPARTMENT
( Dname           VARCHAR(15)       NOT NULL,
  Dnumber         INT               NOT NULL,
  Mgr_ssn         CHAR(9)           NOT NULL,
  Mgr_start_date  DATE,
PRIMARY KEY (Dnumber),
UNIQUE      (Dname),
FOREIGN KEY (Mgr_ssn) REFERENCES EMPLOYEE(Ssn) );

CREATE TABLE DEPT_LOCATIONS
( Dnumber         INT               NOT NULL,
  Dlocation       VARCHAR(15)       NOT NULL,
PRIMARY KEY (Dnumber, Dlocation),
FOREIGN KEY (Dnumber) REFERENCES DEPARTMENT(Dnumber) );

CREATE TABLE PROJECT
( Pname           VARCHAR(15)       NOT NULL,
  Pnumber         INT               NOT NULL,
  Plocation       VARCHAR(15),
  Dnum            INT               NOT NULL,
PRIMARY KEY (Pnumber),
UNIQUE      (Pname),
FOREIGN KEY (Dnum) REFERENCES DEPARTMENT(Dnumber) );

CREATE TABLE WORKS_ON
( Essn            CHAR(9)           NOT NULL,
  Pno             INT               NOT NULL,
  Hours           DECIMAL(3,1)      NOT NULL,
PRIMARY KEY (Essn, Pno),
FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn),
FOREIGN KEY (Pno) REFERENCES PROJECT(Pnumber) );

CREATE TABLE DEPENDENT
( Essn            CHAR(9)           NOT NULL,
  Dependent_name  VARCHAR(15)       NOT NULL,
  Sex             CHAR,
  Bdate           DATE,
  Relationship    VARCHAR(8),
PRIMARY KEY (Essn, Dependent_name),
FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn) );

INSERT INTO EMPLOYEE
VALUES      ('John','B','Smith',123456789,'1965-01-09','731 Fondren, Houston TX','M',30000,333445555,5),
            ('Franklin','T','Wong',333445555,'1965-12-08','638 Voss, Houston TX','M',40000,888665555,5),
            ('Alicia','J','Zelaya',999887777,'1968-01-19','3321 Castle, Spring TX','F',25000,987654321,4),
            ('Jennifer','S','Wallace',987654321,'1941-06-20','291 Berry, Bellaire TX','F',43000,888665555,4),
            ('Ramesh','K','Narayan',666884444,'1962-09-15','975 Fire Oak, Humble TX','M',38000,333445555,5),
            ('Joyce','A','English',453453453,'1972-07-31','5631 Rice, Houston TX','F',25000,333445555,5),
            ('Ahmad','V','Jabbar',987987987,'1969-03-29','980 Dallas, Houston TX','M',25000,987654321,4),
            ('James','E','Borg',888665555,'1937-11-10','450 Stone, Houston TX','M',55000,null,1);

INSERT INTO DEPARTMENT
VALUES      ('Research',5,333445555,'1988-05-22'),
            ('Administration',4,987654321,'1995-01-01'),
            ('Headquarters',1,888665555,'1981-06-19');

INSERT INTO PROJECT
VALUES      ('ProductX',1,'Bellaire',5),
            ('ProductY',2,'Sugarland',5),
            ('ProductZ',3,'Houston',5),
            ('Computerization',10,'Stafford',4),
            ('Reorganization',20,'Houston',1),
            ('Newbenefits',30,'Stafford',4);

INSERT INTO WORKS_ON
VALUES     (123456789,1,32.5),
           (123456789,2,7.5),
           (666884444,3,40.0),
           (453453453,1,20.0),
           (453453453,2,20.0),
           (333445555,2,10.0),
           (333445555,3,10.0),
           (333445555,10,10.0),
           (333445555,20,10.0),
           (999887777,30,30.0),
           (999887777,10,10.0),
           (987987987,10,35.0),
           (987987987,30,5.0),
           (987654321,30,20.0),
           (987654321,20,15.0),
           (888665555,20,16.0);

INSERT INTO DEPENDENT
VALUES      (333445555,'Alice','F','1986-04-04','Daughter'),
            (333445555,'Theodore','M','1983-10-25','Son'),
            (333445555,'Joy','F','1958-05-03','Spouse'),
            (987654321,'Abner','M','1942-02-28','Spouse'),
            (123456789,'Michael','M','1988-01-04','Son'),
            (123456789,'Alice','F','1988-12-30','Daughter'),
            (123456789,'Elizabeth','F','1967-05-05','Spouse');

INSERT INTO DEPT_LOCATIONS
VALUES      (1,'Houston'),
            (4,'Stafford'),
            (5,'Bellaire'),
            (5,'Sugarland'),
            (5,'Houston');

ALTER TABLE DEPARTMENT
 ADD CONSTRAINT Dep_emp FOREIGN KEY (Mgr_ssn) REFERENCES EMPLOYEE(Ssn);

ALTER TABLE EMPLOYEE
 ADD CONSTRAINT Emp_emp FOREIGN KEY (Super_ssn) REFERENCES EMPLOYEE(Ssn);
ALTER TABLE EMPLOYEE
 ADD CONSTRAINT Emp_dno FOREIGN KEY  (Dno) REFERENCES DEPARTMENT(Dnumber);
ALTER TABLE EMPLOYEE
 ADD CONSTRAINT Emp_super FOREIGN KEY  (Super_ssn) REFERENCES EMPLOYEE(Ssn);
 
# QUERY 1. Retrieve the name and address of all employees who work for the ‘Research’ department
SELECT Fname, Lname, Address 
FROM EMPLOYEE, DEPARTMENT
WHERE Dname= 'Research' AND Dnumber=Dno;
/*
+----------+---------+-------------------------+
| Fname    | Lname   | Address                 |
+----------+---------+-------------------------+
| John     | Smith   | 731 Fondren, Houston TX |
| Franklin | Wong    | 638 Voss, Houston TX    |
| Joyce    | English | 5631 Rice, Houston TX   |
| Ramesh   | Narayan | 975 Fire Oak, Humble TX |
+----------+---------+-------------------------+ */

# QUERY 2. For every project located in ‘Stafford’, list the project number, the controlling department number, 
# and the department manager’s last name, address, and birth date.

SELECT Pnumber, Dnum, Lname, Address, Bdate 
FROM PROJECT, DEPARTMENT, EMPLOYEE 
WHERE Dnum=Dnumber AND Mgr_ssn=Ssn AND Plocation='Stafford';
/*+---------+------+---------+------------------------+------------+
| Pnumber | Dnum | Lname   | Address                | Bdate      |
+---------+------+---------+------------------------+------------+
|      10 |    4 | Wallace | 291 Berry, Bellaire TX | 1941-06-20 |
|      30 |    4 | Wallace | 291 Berry, Bellaire TX | 1941-06-20 |
+---------+------+---------+------------------------+------------+ */

# QUERY 3 Query 8. For each employee, retrieve the employee’s first and last name and
# the first and last name of his or her immediate supervisor.

# only employees who have a supervisor are included in the result
# this is SELF JOIN
SELECT E.Fname, E.Lname, S.Fname, S.Lname 
FROM EMPLOYEE AS E, EMPLOYEE AS S 
WHERE E.Super_ssn=S.Ssn;
/*+----------+---------+----------+---------+
| Fname    | Lname   | Fname    | Lname   |
+----------+---------+----------+---------+
| John     | Smith   | Franklin | Wong    |
| Franklin | Wong    | James    | Borg    |
| Joyce    | English | Franklin | Wong    |
| Ramesh   | Narayan | Franklin | Wong    |
| Jennifer | Wallace | James    | Borg    |
| Ahmad    | Jabbar  | Jennifer | Wallace |
| Alicia   | Zelaya  | Jennifer | Wallace |
+----------+---------+----------+---------+ */
# If you want to print all employees details, that is those who have no superwisers, use left join.

# QUERY 4. Make a list of all project numbers for projects that involve an
# employee whose last name is ‘Smith’, either as a worker or as a manager of the
# department that controls the project.

# This use UNION caluse
( SELECT DISTINCT Pnumber FROM PROJECT, DEPARTMENT, EMPLOYEE WHERE Dnum=Dnumber AND Mgr_ssn=Ssn AND Lname='Smith' ) 
              UNION 
( SELECT DISTINCT Pnumber FROM PROJECT, WORKS_ON, EMPLOYEE WHERE Pnumber=Pno AND Essn=Ssn AND Lname='Smith' );
/*+---------+
| Pnumber |
+---------+
|       1 |
|       2 |
+---------+ */

# Substring Pattern Matching and Arithmetic Operators
#=======================================================

# QUERY 4: Retrieve all employees whose address is in Houston, Texas.

SELECT Fname, Lname, Address 
FROM EMPLOYEE 
WHERE Address LIKE '%Houston%';
/*----------+---------+-------------------------+
| Fname    | Lname   | Address                 |
+----------+---------+-------------------------+
| John     | Smith   | 731 Fondren, Houston TX |
| Franklin | Wong    | 638 Voss, Houston TX    |
| Joyce    | English | 5631 Rice, Houston TX   |
| James    | Borg    | 450 Stone, Houston TX   |
| Ahmad    | Jabbar  | 980 Dallas, Houston TX  |
+----------+---------+-------------------------+*/

# QUERY 5: Retrieve all employees whose address Starts with Houston.
SELECT Fname, Lname, Address FROM EMPLOYEE WHERE Address LIKE 'Houston%';

# QUERY 6: Retrieve all employees whose address is Ends with Houston..
SELECT Fname, Lname, Address FROM EMPLOYEE WHERE Address LIKE '%Houston';

# QUERY 7: Find all employees who were born during the 1960s.
SELECT Fname, Lname FROM EMPLOYEE WHERE Bdate LIKE '__6_______';
/*+----------+---------+
| Fname    | Lname   |
+----------+---------+
| John     | Smith   |
| Franklin | Wong    |
| Ramesh   | Narayan |
| Ahmad    | Jabbar  |
| Alicia   | Zelaya  |
+----------+---------+*/

# QUERY 7: Show the resulting salaries if every employee working on the
# ‘ProductX’ project is given a 10 percent raise.

# This is use of arithmetic expression in select clause 

SELECT E.Fname, E.Lname, 1.1 * E.Salary AS Increased_sal 
FROM EMPLOYEE AS E, WORKS_ON AS W, PROJECT AS P 
WHERE E.Ssn=W.Essn AND W.Pno=P.Pnumber AND  P.Pname='ProductX';
/*+-------+---------+---------------+
| Fname | Lname   | Increased_sal |
+-------+---------+---------------+
| John  | Smith   |       33000.0 |
| Joyce | English |       27500.0 |
+-------+---------+---------------+ */


# QUERY 7: Retrieve all employees in department 5 whose salary is between $30,000 and $40,000.

# This is the use of in between
SELECT *  FROM EMPLOYEE WHERE (Salary BETWEEN 30000 AND 40000) AND Dno = 5;

# this is euquqlent to <= and > =
SELECT *  FROM EMPLOYEE WHERE (Salary >=  30000 AND Salary <= 40000) AND Dno = 5;

# That is 'BETWEEN' Does takes the boubdary values, that is including the limit values

 #Ordering of Query Results
 #=======================================================
# QUERY 7 Retrieve a list of employees and the projects they are working on,
# ordered by department and, within each department, ordered alphabetically by last name, then first name
SELECT D.Dname, E.Lname, E.Fname, P.Pname 
FROM DEPARTMENT D, EMPLOYEE E, WORKS_ON W, PROJECT P 
WHERE  D.Dnumber= E.Dno AND E.Ssn= W.Essn AND W.Pno= P.Pnumber ORDER BY D.Dname, E.Lname, E.Fname;
/*+----------------+---------+----------+-----------------+
| Dname          | Lname   | Fname    | Pname           |
+----------------+---------+----------+-----------------+
| Administration | Jabbar  | Ahmad    | Computerization |
| Administration | Jabbar  | Ahmad    | Newbenefits     |
| Administration | Wallace | Jennifer | Reorganization  |
| Administration | Wallace | Jennifer | Newbenefits     |
| Administration | Zelaya  | Alicia   | Computerization |
| Administration | Zelaya  | Alicia   | Newbenefits     |
| Headquarters   | Borg    | James    | Reorganization  |
| Research       | English | Joyce    | ProductX        |
| Research       | English | Joyce    | ProductY        |
| Research       | Narayan | Ramesh   | ProductZ        |
| Research       | Smith   | John     | ProductX        |
| Research       | Smith   | John     | ProductY        |
| Research       | Wong    | Franklin | ProductY        |
| Research       | Wong    | Franklin | ProductZ        |
| Research       | Wong    | Franklin | Computerization |
| Research       | Wong    | Franklin | Reorganization  |
+----------------+---------+----------+-----------------+*/
