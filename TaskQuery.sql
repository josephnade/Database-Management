USE onlinebankingfinalproject;

/* 1-) 1 table, at least 2 condition in WHERE clause*/
SELECT * FROM personal WHERE (Fname='Yusuf' AND Lname = 'AKIN');

/* 2-) 1 table, retrieve all attributes and ORDER BY primary key.*/
SELECT * FROM personal ORDER BY Person_no;

/* 3-)1 table, use BETWEEN … AND …*/
SELECT * FROM personal  WHERE Birthdate BETWEEN'1990-01-01' AND '2000-01-01';

/* 4-)1 table, use NOT NULL*/
SELECT person_no, salary FROM Staff WHERE salary is NOT NULL;

/* 5-)1 table, use MAX, MIN, AVG (Ex: Find max, min, avg salary of employee)*/
SELECT MIN(BALANCE) AS 'MIN BALANCE', MAX(BALANCE) AS 'MAX BALANCE', AVG(BALANCE) AS 'AVERAGE BALANCE' FROM checking_account;

/* 6-)2 table, use COUNT, SUM)*/
SELECT  D.Department_no AS 'Department No', COUNT(*) AS 'Piece', SUM(salary)
FROM  department D, staff S 
WHERE D.Department_no=S.Department_no
GROUP BY S.Department_no;

SELECT  COUNT(*) AS 'number of cartesian products'
FROM  property PR, personal P ;

/* 7-)use GROUP BY*/
SELECT  D.Department_no AS 'Department No', COUNT(*) AS 'Piece', SUM(salary)
FROM  department D, staff S 
WHERE D.Department_no=S.Department_no
GROUP BY S.Department_no;

/* 8-)use HAVING*/
SELECT S.Department_no AS 'Department No', COUNT(*) AS 'number of D0001'
FROM staff S
GROUP BY s.Department_no
HAVING S.Department_no IN ('D0001');

/* 9-)use LIKE (substring comparision)*/
SELECT * 
FROM personal
WHERE address LIKE "%Gazi%";

/* 10-)UPDATE one of the existing record in a table)*/
UPDATE staff SET department_no='D0002' WHERE staff_no='100002';
UPDATE staff SET department_no='D0002' WHERE staff_no='100004';

/* 11-)INNER Join*/
SELECT  S.Person_no, P.Fname, P.Lname
FROM personal P
JOIN Staff S
	ON P.Person_no=S.Person_no;


/* 12-)Join*/
SELECT  D.Department_no AS 'Department No', COUNT(*) AS 'Piece', AVG(salary)
FROM  department D, staff S 
WHERE D.Department_no=S.Department_no
GROUP BY S.Department_no;

/* 13-) Join*/
SELECT *
FROM property P
WHERE P.IBAN_no IN(SELECT IBAN_no 
	FROM users S
	WHERE S.person_no='U000000002' AND S.IBAN_no=P.IBAN_no); 
    

/* 14-) LEFT Outer Join*/
SELECT  D.Department_no, S.Person_no
FROM Staff S
LEFT JOIN Department D
	ON S.department_no=D.Department_no AND D.Department_no='D0001';
    
/* 15-)Right Outer Join*/
SELECT  D.Department_no, S.Person_no
FROM Staff S
RIGHT JOIN Department D
	ON S.department_no=D.Department_no AND D.Department_no='D0001';
    
/* 16-) Full Outer Join*/
SELECT  D.Department_no, S.Person_no
FROM Staff S
LEFT JOIN Department D
	ON S.department_no=D.Department_no AND D.Department_no='D0001'
UNION
SELECT  D.Department_no, S.Person_no
FROM Staff S
LEFT JOIN Department D
	ON S.department_no=D.Department_no AND D.Department_no='D0001';


/* 17-) Stored Procedure*/
DELIMITER &&
CREATE PROCEDURE GetInformation()
BEGIN
	SELECT  p.Fname, p.Lname, p.Address
	FROM personal P;
	  
END &&
DELIMITER ;

CALL GetInformation();

/* 18-) Stored Procedure*/
DELIMITER ##
CREATE PROCEDURE GetDepartmentPerson(IN departmentNo varchar(10))
BEGIN
	SELECT S.Staff_no, S.Salary, P.Fname, P.Lname
    FROM Staff S, Personal P
    WHERE S.Department_no=departmentNo AND P.Person_no=S.Person_no;
END ##
DELIMITER ;


CALL GetDepartmentPerson("D0001");
CALL GetDepartmentPerson("D0002");

/* 19-)View */
CREATE VIEW vıew_staff_info AS
SELECT P.Fname, P.Lname, S.Salary, D.Authority
FROM Staff S, Personal P, Department D
WHERE P.Person_no=S.Person_no AND S.department_no=D.department_no;

SELECT *
FROM vıew_staff_info;

/* 20-)View */
CREATE VIEW vıew_group_department(Dept_No, Dept_Authority, No_of_Staff, Salary_Sum ) AS
SELECT D.department_no, D.Authority, COUNT(S.department_no), SUM(S.salary)
FROM Staff S, Personal P, Department D
WHERE P.Person_no=S.Person_no AND S.department_no=D.department_no
GROUP BY D.department_no
ORDER BY COUNT(S.department_no);

SELECT *
FROM vıew_group_department;


