---1. Create Table:
--- Create tables Students, Classes, and Teachers with corresponding fields.
CREATE TABLE Teachers(
	TeacherID INT PRIMARY KEY IDENTITY(1,1),
	FirstName VARCHAR(100) NOT NULL,
	LastName VARCHAR(100) NOT NULL,
	Subject VARCHAR(255) NOT NULL)

CREATE TABLE Classes(
	ClassID INT PRIMARY KEY IDENTITY(1,1),
	ClassName VARCHAR(100),
	TeacherID INT FOREIGN KEY REFERENCES Teachers(TeacherID));

CREATE TABLE Students(
	StudentID INT PRIMARY KEY IDENTITY(1,1),
	FirstName VARCHAR(100) NOT NULL,
	LastName VARCHAR(100) NOT NULL,
	ClassID INT FOREIGN KEY REFERENCES Classes(ClassID),
	BirthDate DATE NOT NULL);

---2. More Data:
-- Add at least 5 classes and 10 students to the database.
-- Add at least 3 teachers with information related to the subject.
INSERT INTO Teachers(FirstName,LastName,Subject) VALUES ('TRAN VAN','BINH','C++'),('TRAN VAN','NAM','HTML'),('NGUYEN QUANG','AN','Reactjs');

INSERT INTO Classes(ClassName,TeacherID) VALUES ('2024 SEM 1',1),('2023 SEM 1',2),('2023 SEM 2',3),('2022 SEM 1',1),('2022 SEM 2',2);

INSERT INTO Students(FirstName,LastName,ClassID,BirthDate) 
	VALUES ('TRAN VAN','AN',1,'2003-04-17'),('TRAN VAN','BA',1,'2002-04-17'),('TRAN VAN','BON',2,'2002-05-17'),('TRAN VAN','TAO',2,'2001-05-17'),
			('TRAN VAN','TIN',3,'2002-06-17'),('NGUYEN VAN','THUAN',3,'2002-06-17'),('NGUYEN VAN','THANH',4,'2002-05-12'),('PHAM VAN','CUONG',4,'2001-05-27'),
			('VU THANH','SON',5,'2002-09-7'),('VU QUANG','NHAT',5,'2002-06-17');

--3. Data Query:
-- Write a SQL query to display a list of all students with class name and teacher in charge.

SELECT S.FirstName as StudentFirstName, S.LastName as StudentLastName,C.ClassName as ClassName,T.FirstName as TeacherFirstName_InCharge, T.LastName as TeacherLastName_InCharge
 FROM Students S LEFT JOIN Classes C ON S.ClassID = C.ClassID LEFT JOIN Teachers T ON C.TeacherID = T.TeacherID;

---4. Query Conditions:
-- Write a SQL query to display students with birth dates from 2000 onwards.
SELECT * FROM Students WHERE BirthDate >='2000-01-01';
---5. JOIN Query:
-- Write an SQL query to display all students with class name and teacher in charge, sorted by student name.
SELECT S.FirstName as StudentFirstName, S.LastName as StudentLastName,C.ClassName as ClassName,T.FirstName as TeacherFirstName_InCharge, T.LastName as TeacherLastName_InCharge
 FROM Students S LEFT JOIN Classes C ON S.ClassID = C.ClassID LEFT JOIN Teachers T ON C.TeacherID = T.TeacherID ORDER BY S.LastName ASC;
---6. Updating data:
-- Update the name of the student whose StudentID is 3 to "John Doe"
UPDATE Students SET FirstName = 'John', LastName = 'Doe' WHERE StudentID = 3;
---7. Delete data:
-- Delete students whose StudentID is 7.
DELETE FROM Students WHERE StudentID = 7;
---8. Procedure:
-- Create a stored procedure named GetStudentsByClassAndSubject that takes ClassID and Subject, and returns a list of students belonging to that class and subject.
CREATE PROCEDURE GetStudentsByClassAndSubject @ClassID INT, @Subject VARCHAR(255)
	AS
		BEGIN
			SELECT 
				s.StudentID, 
				s.FirstName, 
				s.LastName, 
				s.BirthDate,
				c.ClassName,
				t.Subject
			FROM 
				Students s
			JOIN 
				Classes c ON s.ClassID = c.ClassID
			JOIN 
				Teachers t ON c.TeacherID = t.TeacherID
			WHERE 
				c.ClassID = @ClassID 
				AND t.Subject = @Subject;
		END;

---9. View:
-- Create a view named StudentsWithClassAndTeacher that displays information about students along with the class name and teacher in charge.
CREATE VIEW StudentsWithClassAndTeacher AS
	SELECT 
		s.StudentID,
		s.FirstName AS StudentFirstName,
		s.LastName AS StudentLastName,
		s.BirthDate,
		c.ClassName,
		t.FirstName AS TeacherFirstName,
		t.LastName AS TeacherLastName,
		t.Subject
	FROM 
		Students s
	JOIN 
		Classes c ON s.ClassID = c.ClassID
	JOIN 
		Teachers t ON c.TeacherID = t.TeacherID;

SELECT * FROM StudentsWithClassAndTeacher;

---------END--------------------------------------