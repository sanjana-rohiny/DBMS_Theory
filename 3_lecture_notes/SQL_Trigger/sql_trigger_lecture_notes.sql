
create database Test_Trigger;
use Test_Trigger;
SET FOREIGN_KEY_CHECKS=0;

create table Staff (sno varchar(5) , name varchar(30), salary int, position varchar(30), dno varchar(5));
create table DEP (dno varchar(5) , dname varchar(30), block varchar(30));

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
									('SL104', 'Mary', 9000, 'Project Manager', 'D101'),
									('SL110', 'Mary', 10000, 'Manager' , 'D100');

create table Account(id int primary key, name varchar(20), bal int);
insert into Account values(100, 'Alice', 200);
insert into Account values(101, 'Bob', 300);
insert into Account values(102, 'Cindy', 500);

/*
CREATE TRIGGER <trigger name>
(AFTER|BEFORE) <trigger event> ON
<table name>
[FOR EACH ROW]
[WHEN <condition>]
<trigger action>
*/

# Trigger 1
/*
	Restrict insert operation, if the new account balance is a -ve value
*/
DELIMITER //
create trigger trigger1 before insert on Account
for each row
begin
if (new.bal < 0 ) then
signal sqlstate '45000' set message_text = 'Error..! Transaction Not Allowed - Balance should be positive integer';
end if;
end //
DELIMITER ;

# this sql command will be restricted by trigger
insert into Account values(103, 'Sam', -500);

insert into Account values(103, 'Sam', -500);
/*
ERROR 1644 (45000): Error..! Transaction Not Allowed - Balance should be positive integer
*/
# Trigger 2
/*
	Restrict insert operation, if the new account Salary < 3000
*/
DELIMITER //
create trigger Staff_trigger1 before insert on Staff
for each row
begin
if (new.salary < 3000 ) then
signal sqlstate '45000' set message_text = 'Error..! Transaction Not Allowed : Salary must be > 30000';
end if;
end //
DELIMITER ;

# this sql command will be restricted by trigger
insert into Staff values('SL104', 'Sam', 2000, 'Project Manager', 'D101');

# Trigger 3
/*
	Restrict update operation, if the new salary is less than old salary
*/
DELIMITER //
create trigger Staff_trigger2 before update on Staff
for each row
begin
if (new.salary < old.salary ) then
signal sqlstate '45000' set message_text = 'Error..! Transaction Not Allowed : New Salary must be > Old Salary ';
end if;
end //
DELIMITER ;

# this sql command will be restricted by trigger
update Staff set salary = 2000 where name = 'John';


# Trigger 4
/*
	the total and average of specified marks
	is automatically inserted whenever a record is insert
*/
create table Student(
			id int primary key, 
            name varchar(20), 
            subject1 int, 
            subject2 int, 
            subject3 int,
            total int,
            percentage int);
            
DELIMITER //
create trigger Student_trigger1 before insert on Student
for each row
begin
 set new.total = new.subject1 + new.subject2 + new.subject3,
    new.percentage = new.total * 60 / 100;
end //
DELIMITER ; 

# below insert will automatically update total and percentage value by the trigger. 
insert into Student (id, name, subject1, subject2, subject3) values( 1, 'Alice', 20, 20, 20);

select * from Student;
# note total and percentage columns automatically updated by trigger
/*+----+-------+----------+----------+----------+-------+------------+
| id | name  | subject1 | subject2 | subject3 | total | percentage |
+----+-------+----------+----------+----------+-------+------------+
|  1 | Alice |       20 |       20 |       20 |    60 |         36 |
+----+-------+----------+----------+----------+-------+------------+*/
