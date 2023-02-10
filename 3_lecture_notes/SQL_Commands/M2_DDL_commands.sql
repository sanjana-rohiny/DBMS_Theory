
CREATE DATABaSE lab5_tables;
USE lab5_tables; 

/*
	DDL stands for Data Definition Language and refers to a set of SQL commands used to 
	define the structure and properties of database objects such as tables, indexes, views, 
	procedures, and triggers. DDL commands are used to create, modify, and delete database 
	objects and their associated attributes.

	Some of the commonly used DDL commands in SQL include:

	1. CREATE: This command is used to create a new database object such as a table, index, view, or procedure.
	2. ALTER: This command is used to modify the structure or properties of an existing database object such as 
		   adding a new column to a table or changing the data type of an existing column.
	3. DROP: This command is used to delete an existing database object such as a table or view.
	4. TRUNCATE: This command is used to delete all the data in a table without deleting the table structure.
*/


# 1. CREATE 
# Syntax
/*
		create table R(A1 D1, A2 D2....An Dn,
                       (integrity constraint1),
                       (integrity constraint2),
                       ...
                       (integrity constraintn));
*/

# Create Dept tables
CREATE TABLE Dept (
				dnumber int, 
                dname VARCHAR(30), 
                location VARCHAR(30),
                primary key(dnumber));

# Create Employee tables
CREATE TABLE Emp (
				eno int, 
                ename VARCHAR(30), 
                Dno int,
                primary key(eno),
                foreign key(dno) references Dept(dnumber));
                
# Display Tables
SHOW TABLES;

#=======================================ALTER COMMAND===================================================

#2. ALTER 
/*	Usage : ADD, MODIFY, DROP, RENAME

	The ALTER command in SQL is a Data Definition Language (DDL) command used to modify the structure 
	or properties of an existing database object. The ALTER command can be used to add, modify, 
	or drop columns, indexes, constraints, or other attributes of a table, view, or other database object.
*/

# 2.1 ALTER TABLE - ADD New Column
#---------------------------------
# 	Syntax : ALTER TABLE TableName ADD COLUMN column_name

ALTER TABLE Emp ADD COLUMN Gender VARCHAR(1);

# describe table : THis will show new attribute Gender
desc Emp;

# 2.3 ALTER TABLE - MODIFY Column
#-------------------------------
# 	Syntax : ALTER TABLE TableName MODIFY COLUMN column_name

ALTER TABLE Emp MODIFY COLUMN Gender VARCHAR(3);

# describe table : THis will show , attribute Gender modified to VARCHAR(3) from VARCHAR(1)
desc Emp; 

# 2.3 ALTER TABLE - RENAME Column
#--------------------------------
# 	Syntax : ALTER TABLE TableName RENAME COLUMN old_column_name TO new_column_name

ALTER TABLE Emp RENAME COLUMN Gender TO Sex;

# describe table : THis will show , attribute Gender Modified to Sex
desc Emp; 

# 2.4 ALTER TABLE - DROP Column
#------------------------------
# 	Syntax : ALTER TABLE TableName DROP COLUMN column_name

ALTER TABLE Emp DROP COLUMN Sex;

# describe table : THis will show , attribute Sex is deleted
desc Emp; 

#=======================================TRUNCATE COMMAND===================================================
# 3. TRUNCATE : 
/*  In SQL, the TRUNCATE command is a Data Definition Language (DDL) command used to remove all data from a 
    table, but keep the table structure intact. When you use the TRUNCATE command on a table, it will delete 
    all rows from the table and reset the identity seed of the table (if it has one) to its initial value.

	Synatax: TRUNCATE TABLE table_name;
	Where "table_name" is the name of the table you want to truncate.
*/

# insert few data
INSERT INTO Dept VALUES (100, 'Human Resource', 'Delhi');
INSERT INTO Dept VALUES (101, 'Pay Roll', 'Bangalore');
INSERT INTO Dept VALUES (102, 'Finance', 'Delhi');

# Display the contents of Dept. This will priit all rows of Dept table
SELECT * FROM Dept;
 
# Empy table using truncate command.  
TRUNCATE TABLE Dept;
# However, this will not work because Dept is referenced in Emp table as Referential Integrity constraint.

#=======================================DROP COMMAND===================================================
# DROP TABLE: Delete table from Database.alter
/*
    In SQL, the DROP command is a Data Definition Language (DDL) command used to delete a database object, 
    such as a table, view, index, or stored procedure, from a database. When you use the DROP command on an object, 
    it permanently removes the object and all associated data from the database.

	Here is the basic syntax of the DROP command:

	DROP OBJECT_TYPE object_name;

	Where "OBJECT_TYPE" is the type of object you want to drop, such as TABLE, VIEW, INDEX, 
    or PROCEDURE, and "object_name" is the name of the object you want to drop.
*/

# delete table
DROP TABLE Emp;

# Thos will confirm, Emp table has been deleted.
SHOW TABLES;
