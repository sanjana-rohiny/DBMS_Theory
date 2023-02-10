create database lab5_tables;
use lab5_tables;
SET FOREIGN_KEY_CHECKS=0;

 
#alter table Staff add constraint c123  foreign key(dno) references DEP(dno);

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

#==========================aggregate functions========================================
#=====================================================================================

#Query-1 : Find total/sum of managers salary
select sum(salary) from Staff where position = 'Manager';
/*+-------------+
| sum(salary) |
+-------------+
|       45000 |
+-------------+*/

#Query-2 : Find Avarage of Project managers salary
select avg(salary) from Staff where position = 'Project Manager';
/*+-------------+
| avg(salary) |
+-------------+
|   8666.6667 |
+-------------+*/

#Query-3 : Find MIN and Max of Staff salary
select min(salary), max(salary) from Staff;
/*+-------------+-------------+
| min(salary) | max(salary) |
+-------------+-------------+
|        5000 |       30000 |
+-------------+-------------+ */

#Query-4 : Find count of Staff who are managers
select count(*) from Staff where position = 'Manager';
/*+----------+
| count(*) |
+----------+
|        3 |
+----------+*/

#Query-5 : Find count managers and their total salary
select count(sno), sum(salary) from Staff where position = 'Manager';
/*+------------+-------------+
| count(sno) | sum(salary) |
+------------+-------------+
|          3 |       45000 |
+------------+-------------+*/


#=============================ORDER BY===========================================

#Query-6 : Select all staff members in ascending order by their name:
SELECT * FROM Staff ORDER BY name ASC;
/*+-------+-------+--------+-----------------+------+
| sno   | name  | salary | position        | dno  |
+-------+-------+--------+-----------------+------+
| SL103 | Ann   |   5000 | Project Manager | D103 |
| SL102 | David |  12000 | Project Manager | D102 |
| SL100 | John  |  30000 | Manager         | D100 |
| SL104 | Mary  |   9000 | Project Manager | D101 |
| SL110 | Mary  |  10000 | Manager         | D100 |
| SL101 | Susan |   5000 | Manager         | D101 |
+-------+-------+--------+-----------------+------+*/

##Query-7 :Select all staff members in descending order by their salary:
SELECT * FROM Staff ORDER BY salary DESC;
/*+-------+-------+--------+-----------------+------+
| sno   | name  | salary | position        | dno  |
+-------+-------+--------+-----------------+------+
| SL100 | John  |  30000 | Manager         | D100 |
| SL102 | David |  12000 | Project Manager | D102 |
| SL110 | Mary  |  10000 | Manager         | D100 |
| SL104 | Mary  |   9000 | Project Manager | D101 |
| SL101 | Susan |   5000 | Manager         | D101 |
| SL103 | Ann   |   5000 | Project Manager | D103 |
+-------+-------+--------+-----------------+------+*/

##Query-8:     Select all staff members in ascending order by their position, then by their salary:
SELECT * FROM Staff ORDER BY position ASC, salary ASC;
/*+-------+-------+--------+-----------------+------+
| sno   | name  | salary | position        | dno  |
+-------+-------+--------+-----------------+------+
| SL101 | Susan |   5000 | Manager         | D101 |
| SL110 | Mary  |  10000 | Manager         | D100 |
| SL100 | John  |  30000 | Manager         | D100 |
| SL103 | Ann   |   5000 | Project Manager | D103 |
| SL104 | Mary  |   9000 | Project Manager | D101 |
| SL102 | David |  12000 | Project Manager | D102 |
+-------+-------+--------+-----------------+------+*/

#=============================GROUP BY===========================================
# Query-8:     Find the total salary of staff in each department:
SELECT d.dname, SUM(s.salary) FROM Staff s JOIN DEP d ON s.dno = d.dno GROUP BY d.dname;
# OR
select d.dname , sum(s.salary) from Staff s natural join DEP d group by d.dname;
/*+-----------+---------------+
| dname     | SUM(s.salary) |
+-----------+---------------+
| HR        |         40000 |
| Finance   |         14000 |
| Logistics |          5000 |
+-----------+---------------+*/

# Query - 9: Count the number of staff in each department who earn a salary greater than 10000:
select DEP.dname, count(sno) from DEP, Staff where DEP.dno = Staff.dno and Staff.salary>10000 group by DEP.dname;
# OR
SELECT d.dname, COUNT(*) FROM Staff s JOIN DEP d ON s.dno = d.dno WHERE s.salary > 10000 GROUP BY d.dname;
# OR Using Natural Join
select DEP.dname, count(sno) from DEP natural join Staff where Staff.salary>10000 group by DEP.dname;

/*+-------+----------+
| dname | COUNT(*) |
+-------+----------+
| HR    |        1 |
+-------+----------+ */

# Query - 10: #     Find the average salary of staff in each position:
SELECT s.position, AVG(s.salary) FROM Staff s GROUP BY s.position;
/*+-----------------+---------------+
| position        | AVG(s.salary) |
+-----------------+---------------+
| Manager         |    15000.0000 |
| Project Manager |     8666.6667 |
+-----------------+---------------+*/

# Query - 11: Count the number of staff in each department
select DEP.dname, count(*) from Staff natural join DEP group by DEP.dname;
/*+-----------+----------+
| dname     | count(*) |
+-----------+----------+
| HR        |        2 |
| Finance   |        2 |
| Logistics |        1 |
+-----------+----------+ */

 # Query - 12:   Find the maximum salary of staff in each department:
 
 select DEP.dname, max(salary) from DEP natural join Staff group by DEP.dname;
/*+-----------+-------------+
| dname     | max(salary) |
+-----------+-------------+
| HR        |       30000 |
| Finance   |        9000 |
| Logistics |        5000 |
+-----------+-------------+*/

#=============================GROUP BY HAVING ===========================================

# Query 14: Retrieve the departments with an average salary greater than 5000:     
SELECT DEP.dname, AVG(Staff.salary) FROM DEP, Staff where  DEP.dno = Staff.dno GROUP BY DEP.dname HAVING AVG(Staff.salary) > 5000;
# OR

/*+---------+-------------------+
| dname   | AVG(Staff.salary) |
+---------+-------------------+
| HR      |        20000.0000 |
| Finance |         7000.0000 |
+---------+-------------------+*/


## Query 15:: Retrieve the departments that have more than 1 staff members:
SELECT DEP.dname, COUNT(*) as num_staff FROM DEP JOIN Staff ON DEP.dno = Staff.dno GROUP
BY DEP.dname HAVING COUNT(*) > 1;
#OR
select DEP.dname, count(sno) from DEP natural join Staff group by DEP.dname having count(sno) > 1;
/*+---------+-----------+
| dname   | num_staff |
+---------+-----------+
| HR      |         2 |
| Finance |         2 |
+---------+-----------+*/

#Query-16 Retrieve the departments with more than 1 staff members earning over 1000:
SELECT DEP.dname, COUNT(*) FROM DEP NATURAL JOIN Staff WHERE Staff.salary > 1000 GROUP BY DEP.dname HAVING COUNT(*) > 1;
/*+---------+----------+
| dname   | COUNT(*) |
+---------+----------+
| HR      |        2 |
| Finance |        2 |
+---------+----------+ */



