
# Get the name of the staff working in HR department
select Staff.name from DEP natural join Staff where DEP.dname = 'HR';

# Get the average salary of staffs working in Finance dept
select AVG(Staff.salary) 
from DEP natural join Staff 
where DEP.dname = 'Finance';

# Get the details of block in which Ann is working
select * 
from DEP, Staff 
where Staff.dno = DEP.dno and Staff.name = 'Ann';


# Get the name of position working in APJ block
select Staff.position 
from Staff natural join DEP 
where DEP.block = 'APJ BLOCK';

# query-1 FInd count of staff members in each department 
select DEP.dname, count(Staff.sno) from DEP left join Staff ON DEP.dno = Staff.dno group by DEP.dname;
select DEP.dname, count(Staff.sno) from Staff right join DEP ON DEP.dno = Staff.dno group by DEP.dname;

#Query 2. Retrieve the staff members who are not assigned to any department:
SELECT s.sno, s.name, s.salary, s.position, d.dno, d.dname, d.block FROM Staff s LEFT JOIN DEP d ON s.dno = d.dno  WHERE d.dno IS NULL;
SELECT s.sno, s.name, s.salary, s.position, d.dno, d.dname, d.block FROM DEP d right JOIN Staff s ON s.dno = d.dno  WHERE d.dno IS NULL;

