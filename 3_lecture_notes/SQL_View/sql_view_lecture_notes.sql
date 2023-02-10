/*
VIEW: is a virtual table
1. In a DBMS (Database Management System), a view is a virtual table that consists of a subset of data from one or more tables in a database. 
2. Views are not stored physically as tables, but are created and stored as queries in the database.
3. Views can be created from a single or multiple tables
4. A view provides a mechanism for presenting a customized or summarized view of data from single/multiple tables in a database, 
   without changing the underlying tables. 
5. Views can be used to restrict access to sensitive data by showing only a subset of the data to specific users or roles

6. Views are created using the CREATE VIEW statement in SQL. Once created, 
   views can be used in the same way as tables in SELECT, INSERT, UPDATE, and DELETE statements.
7. UPDATING View;
	When you update a view, if the view is derived from single table -> the changes are reflected in the base table.
    if the view is derived from multiple tables -> the changes are NOT reflected in the base table.
8. Updating Base table : This will reflect existing views.alter
    
*/
create database lab5_tables;
use lab5_tables;
SET FOREIGN_KEY_CHECKS=0;


# creating base table
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

INSERT INTO EMPLOYEE
VALUES      ('John','B','Smith',123456789,'1965-01-09','731 Fondren, Houston TX','M',30000,333445555,5),
            ('Franklin','T','Wong',333445555,'1965-12-08','638 Voss, Houston TX','M',40000,888665555,5),
            ('Alicia','J','Zelaya',999887777,'1968-01-19','3321 Castle, Spring TX','F',25000,987654321,4),
            ('Jennifer','S','Wallace',987654321,'1941-06-20','291 Berry, Bellaire TX','F',43000,888665555,4),
            ('Ramesh','K','Narayan',666884444,'1962-09-15','975 Fire Oak, Humble TX','M',38000,333445555,5),
            ('Joyce','A','English',453453453,'1972-07-31','5631 Rice, Houston TX','F',25000,333445555,5),
            ('Ahmad','V','Jabbar',987987987,'1969-03-29','980 Dallas, Houston TX','M',25000,987654321,4),
            ('James','E','Borg',888665555,'1937-11-10','450 Stone, Houston TX','M',55000,null,1);
            
#1.  create view Emp( Ssn, Fname, Salary, Dno)
 CREATE VIEW Emp AS SELECT Ssn,Fname,Salary, Dno FROM EMPLOYEE;
 select * from Emp;
/*+-----------+----------+--------+-----+
| Ssn       | Fname    | Salary | Dno |
+-----------+----------+--------+-----+
| 123456789 | John     |  30000 |   5 |
| 333445555 | Franklin |  40000 |   5 |
| 453453453 | Joyce    |  25000 |   5 |
| 666884444 | Ramesh   |  38000 |   5 |
| 888665555 | James    |  55000 |   1 |
| 987654321 | Jennifer |  43000 |   4 |
| 987987987 | Ahmad    |  25000 |   4 |
| 999887777 | Alicia   |  25000 |   4 |
+-----------+----------+--------+-----+ */


#2.  create view Emp_sal( Ssn, Fname, Salary) where salary > 25000
 CREATE VIEW Emp_sal AS SELECT Ssn,Fname,Salary FROM EMPLOYEE where salary > 25000;
 select * from Emp_sal;
 /*+-----------+----------+--------+
| Ssn       | Fname    | Salary |
+-----------+----------+--------+
| 123456789 | John     |  30000 |
| 333445555 | Franklin |  40000 |
| 666884444 | Ramesh   |  38000 |
| 888665555 | James    |  55000 |
| 987654321 | Jennifer |  43000 |
+-----------+----------+--------+ */

# 3 Search view
# select employee details of Fname = John
select * from Emp where Fname = 'John';
/*+-----------+-------+--------+-----+
| Ssn       | Fname | Salary | Dno |
+-----------+-------+--------+-----+
| 123456789 | John  |  30000 |   5 |
+-----------+-------+--------+-----+*/


#4 UODATE View
# update view Emp , change Dno to 1 for Emp name =john
update Emp SET Dno = 1 where Fname = 'John';
/*+-----------+----------+--------+-----+
| Ssn       | Fname    | Salary | Dno |
+-----------+----------+--------+-----+
| 123456789 | John     |  30000 |   1 | */

# Note base table got changed..!
/*
+----------+-------+---------+-----------+------------+-------------------------+------+--------+-----------+-----+
| Fname    | Minit | Lname   | Ssn       | Bdate      | Address                 | Sex  | Salary | Super_ssn | Dno |
+----------+-------+---------+-----------+------------+-------------------------+------+--------+-----------+-----+
| John     | B     | Smith   | 123456789 | 1965-01-09 | 731 Fondren, Houston TX | M    |  30000 | 333445555 |   1 | */

#5 UUDATE BASE TABLE
# Change DNo of John to 4

update EMPLOYEE SET Dno = 4 where Fname = 'John';
/*+----------+-------+---------+-----------+------------+-------------------------+------+--------+-----------+-----+
| Fname    | Minit | Lname   | Ssn       | Bdate      | Address                 | Sex  | Salary | Super_ssn | Dno |
+----------+-------+---------+-----------+------------+-------------------------+------+--------+-----------+-----+
| John     | B     | Smith   | 123456789 | 1965-01-09 | 731 Fondren, Houston TX | M    |  30000 | 333445555 |   4 | */

# Note view got changed..!
/*+-----------+----------+--------+-----+
| Ssn       | Fname    | Salary | Dno |
+-----------+----------+--------+-----+
| 123456789 | John     |  30000 |   4 |*/

#6 Drop View
Drop view Emp_sal;

# Drop Base Table
Drop table EMPLOYEE;
# This will automatically delete view

