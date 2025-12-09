CREATE DATABASE SchoolDB;
GO
USE SchoolDB;
GO


CREATE TABLE Students (
    student_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    roll_number NVARCHAR(20) UNIQUE NOT NULL,
    email NVARCHAR(100) UNIQUE NOT NULL,
    phone NVARCHAR(15) UNIQUE NOT NULL,
    address NVARCHAR(200) DEFAULT 'Not Provided'
);


CREATE TABLE Faculty (
    faculty_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    email NVARCHAR(100) UNIQUE NOT NULL,
    phone NVARCHAR(15) UNIQUE NOT NULL,
    department NVARCHAR(50)
        CHECK (department IN ('Science', 'Arts', 'Commerce', 'Engineering'))
);


CREATE TABLE Courses (
    course_id INT IDENTITY(1,1) PRIMARY KEY,
    course_name NVARCHAR(100) NOT NULL,
    course_code NVARCHAR(20) UNIQUE NOT NULL,
    department NVARCHAR(50)
        CHECK (department IN ('Science', 'Arts', 'Commerce', 'Engineering')),
    credits INT CHECK (credits > 0),
    faculty_id INT NOT NULL,
    CONSTRAINT FK_Courses_Faculty
        FOREIGN KEY (faculty_id) REFERENCES Faculty(faculty_id)
);


CREATE TABLE Enrollments (
    enrollment_id INT IDENTITY(1,1) PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE DEFAULT CAST(GETDATE() AS DATE),
    grade NVARCHAR(20)
        CHECK (grade IN ('A', 'B', 'C', 'D', 'F', 'Not Graded'))
        DEFAULT 'Not Graded',
    CONSTRAINT FK_Enrollments_Students
        FOREIGN KEY (student_id) REFERENCES Students(student_id),
    CONSTRAINT FK_Enrollments_Courses
        FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

select * from students


INSERT INTO Students (student_id, name, roll_number, email, phone, address) VALUES
(1,'John Doe','101','john.doe@email.com','9876543210','123 Main St'),
(2,'Jane Smith','102','jane.smith@email.com','9823456789','45 Elm St'),
(3,'Alice Brown','103','alice.b@email.com','9988776655','78 Pine Ave'),
(4,'Bob Johnson','104','bob.j@email.com','9765432109','90 Oak Lane'),
(5,'Charlie Lee','105','charlie.l@email.com','9234567890','Not Provided'),
(6,'David White','106','david.w@email.com','9678991234','12 Maple St'),
(7,'Emily Clark','107','emily.c@email.com','9345678901','Not Provided'),
(8,'Frank Harris','108','frank.h@email.com','9763214785','56 Birch Road'),
(9,'Grace Kelly','109','grace.k@email.com','9456123870','32 Cedar Ave'),
(10,'Henry Adams','110','henry.a@email.com','9312465789','22 Walnut Lane');


SET IDENTITY_INSERT Students ON;

INSERT INTO Students (student_id, name, roll_number, email, phone, address) VALUES
(1,'John Doe','101','john.doe@email.com','9876543210','123 Main St'),
(2,'Jane Smith','102','jane.smith@email.com','9823456789','45 Elm St'),
(3,'Alice Brown','103','alice.b@email.com','9988776655','78 Pine Ave'),
(4,'Bob Johnson','104','bob.j@email.com','9765432109','90 Oak Lane'),
(5,'Charlie Lee','105','charlie.l@email.com','9234567890','Not Provided'),
(6,'David White','106','david.w@email.com','9678991234','12 Maple St'),
(7,'Emily Clark','107','emily.c@email.com','9345678901','Not Provided'),
(8,'Frank Harris','108','frank.h@email.com','9763214785','56 Birch Road'),
(9,'Grace Kelly','109','grace.k@email.com','9456123870','32 Cedar Ave'),
(10,'Henry Adams','110','henry.a@email.com','9312465789','22 Walnut Lane');

SET IDENTITY_INSERT Students OFF;


SET IDENTITY_INSERT Faculty ON;

INSERT INTO Faculty (faculty_id, name, email, phone, department) VALUES
(1,'Dr. Smith','smith@univ.com','9876543211','Science'),
(2,'Dr. Johnson','johnson@univ.com','9823456781','Arts'),
(3,'Dr. Williams','williams@univ.com','9988776611','Commerce'),
(4,'Dr. Brown','brown@univ.com','9765432191','Engineering'),
(5,'Dr. Davis','davis@univ.com','9234567811','Science');

SET IDENTITY_INSERT Faculty OFF;

SET IDENTITY_INSERT Courses ON;

INSERT INTO Courses (course_id, course_name, course_code, department, credits, faculty_id) VALUES
(1,'Mathematics','MATH101','Science',4,1),
(2,'English Literature','ENG102','Arts',3,2),
(3,'Economics','ECO103','Commerce',4,3),
(4,'Computer Science','CS104','Engineering',4,4),
(5,'Physics','PHY105','Science',3,5);

SET IDENTITY_INSERT Courses OFF;


SET IDENTITY_INSERT Enrollments ON;

INSERT INTO Enrollments (enrollment_id, student_id, course_id, enrollment_date, grade) VALUES
(1,1,1,'2024-01-15','A'),
(2,2,2,'2024-01-16','B'),
(3,3,3,'2024-01-17','A'),
(4,4,4,'2024-01-18','C'),
(5,5,5,'2024-01-19','B'),
(6,6,1,'2024-01-20','A'),
(7,7,2,'2024-01-21','C'),
(8,8,3,'2024-01-22','B'),
(9,9,4,'2024-01-23','A'),
(10,10,5,'2024-01-24','B');

SET IDENTITY_INSERT Enrollments OFF;

SELECT DISTINCT department
FROM Faculty;


SELECT *
FROM Enrollments
WHERE grade = 'C';


SELECT TOP 2 *
FROM Enrollments
ORDER BY enrollment_date DESC;

select * from Enrollments
ORDER BY enrollment_date DESC;

select * from Courses

UPDATE Courses
SET credits = credits -1
WHERE department = 'Science';

select * from Students

SELECT TOP 1 course_name, department, credits
FROM Courses
WHERE department = 'Science';

ALTER TABLE Students
ADD scholarship VARCHAR(20) DEFAULT 'None';

SELECT TOP 1 student_id, name, scholarship
FROM Students;

UPDATE Students
SET address = 'Unknown'
WHERE address = 'Not Provided';

SELECT student_id, name, address
FROM Students
WHERE address = 'Unknown';


ALTER TABLE Enrollments
ADD status VARCHAR(20) DEFAULT 'Active';

select * from Enrollments

ALTER TABLE Enrollments
ADD status VARCHAR(20) DEFAULT 'Active';
SELECT TOP 1 enrollment_id, student_id, course_id, status
FROM Enrollments;

UPDATE Enrollments
SET status = 'Active'
WHERE status IS NULL;

select * from Courses

UPDATE Courses
SET department = 'Technology'
WHERE course_name = 'Computer Science';

UPDATE Courses
SET department = 'Technology'
WHERE course_name = 'Computer Science';

ALTER TABLE Courses
DROP CONSTRAINT CK__Courses__departm__4316F928;

ALTER TABLE Courses
ADD CONSTRAINT CK_Courses_Department
CHECK (department IN ('Science', 'Arts', 'Commerce', 'Engineering', 'Technology'));

ALTER TABLE Courses
DROP CONSTRAINT CK__Courses__departm__4316F928;

ALTER TABLE Courses
ADD CONSTRAINT CK_Courses_Department
CHECK (department IN ('Science', 'Arts', 'Commerce', 'Engineering', 'Technology'));


UPDATE Courses
SET department = 'Technology'
WHERE course_name = 'Computer Science';

ALTER TABLE Courses
DROP CONSTRAINT CK__Courses__departm__4316F928;

UPDATE Courses
SET department = 'Technology'
WHERE course_name = 'Computer Science';

select * from students

DELETE FROM Students
WHERE address = 'Unknown';

SELECT student_id, name, address
FROM Students;

DELETE FROM Enrollments
WHERE grade = 'B';

SELECT enrollment_id, student_id, course_id, grade
FROM Enrollments;

DELETE FROM Courses
WHERE credits < 4;

SELECT course_id, course_name, course_code, department, credits, faculty_id
FROM Courses;

select * from Courses

select * from Enrollments


DELETE FROM Enrollments
WHERE course_id IN (
    SELECT course_id
    FROM Courses
    WHERE credits < 4
);

DELETE FROM Courses
WHERE credits < 4;

ALTER TABLE Enrollments
DROP CONSTRAINT FK_Enrollments_Courses;

ALTER TABLE Enrollments
ADD CONSTRAINT FK_Enrollments_Courses
FOREIGN KEY (course_id) REFERENCES Courses(course_id)
ON DELETE CASCADE;

select * from faculty

ALTER TABLE Faculty
ADD salary DECIMAL(10,2)
BEGIN TRANSACTION;
SAVE TRANSACTION S1

UPDATE Faculty SET salary = 100000 WHERE faculty_id = 1;
UPDATE Faculty SET salary = 95000  WHERE faculty_id = 2;
UPDATE Faculty SET salary = 85000  WHERE faculty_id = 3;
UPDATE Faculty SET salary = 110000 WHERE faculty_id = 4;
UPDATE Faculty SET salary = 92000  WHERE faculty_id = 5;

SELECT faculty_id, name, email, phone, department, salary
FROM Faculty;

select AVG(salary) AS avg_salary
FROM Faculty;

select * from Faculty

SELECT SUM(credits) AS total_credits
FROM Courses;

ROLLBACK TRANSACTION S1;

UPDATE Faculty
SET salary = salary - 2000

SELECT faculty_id, name, department, salary
FROM Faculty;

SELECT AVG(salary) AS avg_salary
FROM Faculty;

ROLLBACK TRANSACTION S1;

UPDATE Faculty
SET salary = salary - 2000;

SELECT faculty_id, name, email, phone, department, salary
FROM Faculty;

UPDATE Faculty SET salary = 98000 WHERE faculty_id = 1;
UPDATE Faculty SET salary = 93000 WHERE faculty_id = 2;
UPDATE Faculty SET salary = 83000 WHERE faculty_id = 3;
UPDATE Faculty SET salary = 108000 WHERE faculty_id = 4;
UPDATE Faculty SET salary = 90000 WHERE faculty_id = 5;

SELECT faculty_id, name, salary FROM Faculty;

UPDATE Faculty
SET salary = salary - 2000;

SELECT faculty_id, name, email, phone, department, salary
FROM Faculty;

SELECT AVG(salary) AS avg_salary
FROM Faculty;

SELECT AVG(salary) AS avg_salary
FROM Faculty;


