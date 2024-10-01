USE Practice;
--Exercise 1: Create a Table for Students
CREATE TABLE Students (
    student_id INT IDENTITY(1,1) PRIMARY KEY, 
    name VARCHAR(100),                      
    gender CHAR(1) CHECK (gender IN ('M', 'F')),  
    age INT CHECK (age BETWEEN 5 AND 100)    
);

--Exercise 2: Insert Data into the Students Table
INSERT INTO Students (name, gender, age)
VALUES 
('Arjun Kumar', 'M', 18),  
('Priya Sharma', 'F', 22),  
('Ravi Verma', 'M', 15),  
('Sita Reddy', 'F', 28),    
('Anjali Patel', 'F', 30);   

Select * from Students;
--Exercise 3: Create a Table for Subjects
CREATE TABLE Subjects (
    subject_id INT IDENTITY(1,1) PRIMARY KEY, 
    subject_name NVARCHAR(100) NOT NULL   
);

--Exercise 4: Insert Data into Subjects Table
INSERT INTO Subjects (subject_name)
VALUES 
('Mathematics'), 
('Physics'), 
('Chemistry'), 
('Biology');

--Exercise 5: Create a Table for Enrollments with Foreign Keys
CREATE TABLE Enrollments (
    enrollment_id INT IDENTITY(1,1) PRIMARY KEY, 
    student_id INT,                             
    subject_id INT,                             
    enrollment_date DATE DEFAULT GETDATE(),    
    CONSTRAINT FK_Student FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE, 
    CONSTRAINT FK_Subject FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id) ON DELETE CASCADE  
);

--Exercise 6: Insert Data into Enrollments Table
-- Enroll Arjun Kumar in Mathematics
INSERT INTO Enrollments (student_id, subject_id)
VALUES (1, 1);
INSERT INTO Enrollments (student_id, subject_id)
VALUES (1, 3);

-- Enroll Priya Sharma in Physics
INSERT INTO Enrollments (student_id, subject_id)
VALUES (2, 2);
INSERT INTO Enrollments (student_id, subject_id)
VALUES (2, 4);

-- Enroll Ravi Verma in Chemistry
INSERT INTO Enrollments (student_id, subject_id)
VALUES (3, 3);
INSERT INTO Enrollments (student_id, subject_id)
VALUES (3, 1);

-- Enroll Sita Reddy in Biology
INSERT INTO Enrollments (student_id, subject_id)
VALUES (4, 4);
INSERT INTO Enrollments (student_id, subject_id)
VALUES (4, 2);

-- Enroll Anjali Patel in Mathematics
INSERT INTO Enrollments (student_id, subject_id)
VALUES (5, 1);
INSERT INTO Enrollments (student_id, subject_id)
VALUES (5,3);

Select * from Enrollments;

--Exercise 7: Update Student Age
UPDATE Students
SET age = 23
WHERE name = 'Arjun Kumar';

--Exercise 8: Create a Table for Marks
CREATE TABLE Marks (
    student_id INT,                              
    subject_id INT,                              
    marks INT CHECK (marks BETWEEN 0 AND 100),    
    CONSTRAINT FK_Marks_Student FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    CONSTRAINT FK_Marks_Subject FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id) ON DELETE CASCADE
);

--Exercise 9: Insert Data into Marks Table
-- Insert marks for Arjun Kumar
INSERT INTO Marks (student_id, subject_id, marks)
VALUES 
(1, 1, 85),
(1, 2, 90); 

-- Insert marks for Priya Sharma
INSERT INTO Marks (student_id, subject_id, marks)
VALUES 
(2, 1, 78), 
(2, 3, 88);  

-- Insert marks for Ravi Verma
INSERT INTO Marks (student_id, subject_id, marks)
VALUES 
(3, 2, 92), 
(3, 4, 76);  

Select * from Marks;

--Exercise 10: Add a New Column to an Existing Table
ALTER TABLE Students
ADD email VARCHAR(255);

--Exercise 11: Update the Email Address for a Student
UPDATE Students
SET email = 'arjun.kumar@gmail.com'
WHERE name = 'Arjun Kumar';

--Exercise 12: Remove a Foreign Key Constraint
ALTER TABLE Marks
DROP CONSTRAINT FK_Marks_Subject;

--Exercise 13: Add a Check Constraint
ALTER TABLE Marks
ADD CONSTRAINT CHK_Marks_Range CHECK (marks BETWEEN 0 AND 100);


--Exercise 14: Add On Delete Cascade to a Foreign Key
ALTER TABLE Marks
DROP CONSTRAINT FK_Marks_Student;

ALTER TABLE Marks
ADD CONSTRAINT FK_Marks_Student 
FOREIGN KEY (student_id) REFERENCES Students(student_id)
ON DELETE CASCADE;


CREATE TABLE Employees (
    employee_id INT PRIMARY KEY IDENTITY(1,1),
    employee_name VARCHAR(255) NOT NULL,
    manager_id INT,
    FOREIGN KEY (manager_id) REFERENCES Employees(employee_id) ON DELETE NO ACTION
);

--Task 15
SELECT 
    s.name,
    sub.subject_name
FROM 
    Students s
LEFT JOIN 
    Enrollments e ON s.student_id = e.student_id
LEFT JOIN 
    Subjects sub ON e.subject_id = sub.subject_id;

--Task 16
SELECT 
    s.name,
    sub.subject_name
FROM 
    Students s
LEFT JOIN 
    Enrollments e ON s.student_id = e.student_id
LEFT JOIN 
    Subjects sub ON e.subject_id = sub.subject_id;

--Task 17
SELECT 
    sub.subject_name,
    s.name
FROM 
    Subjects sub
LEFT JOIN 
    Enrollments e ON sub.subject_id = e.subject_id
LEFT JOIN 
    Students s ON e.student_id = s.student_id;

--Task 18
SELECT 
    s.name,
    sub.subject_name
FROM 
    Students s
FULL OUTER JOIN 
    Enrollments e ON s.student_id = e.student_id
FULL OUTER JOIN 
    Subjects sub ON e.subject_id = sub.subject_id;

--Task 19
SELECT 
    s.name,
    sub.subject_name
FROM 
    Students s
CROSS JOIN 
    Subjects sub;

--Task 20
SELECT 
    s.name,
    COALESCE(SUM(m.marks), 0) AS total_marks
FROM 
    Students s
LEFT JOIN 
    Enrollments e ON s.student_id = e.student_id
LEFT JOIN 
    Marks m ON e.subject_id = m.subject_id AND e.student_id = m.student_id
GROUP BY 
    s.name;

--Task 21
SELECT 
    e.employee_name AS Employee_Name,
    m.employee_name AS Manager_Name
FROM 
    Employees e
LEFT JOIN 
    Employees m ON e.manager_id = m.employee_id;

--Task 22
SELECT 
    s.name,
    sub.subject_name,
    m.marks
FROM 
    Students s
JOIN 
    Enrollments e ON s.student_id = e.student_id
JOIN 
    Marks m ON e.student_id = m.student_id AND e.subject_id = m.subject_id
JOIN 
    Subjects sub ON e.subject_id = sub.subject_id;

--Taask 23
SELECT 
    sub.subject_name,
    AVG(m.marks) AS average_marks
FROM 
    Marks m
JOIN 
    Enrollments e ON m.student_id = e.student_id AND m.subject_id = e.subject_id
JOIN 
    Subjects sub ON e.subject_id = sub.subject_id
GROUP BY 
    sub.subject_name

--Task 24
SELECT 
    s.name,
    COUNT(e.subject_id) AS subject_count
FROM 
    Students s
JOIN 
    Enrollments e ON s.student_id = e.student_id
GROUP BY 
    s.name
HAVING 
    COUNT(e.subject_id) > 2;

HAVING 
    AVG(m.marks) > 70;


SELECT 
    s.name
FROM 
    Students s
WHERE 
    s.student_id IN (
        SELECT 
            e.student_id
        FROM 
            Enrollments e
    );

SELECT 
    m.student_id
FROM 
    Marks m
WHERE 
    m.marks > (
        SELECT 
            MAX(m2.marks)
        FROM 
            Marks m2
        JOIN 
            Subjects s ON m2.subject_id = s.subject_id
        WHERE 
            s.subject_name = 'Mathematics'
    );

SELECT 
    m.student_id
FROM 
    Marks m
WHERE 
    m.marks > (
        SELECT 
            AVG(m2.marks)
        FROM 
            Marks m2
        JOIN 
            Subjects s ON m2.subject_id = s.subject_id
        WHERE 
            s.subject_name = 'Physics'
    );
