
# Following is the list of all useful SQL aggregate functions −
  # SQL COUNT Function - The SQL COUNT aggregate function is used to count the number of rows in a database table.
  # SQL MAX Function - The SQL MAX aggregate function allows us to select the highes (maximum) value for a certain column.
  # SQL MIN Function - The SQL MIN aggregate function allows us to select the lowest (minimum) value for a certain column.
  # SQL AVG Function - The SQL AVG aggregate function selects the average value for certain table column.
  # SQL SUM Function - The SQL SUM aggregate function allows selecting the total for a numeric column.

show databases;
create database lab5_tables;
use lab5_tables;

# Create the tables with the following fields
# Faculty (FacultyCode, FacultyName)
# Subject (SubjectCode,SubjectName,MaxMark,FacultyCode)
# Student(StudentCode,StudentName,DOB,StudentsBranch(CS/EC/EE/ME), AdmissionDate)
# M_Mark (StudentCode, SubjectCode, Mark)

create table Faculty (
		F_Code int Primary Key, 
        F_Name Varchar(15));
        
create table Subject (
		subjectcode varchar(5) primary key not null,
		subjectname char(15),
		maxmark int,
		faculty_code int,
        foreign key(faculty_code) references Faculty(f_code));
        
create table Student(
		studentcode varchar(5) primary key not null,
		studentname char(15),
		dob date,
		studentbranch char(3),
		adate date,
        check(studentbranch in('cs','ec','ee','me')));
        
create table M_mark(
		studentcode varchar(5) references Student(studentcode),
		subjectcode varchar(5) references Subject(subjectcode),
		mark int,
        primary key(studentcode,subjectcode));

# populate Faculty table
insert into Faculty(F_Code, F_Name) values(101,'Silgy');
insert into Faculty(F_Code, F_Name) values(102,'Bindu');
insert into Faculty(F_Code, F_Name) values(103,'Vidhya');
insert into Faculty(F_Code, F_Name) values(104,'Sangeetha');
insert into Faculty(F_Code, F_Name) values(105,'Jayakumar');
select * from Faculty;

# populate Subject table
insert into Subject(subjectcode,subjectname,maxmark,faculty_code) values(501,'Maths', 150, 101);
insert into Subject(subjectcode,subjectname,maxmark,faculty_code) values(502,'FCA', 100, 102);
insert into Subject(subjectcode,subjectname,maxmark,faculty_code) values(503,'DBMS', 100, 105);
insert into Subject(subjectcode,subjectname,maxmark,faculty_code) values(504, 'OS', 75, 103);
insert into Subject(subjectcode,subjectname,maxmark,faculty_code) values(505, 'DC', 200, 104);
insert into Subject(subjectcode,subjectname,maxmark,faculty_code) values(508, 'DBMSLab', 1001, 103);
select * from Subject;

# populate Student  - date format yyyy-mm-dd
insert into Student values(1,'Amitha','1987-01-12','cs','2000-06-02');
insert into Student values(2,'vaidehi','1987-01-12','cs','2000-06-02');
insert into Student values(3,'varun','1987-01-12','cs','2000-06-02');
insert into Student values(4,'turner','1987-01-12','cs','2000-06-02');
insert into Student values(5,'vani','1987-01-12','cs','2000-06-02');
insert into Student values(6,'binu','1987-01-12','cs','2000-06-02');
insert into Student values(7,'chitra','1987-01-12','cs','2000-06-02');
insert into Student values(8,'dona','1987-01-12','cs','2000-06-02');
insert into Student values(9,'elana','1987-01-12','cs','2000-06-02');
insert into Student values(10,'fahan','1987-01-12','cs','2000-06-02');
insert into Student values(11,'ginu','1987-01-12','cs','2000-06-02');
insert into Student values(12,'hamna','1987-01-12','cs','2000-06-02');
insert into Student values(13,'Alice','1987-01-12','ec','2000-06-02');
insert into Student values(14,'Bob','1987-01-12','me','2000-06-02');

select * from Student;


insert into M_mark values(1,501,40);
insert into M_mark values(1,502,70);
insert into M_mark values(1,503,50);
insert into M_mark values(1,504,80);
insert into M_mark values(1,505,40);
insert into M_mark values(1,508,70);
insert into M_mark values(2,501,90);
insert into M_mark values(2,502,89);
insert into M_mark values(2,503,77);
insert into M_mark values(2,504,95);
insert into M_mark values(2,505,74);
insert into M_mark values(2,508,98);
insert into M_mark values(3,501,40);
insert into M_mark values(3,502,43);
insert into M_mark values(3,503,40);
insert into M_mark values(3,504,40);
insert into M_mark values(3,505,40);
insert into M_mark values(3,508,35);
insert into M_mark values(4,501,50);
insert into M_mark values(5,501,60);
insert into M_mark values(6,501,67);
insert into M_mark values(7,501,23);
insert into M_mark values(8,501,43);
insert into M_mark values(9,501,42);
insert into M_mark values(10,505,74);
insert into M_mark values(11,508,98);
insert into M_mark values(12,501,40);
insert into M_mark values(5,502,43);
insert into M_mark values(6,503,40);
insert into M_mark values(7,504,40);
insert into M_mark values(8,505,40);
insert into M_mark values(9,508,35);
insert into M_mark values(10,501,50);
insert into M_mark values(11,501,60);
insert into M_mark values(12,503,67);
insert into M_mark values(5,504,23);
insert into M_mark values(6,504,23);
insert into M_mark values(9,504,1);
insert into M_mark values(10,504,1);
insert into M_mark values(6,502,43);
insert into M_mark values(7,505,42);


# query 1- Display the number of faculties.
select count(*) "No of Faculty = " from Faculty;

# query 2- Display the MAX mark.
select MAX(mark) from M_mark;

# query 3- Display the MIN mark.
select MIN(mark) from M_mark;

# query 4- Display Average mark.
select AVG(mark) from M_mark;

# query 5- Display Sum of mark.
select SUM(mark) from M_mark;

#--------------------group by------------------------#
# 1. Find the total number of students in each branch:
select studentbranch, COUNT(*) from Student group by studentbranch;

#2. find average mark of each student
select studentcode, AVG(mark) as AvgMarks from M_mark group by studentcode;

#3. find average mark of each student , also list name 
select Student.studentcode, Student.studentname, AVG(M.mark) from Student, M_mark where Student.studentcode = M_mark.studentcode group by Student.studentcode;

#4  Count the number of subjects taught by each faculty:
select faculty_code, COUNT(*) from Subject group by faculty_code;

#5 Find the maximum marks of each subject:
select subjectcode, MAX(mark) from M_mark group by subjectcode;

#6 Find the maximum marks of each subject, also list subject name
select Subject.subjectcode, Subject.subjectname , MAX(mark) from M_mark, Subject group by Subject.subjectcode;

#7  Find the number of students who have scored more than 60% of maximum marks in each subject:
select COUNT(*) from M_mark, Subject where mark >= 0.6 * Subject.maxmark group by Subject.subjectcode;

#8. Find the maximum marks of each subject and the corresponding subject code
select subjectname, MAX(M_mark.mark) from M_mark, Subject where M_mark.subjectcode = Subject.subjectcode group by subjectname;

#9. Find the average marks of each subject and the corresponding subject code
select subjectname, AVG(M_mark.mark) from M_mark natural join Subject group by subjectname;

#10 Display the total mark for each student.
select Student.studentname, sum(mark)  from Student, M_mark  where Student.studentcode = M_mark.studentcode group by Student.studentname;

#--------------------group by : having------------------------#
#1 Return the average mark for each subject, but only for subjects with an average mark greater than 40:
SELECT subjectcode, AVG(mark)  FROM M_mark GROUP BY subjectcode HAVING AVG(mark) > 40;

#2 Return the maximum and minimum marks scored by each student, but only for students who have scored more than 500 in total:
SELECT studentcode, MAX(mark) as max_mark, MIN(mark)  FROM M_mar GROUP BY studentcode HAVING SUM(mark) > 500;

#3 Return the number of students who have taken more than 3 subjects:
SELECT studentcode, COUNT(*) FROM M_mark GROUP BY studentcode HAVING COUNT(*) > 3;

#4. Return the average marks for each faculty, but only for faculties who have at least 2 subjects:
SELECT Faculty.F_Code, Faculty.F_Name, AVG(M_mark.mark) FROM Faculty, Subject , M_mark  WHERE Faculty.F_Code = Subject.faculty_code AND Subject.subjectcode = M_mark.subjectcode GROUP BY Faculty.F_Code, Faculty.F_Name

#5 Display the name of subjects for which atleast one student got below 40%
select Subject.subjectname, count(studentname) "NO: OF STUDENTS" from Subject,M_mark, Student where Student.studentcode= M_mark.studentcode and
M_mark.mark<(40* maxmark)/100 and Subject.subjectCode=M_mark.subjectcode group by Subject.Subjectname having count(distinct(M_mark.subjectcode))>=1;

