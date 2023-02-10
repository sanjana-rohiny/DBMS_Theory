CREATE TABLE employee (
    ID INT PRIMARY KEY,
    person_name VARCHAR(100),
    street VARCHAR(100),
    city VARCHAR(100)
);

CREATE TABLE works (
    ID INT,
    company_name VARCHAR(100),
    salary DECIMAL(10, 2),
    FOREIGN KEY (ID) REFERENCES employee(ID)
);

CREATE TABLE company (
    company_name VARCHAR(100) PRIMARY KEY,
    city VARCHAR(100)
);

CREATE TABLE manages (
    ID INT,
    manager_id INT,
    FOREIGN KEY (ID) REFERENCES employee(ID),
    FOREIGN KEY (manager_id) REFERENCES employee(ID)
);

INSERT INTO employee (ID, person_name, street, city) VALUES
(1, 'Alice Johnson', '123 Maple St', 'New York'),
(2, 'Bob Smith', '456 Oak St', 'Los Angeles'),
(3, 'Carol White', '789 Pine St', 'Chicago');

INSERT INTO works (ID, company_name, salary) VALUES
(1, 'Tech Innovations', 70000.00),
(2, 'Health Solutions', 65000.00),
(1, 'First Bank Corporation', 72000.00),
(3, 'First Bank Corporation', 68000.00);

INSERT INTO company (company_name, city) VALUES
('Tech Innovations', 'San Francisco'),
('Health Solutions', 'San Diego'),
('First Bank Corporation', 'New York');

INSERT INTO manages (ID, manager_id) VALUES
(1, 2),  -- Bob Smith manages Alice Johnson
(3, 1);  -- Alice Johnson manages Carol White

#i)Find the employees whose name starts with ‘C’

	SELECT * FROM employee WHERE person_name  LIKE  'C%';

#ii) Find the name of managers of each company
	SELECT  C.company_name, E.person_name  
	FROM company C, works W, manages M, employee E 
	WHERE 	C.company_name = W.company_name AND W.ID = M.ID AND M.manager_id = E.ID;
	
#iii) Find the ID, name, and city of residence of employees who works for “First Bank Corporation” and earns more than Rs50000

	SELECT E.ID, E.person_name, E.city
	FROM employee E, works W
	WHERE E.ID = W.ID
	AND W.company_name = 'First Bank Corporation'
	AND W.salary > 50000;

#iv) Find the name of companies whose employees earn a higher salary, on average, than the average salary at “First Bank Corporation”

	SELECT W.company_name
	FROM works W
	GROUP BY W.company_name
	HAVING AVG(W.salary) > (
    		SELECT AVG(W2.salary)
    		FROM works W2
    		WHERE W2.company_name = 'First Bank Corporation'
	);

