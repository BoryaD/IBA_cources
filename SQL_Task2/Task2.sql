--5. Display the average bonus and average commission for all departments with
--an average bonus greater than $500 and an average commission greater
--than

SELECT WORKDEPT, AVG(COMM) AS COMMISION, AVG(BONUS) AS BONUS
FROM EMPLOYEE
GROUP BY WORKDEPT
HAVING AVG(BONUS) > 500 AND AVG(COMM) > 2000;

--List department number, department name, last name, and first name of all
--those employees in departments that have only male employees.

               
SELECT E.WORKDEPT, D.DEPTNAME, E.FIRSTNME, E.LASTNAME
FROM EMPLOYEE AS E
JOIN DEPT AS D ON D.DEPTNO = E.WORKDEPT
WHERE 'F' NOT IN
        (SELECT EMPLOYEE.SEX
               FROM EMPLOYEE
               WHERE EMPLOYEE.WORKDEPT = D.DEPTNO);

               
--We want to do a salary analysis for people that have the same job and
--education level as the employee Stern. Show the last name, job, edlevel, the
--number of years they've worked as of January 1, 2000, and their salary.
--Name the derived column YEARS.
--Sort the listing by highest salary first.
SELECT E.LASTNAME, E.JOB, E.EDLEVEL, YEAR('2000-1-1' - E.HIREDATE) as YEARS, E.SALARY 
FROM EMPLOYEE AS E
WHERE (E.JOB, E.EDLEVEL) IN 
        (SELECT E1.JOB, E1.EDLEVEL
        FROM EMPLOYEE AS E1
        WHERE E1.LASTNAME = 'STERN')
ORDER BY E.SALARY DESC;

--TASK 1

CREATE TABLE PERSONS_INFO (
    USER_ID INT,
    PHONE_TYPE VARCHAR(10),
    PHONE_NUMBER VARCHAR(15)
);

INSERT INTO PERSONS_INFO (USER_ID, PHONE_TYPE, PHONE_NUMBER)
VALUES (1, 'HOME', '7777777'),
(1, 'WORK', '336666666'),
(2, 'HOME', '5555555'),
(3, 'WORK', '+4444444'),
(4, 'HOME', '3333333'),
(4, 'WORK', '2222222');


SELECT USER_ID, 
(MAX(CASE WHEN PHONE_TYPE LIKE '%HOME%' THEN PHONE_NUMBER else NULL end)) AS HOME_NUMBER,
(MAX(CASE WHEN PHONE_TYPE LIKE '%WORK%' THEN PHONE_NUMBER else NULL end)) AS WORKNUBBER
FROM PERSONS_INFO
GROUP BY  USER_ID;

--TASK 2

CREATE TABLE FLAGS(
    ID INT,
    FL1 BOOLEAN,
    FL2 BOOLEAN,
    FL3 BOOLEAN,
    FL4 BOOLEAN,
    FL5 BOOLEAN,
    FL6 BOOLEAN,
    FL7 BOOLEAN,
    FL8 BOOLEAN,
    FL9 BOOLEAN
);


INSERT INTO FLAGS (ID, FL1, FL2, FL3, FL4, FL5, FL6, FL7, FL8, FL9)
VALUES (1, 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true'),
(2, 'true', 'false', 'false', 'true', 'true', 'true', 'true', 'true', 'true'),
(3, 'true', 'false', 'true', 'false', 'false', 'true', 'true', 'true', 'true'),
(4, 'false', 'false', 'true', 'false', 'false', 'false', 'false', 'false', 'false'),
(5, 'true', 'false', 'false', 'false', 'false', 'true', 'true', 'true', 'true'),
(6, 'true', 'false', 'false', 'false', 'false', 'true', 'false', 'true', 'true');


SELECT ID, (CASE
WHEN FL1 = 'true' THEN 'fl1'
WHEN FL2 = 'true' THEN 'fl2'
WHEN FL3 = 'true' THEN 'fl3'
WHEN FL4 = 'true' THEN 'fl4'
WHEN FL5 = 'true' THEN 'fl5'
WHEN FL6 = 'true' THEN 'fl6'
WHEN FL7 = 'true' THEN 'fl7'
WHEN FL8 = 'true' THEN 'fl8'
WHEN FL9 = 'true' THEN 'fl9' end) as flag
FROM FLAGS WHERE CAST(FL1 AS INT) + CAST(FL2 AS INT) + CAST(FL3 AS INT) + CAST(FL4 AS INT) + CAST(FL5 AS INT) + CAST(FL6 AS INT)
+ CAST(FL7 AS INT) + CAST(FL8 AS INT) + CAST(FL9 AS INT) = 1

