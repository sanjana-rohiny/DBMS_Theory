create database lab5_tables;
use lab5_tables;
SET FOREIGN_KEY_CHECKS=0;

create table Staff (sno varchar(5) primary key, name varchar(30), salary int, position varchar(30), dno varchar(5));

create table DEP (dno varchar(5) primary key, dname varchar(30), block varchar(30));

alter table Staff add constraint c123  foreign key(dno) references DEP(dno);

desc Staff;
/*
+----------+-------------+------+-----+---------+-------+
| Field    | Type        | Null | Key | Default | Extra |
+----------+-------------+------+-----+---------+-------+
| sno      | varchar(5)  | NO   | PRI | NULL    |       |
| name     | varchar(30) | YES  |     | NULL    |       |
| salary   | int         | YES  |     | NULL    |       |
| position | varchar(30) | YES  |     | NULL    |       |
| dno      | varchar(5)  | YES  | MUL | NULL    |       |
+----------+-------------+------+-----+---------+-------+
*/

desc DEP;
/*
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| dno   | varchar(5)  | NO   | PRI | NULL    |       |
| dname | varchar(30) | YES  |     | NULL    |       |
| block | varchar(30) | YES  |     | NULL    |       |
+-------+-------------+------+-----+---------+-------+
*/
insert into DEP(dno, dname, block) values
									('D100', 'HR', 'MG BLOCK'),
									('D103', 'Logistics', 'CVR BLOCK'),
									('D104', 'Banking', 'VKN BLOCK'),
									('D105', 'Marketing', 'PJN BLOCK'),
									('D101', 'Finance', 'APJ BLOCK');

insert into Staff (sno, name, salary, position, dno) values
									('SL100', 'John', 30000, 'Manager', 'D100'),
									('SL101', 'Susan', 4000, 'Manager', 'D101'),
									('SL102', 'David', 12000, 'Project Manager', 'D102'),
									('SL103', 'Ann', 5000, 'Project Manager', 'D103'),
									('SL104', 'Mary', 9000, 'Project Manager', 'D101');

select * from Staff;
/*
+-------+-------+--------+-----------------+------+
| sno   | name  | salary | position        | dno  |
+-------+-------+--------+-----------------+------+
| SL100 | John  |  30000 | Manager         | D100 |
| SL101 | Susan |   4000 | Manager         | D101 |
| SL102 | David |  12000 | Project Manager | D102 |
| SL103 | Ann   |   5000 | Project Manager | D103 |
| SL104 | Mary  |   9000 | Project Manager | D101 |
+-------+-------+--------+-----------------+------+
*/

 select * from DEP;
/*
+------+-----------+-----------+
| dno  | dname     | block     |
+------+-----------+-----------+
| D100 | HR        | MG BLOCK  |
| D101 | Finance   | APJ BLOCK |
| D103 | Logistics | CVR BLOCK |
| D104 | Banking   | VKN BLOCK |
| D105 | Marketing | PJN BLOCK |
+------+-----------+-----------+
*/

# SUB QUERY
	# - NON CORRELATED Sub query
	# - CORRELATED Sub query
    
# NON CORRELATED SUB QUERY - Outer query is executed after executing Inner query
	# - Single Row  Sub query
    # - Multiple Row Sub query
    
# --------------NON CORRELATED SUB QUERY------------------------------------------
#=============================================================================    
# SINGLE ROW SUB QUERY
#=============================================================================

#1 Get the employee details from the table employee having the highest salary
select  * from Staff where salary = (select max(salary) from Staff);
/*
+-------+------+--------+----------+------+
| sno   | name | salary | position | dno  |
+-------+------+--------+----------+------+
| SL100 | John |  30000 | Manager  | D100 |
+-------+------+--------+----------+------+
*/

#2 Get the employee details from the table employee having the lowest salary
select  * from Staff where salary = (select min(salary) from Staff);

#3. find the name of employee having hidhest salary
/*
+------+--------+
| name | salary |
+------+--------+
| John |  30000 |
+------+--------+
*/

# MULTIPLE ROW SUB QUERY
#===========================================================================
/*
A multiple row subquery is a SQL query that returns more than one row as its result, 
and it is used within another SQL statement as a subquery to filter or transform the results of the outer query.
*/
# insert one more row with mary, this is to show the use of "IN" clause instead of "="
insert into Staff values('SL110', 'Mary', 10000, 'Manager' , 'D100');

#4. Get the staff details whose department is same as the department of the employee ‘Mary’
SELECT * FROM Staff where dno = (select dno from Staff where name = 'Mary');

SELECT * FROM Staff where dno IN (select dno from Staff where name = 'Mary');

#5 Get the details of employee working in any of the dept
select * from Staff where dno in (select dno from DEP);

#6 Get the name and position of the employee working in Finance dept
select name,position FROM Staff WHERE dno IN (SELECT dno FROM DEP WHERE dname='Finance');

#7 Get the average salary of staffs working in Finance dept
 SELECT AVG(salary) FROM Staff WHERE dno IN (SELECT dno FROM DEP WHERE dname='Finance');
 
#8 Get the details of block in which Ann is working
SELECT block FROM DEP WHERE dno IN (SELECT dno FROM Staff WHERE name='Ann');
 
#9 Get the name of position working in APJ block
SELECT position FROM Staff WHERE dno IN (SELECT dno FROM DEP WHERE block='APJ BLOCK');

#10 Retrieve details of employees whose salary is less than the salary of the employee whose empno =SL100
select * from Staff where salary < (select salary from Staff where sno = 'SL100');

#11 Retrieve ename, job, salary of the employees whose job is same as that of ‘Ann’
select name, position, salary from Staff where position = (select position  from Staff where name = 'Ann');
/*+-------+-----------------+--------+
| name  | position        | salary |
+-------+-----------------+--------+
| David | Project Manager |  12000 |
| Ann   | Project Manager |   5000 |
| Mary  | Project Manager |   9000 |
+-------+-----------------+--------+
*/

#12 Find the names of all staff members who work in the same department as staff member SL101 
SELECT name FROM Staff WHERE dno = (   SELECT dno   FROM Staff   WHERE sno = 'SL101' );

#13 Retrieve ename, position, salary of the employees whose position is same as that of ‘Ann’\
select name, position , salary from Staff where position = (select position from Staff where name = 'Ann');
#OR
select name, position , salary from Staff where position IN (select position from Staff where name = 'Ann');

#14 Retrieve ename, position, salary of the employees whose salary is less than the salary of the employee whose empno = SL104
select name, position, salary from Staff where salary < (select salary from Staff where sno = 'SL104');



# --------------CORRELATED SUB QUERY------------------------------------------
/*A correlated subquery in DBMS is a type of subquery that refers to a column from a table in the outer query. 
It is a query that depends on another query's result set to complete its operation.

In a correlated subquery, the inner query executes repeatedly for every row of the outer query. 
The output of the inner query is then used to filter or join the result set of the outer query. 
The inner query is called a "correlated" subquery because it refers to the outer query's table columns, 
and the execution of the inner query is dependent on the outer query. */
#================================================================================= 

#15 select department name that does not have even a single employee
select dname from DEP d where NOT EXISTS (select s.name from Staff s where d.dno = s.dno);

#16 select department name that have atleast one employee
select d.dname from DEP d where EXISTS (select s.name from Staff s where d.dno = s.dno);

#17 Get the details of employee working in any of the dept
select * from Staff where EXISTS(select dname from DEP where Staff.dno = DEP.dno);
 
#18 Get the name and position of the employee working in FINANCE dept
SELECT name,position FROM Staff WHERE EXISTS(SELECT * FROM DEP WHERE Staff.dno=DEP.dno AND dname='FINANCE');
#OR --> 
select Staff.name, Staff.position from Staff natural Join DEP where DEP.dname = 'Finance';

##20 Get the average salary of staffs working in Finance dept
select avg(Staff.salary) from Staff where EXISTS (select * from DEP where Staff.dno = DEP.dno and DEP.dname = 'Finance');
#OR
select DEP.dname, avg(Staff.salary) from DEP natural join Staff where DEP.dname = 'Finance';

#21 Get the details of block in which Ann is working
select * from DEP where EXISTS ( select * from Staff where DEP.dno = Staff.dno and Staff.name = 'Ann');

#22 Get the name of position working in APJ block
select position from Staff where EXISTS (select * from DEP where Staff.dno = DEP.dno and block = 'APJ BLOCK');

#23 Find the names of all staff members who earn a salary greater than the average salary of their department
select S1.name,  S1.salary from Staff S1  where S1.salary > (select AVG(salary) from Staff S2 where S1.dno = S2.dno);
/*+------+
| name |
+------+
| John |
| Mary |
+------+*/

##24 Find the average salary of all staff members who work in departments located in the same block as department 'D100':
SELECT AVG(salary) 
FROM Staff 
WHERE dno IN (   SELECT dno   FROM DEP   WHERE block = (
					SELECT block     FROM DEP     WHERE dno = 'D100'   ) );

##25 Find the names of all staff members who work in departments with no staff members earning more than $100,000:
SELECT name FROM Staff s1 WHERE NOT EXISTS (   SELECT *   FROM Staff s2   WHERE s1.dno =
s2.dno AND salary > 100000 );


