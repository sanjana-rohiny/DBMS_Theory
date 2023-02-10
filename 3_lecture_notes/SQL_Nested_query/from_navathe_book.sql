/*
NESTED QUERIES , JOIN QUERIES AND SET OPERATORS 

Schema is as given below.
=========================
EMPLOYEE(Fname,  Minit, Lname, Ssn, Bdate, Address, Sex, Salary, Super_ssn, Dno)
DEPARTMENT(Dname, Dnumber, Mgr_ssn, Mgr_start_date)
DEPT_LOCATIONS ( Dnumber, Dlocation)
PROJECT(Pname, Pnumber, Plocation, Dnum)
WORKS_ON(Essn, Pno, Hours)
DEPENDENT(Essn, Dependent_name, Sex, Bdate, Relationship)
*/

use lab7_expt;
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

#1 Display all employee names and salary whose salary is greater than minimum salary of the  company 
select Fname,Lname,Salary from EMPLOYEE where Salary>(select min(Salary) from  EMPLOYEE);

#2. Issue a query to display information about employees who earn more than any employee in  dept no 5
select * from EMPLOYEE where Salary>(select min(Salary) from EMPLOYEE where  Dno=5); 

#3. Display the details of those who draw the salary greater than the average salary. 
select distinct * from EMPLOYEE where Salary >= (select avg(Salary) from  EMPLOYEE);

#4. Write SQL Query which retrieves the name and address of every employee who works for  the Research Department 
select Fname, Lname, Address from EMPLOYEE, DEPARTMENT where Dno = Dnumber and Dname = 'Research';

#5 Retrieve the name of each employee who has a dependent with the same first name and is  the same sex as the employee.  
Select E.Fname, E.Lname From EMPLOYEE as E where E.Ssn in ( Select Essn From  DEPENDENT as D where E.Fname=D.
 and E.Sex=D.Sex ); 

#6. Make a list of all project numbers for projects that involve an employee whose last name is  ‘Smith’, 
# either as a worker or as a manager of the department that controls the project.
select Pno from WORKS_ON, EMPLOYEE where Essn = Ssn and Lname = 'Smith' 
UNION  
select Pnumber from PROJECT P, DEPARTMENT D, EMPLOYEE E where P.Dnum = D.Dnumber and D.Mgr_ssn = E.Ssn and E.Lname = 'Smith';

#7. Write a query to display the name for all employees who work in a department with any  employee whose Fname contains the letter 'h' 
Select Fname from EMPLOYEE where Dno IN (Select Dno from EMPLOYEE where Fname  LIKE '%h%');

#8 Retrieve all employees whose address Starts with Houston. 
select Fname, Lname, Address from EMPLOYEE where Address LIKE 'Houston%';

#9. Retrieve all employees whose address is Ends with Houston..
select Fname, Lname, Address from EMPLOYEE where Address LIKE '%Houston';

#10 Find all employees who were born during the 1960s.
select Fname, Lname from EMPLOYEE where Bdate LIKE '__6_______';

#11 Retrieve all employees in department 5 whose salary is between $30,000 and $40,000.
# This is the use of in between
SELECT *  FROM EMPLOYEE WHERE (Salary BETWEEN 30000 AND 40000) AND Dno = 5;

# this is euquqlent to <= and > =
SELECT *  FROM EMPLOYEE WHERE (Salary >=  30000 AND Salary <= 40000) AND Dno = 5;

#12. Write a SQL query to find those employees who work in the same department where  'Ramesh' works. 
# Exclude all those records where first name is 'Ramesh'. Return first name,  last name 
select Fname, Lname, Dno  from EMPLOYEE where dno = (select dno from EMPLOYEE where Fname = 'Ramesh') and Fname <> 'Ramesh';

#13 1 Display all the dept numbers available in Emp and not in dept tables
select Dno from EMPLOYEE left join  DEPARTMENT on Dno = Dnumber where Dnumber is NULL;
#14.  Display all the dept numbers available in dept and not in Emp tables
select Dnumber from EMPLOYEE right join  DEPARTMENT on Dno = Dnumber where Dno is NULL;
  
#15 For every project located in ‘Stafford’, list the project number, the controlling department number, and the department manager’s last name, address, and birth date.
select Pnumber, Dnum, Lname, Address, Bdate  from PROJECT, DEPARTMENT, EMPLOYEE  where Dnum=Dnumber and Mgr_ssn=Ssn and Plocation='Stafford';
  
#16 For each employee, retrieve the employee’s first and last name and the first and last name of his or her immediate supervisor.
	# only employees who have a supervisor are included in the result
	# this is SELF JOIN
select E.Fname, E.Lname, S.Fname, S.Lname  from  EMPLOYEE AS E, EMPLOYEE AS S where E.Super_ssn = S.Ssn;

#17 For each employee, retrieve the employee’s first and last name and the first and last name of his or her immediate supervisor, including those who have no immediate supervisors
select E.Fname, E.Lname, S.Fname, S.Lname  from  EMPLOYEE AS E left join EMPLOYEE AS S on  E.Super_ssn = S.Ssn;

#18. List the details of employees having no immediate supervisor.
select * from EMPLOYEE where Super_ssn IS NULL; 

#19. Show the resulting salaries if every employee working on the ‘ProductX’ project is given a 10 percent raise.
#This is use of arithmetic expression in select clause 
select E.Fname, E.Lname, 1.1 * E.Salary AS Increased_sal  from  EMPLOYEE AS E, WORKS_ON AS W, PROJECT AS P 
where E.Ssn=W.Essn AND W.Pno=P.Pnumber AND  P.Pname='ProductX';

#20 List the first name and last name of all employees who work in the same department as the manager with last name 'Wong',
select E.Fname, E.Lname from EMPLOYEE E where E.Dno = ( select D.Dnumber from DEPARTMENT D where D.Mgr_ssn = (select  E2.Ssn from EMPLOYEE E2 where E2.Lname = 'Wong'));

