CREATE DATABaSE lab5_tables;
USE lab5_tables; 

/*
	DEFINING INTEGRITY CONSTRAINTS
		1. USING CREATE TABLE
		2. USING ALTER TABLE COMMAND
    
    TYPES OF INTEGRITY CONSTRAINTS
		1. Entity Integrity Constraints
		2. Domain Integrity Constraints
		3. Referential Integrity COnstraints
        
	Delete Constraint
		Uaing alter command
        Synatax: ALTER TABLE table_name DROP CONSTRAINT constraint_name;
*/

/*. Integrity Constraints.
	1.1. Primary Key
    1.2. Foreign Key
    1.3. Not Null 
*/

#1.1. Primary Key constraints
#----------------------------
	#1. Using Create table - Method 1
    CREATE TABLE Emp (
		    eno INT PRIMARY KEY,
		    ename CHAR(30),
                    dno int);
	
    #2. Using Create table - Method 2
    drop table Emp; # Deleting table, just to avoid ERROR 1050 (42S01): Table 'Emp' already exists
	CREATE TABLE Emp (
			eno INT,
			ename CHAR(30),
                    	dno int,
                    	PRIMARY KEY(eno));
    
    #3. Using alter table
	drop table Emp; # Deleting table, just to avoid ERROR 1050 (42S01): Table 'Emp' already exists
    	CREATE TABLE Emp (
			eno INT,
			ename CHAR(30),
                    	dno int);
                    	
	ALTER TABLE Emp ADD CONSTRAINT Emp_constraint1 PRIMARY KEY(Eno);
	# Confirm primary key is set
    	describe Emp;
    
#1.2. Foreign Key constraints or Referential Integrity
#-----------------------------------------------------   
	#1. Using Create table - Method 1
	drop table Emp; # Deleting table, just to avoid ERROR 1050 (42S01): Table 'Emp' already exists
    	CREATE TABLE Emp (
			eno INT PRIMARY KEY,
			ename CHAR(30),
			dno INT REFERENCES Dept(dnumber));

	#2. Using Create table - Method 2
    	drop table Emp; # Deleting table, just to avoid ERROR 1050 (42S01): Table 'Emp' already exists
    	CREATE TABLE Emp (
			eno INT PRIMARY KEY,
			ename CHAR(30),
                        dno int,
    	                foreign key(dno) references Dept(dnumber));
	
    #3. Using Create table - Method 2
    	drop table Emp; # Deleting table, just to avoid ERROR 1050 (42S01): Table 'Emp' already exists
	CREATE TABLE Emp (
			eno INT,
			ename CHAR(30),
	                dno int,
                        PRIMARY KEY(eno));
                        
	ALTER TABLE Emp ADD CONSTRAINT Emp_constraint2 FOREIGN KEY(Eno) REFERENCES Dept(dnumber);
    
#1.3. NOT NULL constraints 
#--------------------------
	drop table Emp; # Deleting table, just to avoid ERROR 1050 (42S01): Table 'Emp' already exists
    	CREATE TABLE Emp (
			eno INT PRIMARY KEY,
			ename CHAR(30) NOT NULL,
			dno INT REFERENCES Dept(dnumber));
	# here not null is set to ename attribute.
    # Now INSERT command will not acept any NULL value to ename attribute.alter
    
    
    # Using alter command
    ALTER TABLE Emp MODIFY COLUMN ename CHAR(30) NOT NULL;
    
    
    # Delete Constraint
    #==================
    
    # 1. Delete Primary key    
	 ALTER TABLE Emp DROP PRIMARY KEY;
    
    # 2. Delete foreign Key
        # Here we need to get the Constraint name.
        # In this ecxample the constraint name is known , as Emp_constraint2
        ALTER TABLE Emp DROP CONSTRAINT Emp_constraint2;
        
        # otehrwise execute below command to get constraint name, and followed by above command.
        SHOW CREATE TABLE Emp;
        
        
