/*

	HOW TO CREATE AUTO INCREMENT ATTRIBUTES
*/


create table Student(
	stud_id INT AUTO_INCREMENT PRIMARY KEY,
	stud_fname VARCHAR(20),
	stud_lname VARCHAR(20),
	stud_email VARCHAR(20),
	stud_ph VARCHAR(10));
    
    ALTER TABLE Student AUTO_INCREMENT=100;

# Note , stud_id is not specified in INSERT statement. 
# it will be auto incremented from 100.    
insert into Student(stud_fname,stud_lname,stud_email,stud_ph) values('shanti','vasan','shantiv@gmail.com',9677483824);
insert into Student(stud_fname,stud_lname,stud_email,stud_ph) values('anjitha','k','anjithak@gmail.com',9574884993);
insert into Student(stud_fname,stud_lname,stud_email,stud_ph) values('riya','khan','riyakhan@gmail.com',9637833993);


select * from student;
/*
+---------+------------+------------+--------------------+------------+
| stud_id | stud_fname | stud_lname | stud_email         | stud_ph    |
+---------+------------+------------+--------------------+------------+
|     100 | shanti     | vasan      | shantiv@gmail.com  | 9677483824 |
|     101 | anjitha    | k          | anjithak@gmail.com | 9574884993 |
|     102 | riya       | khan       | riyakhan@gmail.com | 9637833993 |
+---------+------------+------------+--------------------+------------+
*/
