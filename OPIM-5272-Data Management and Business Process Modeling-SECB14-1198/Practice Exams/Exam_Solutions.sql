
--------------------------------
---------- PROBLEM 1  ----------
--------------------------------
SELECT MAX(SALARY),AVG(SALARY),JOB_ID
FROM  EMPLOYEES 
WHERE COMMISSION_PCT IS NULL
GROUP BY  JOB_ID
ORDER BY AVG(SALARY) DESC;



--------------------------------
---------- PROBLEM 2  ----------
--------------------------------
SELECT * 
FROM JOB_HISTORY 
WHERE DEPARTMENT_ID BETWEEN 20 AND 100;



--------------------------------
---------- PROBLEM 3  ----------
--------------------------------
SELECT FIRST_NAME,EMAIL,
CASE 
	WHEN INSTR(PHONE_NUMBER,'.')+ INSTR(PHONE_NUMBER,'.',1,2) + INSTR(PHONE_NUMBER,'.',1,3) >15
		THEN SUBSTR(PHONE_NUMBER,-4)
	ELSE SUBSTR(PHONE_NUMBER,-2) 
END AS "PHONE_NUMBER_LAST_DIGITS" 
FROM EMPLOYEES;



--------------------------------
---------- PROBLEM 4  ----------
--------------------------------
SELECT * FROM JOB_HISTORY
WHERE JOB_ID LIKE '%AC%'
ORDER BY START_DATE DESC;



--------------------------------
---------- PROBLEM 5  ----------
--------------------------------
SELECT FIRST_NAME,MANAGER_ID,COMMISSION_PCT,SALARY,
CASE 
	WHEN COMMISSION_PCT IS NULL
		THEN SALARY
	ELSE SALARY + 120000*COMMISSION_PCT 
END AS "TOTAL SALARY"
FROM EMPLOYEES
ORDER BY MANAGER_ID NULLS LAST;



--------------------------------
---------- PROBLEM 6  ----------
--------------------------------
SELECT LAST_NAME, HIRE_DATE, 
TO_CHAR(NEXT_DAY(ADD_MONTHS(HIRE_DATE, 6), 'WEDNESDAY'),'FMDAY, MONTH DD, YYYY') AS "FOR REVIEW" 
FROM EMPLOYEES;


--------------------------------
---------- PROBLEM 7  ----------
--------------------------------
SELECT DEPARTMENT_ID, COUNT(*) FROM EMPLOYEES 
WHERE SALARY>5000 AND DEPARTMENT_ID IS NOT NULL
GROUP BY DEPARTMENT_ID
ORDER BY 2 DESC;



--------------------------------
---------- PROBLEM 8  ----------
--------------------------------
SELECT LAST_NAME,HIRE_DATE,TO_CHAR(HIRE_DATE,'DAY') AS "DAY OF WEEK",COMMISSION_PCT
FROM EMPLOYEES
ORDER BY COMMISSION_PCT NULLS FIRST, LAST_NAME;



--------------------------------
---------- PROBLEM 9  ----------
--------------------------------
SELECT COUNT(*) AS "NUMBER_OF_INT_EMPLOYEES" 
FROM EMPLOYEES
WHERE INSTR(PHONE_NUMBER,'.')+ INSTR(PHONE_NUMBER,'.',1,2) + INSTR(PHONE_NUMBER,'.',1,3) >15;


--------------------------------
---------- PROBLEM 10 ----------
--------------------------------
SELECT ROUND(MAX(SALARY),-3) 
FROM EMPLOYEES;




--------------------------------
---------- PROBLEM 11 ----------
--------------------------------
SELECT DEPARTMENT_NAME,LOCATION_ID
FROM DEPARTMENTS
ORDER BY LOCATION_ID;



--------------------------------
---------- PROBLEM 12 ----------
--------------------------------
SELECT DISTINCT(NVL(DEPARTMENT_ID,0)) 
FROM EMPLOYEES;




--------------------------------
---------- PROBLEM 13 ----------
--------------------------------
SELECT JOB_ID,MAX(SALARY)
FROM EMPLOYEES
WHERE SALARY<8000 
GROUP BY JOB_ID
HAVING AVG(SALARY) > 5000;



--------------------------------
---------- PROBLEM 14 ----------
--------------------------------




--------------------------------
---------- PROBLEM 15 ----------
--------------------------------
SELECT MIN(DEPT.MIN)
FROM
(
SELECT AVG(SALARY) AS MIN
FROM EMPLOYEES 
GROUP BY DEPARTMENT_ID) DEPT;



--------------------------------
---------- PROBLEM 16 ----------
--------------------------------
SELECT (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM EMPLOYEES)) || '%'  AS PERCENTAGE_OF_EMPLOYEES
FROM EMPLOYEES WHERE COMMISSION_PCT IS NOT NULL OR SALARY > 8000
GROUP BY NULL;



--------------------------------
---------- PROBLEM 17 ----------
--------------------------------
SELECT JOB_ID "JOB",
SUM(DECODE(JOB_ID , 'AC_MGR')) "AC_MGR",
SUM(DECODE(JOB_ID , 'ST_MAN')) "ST_MAN",
SUM(DECODE(JOB_ID , 'AD_VP')) "AD_VP",
SUM(DECODE(JOB_ID , 'MK_MAN')) "MK_MAN"
FROM EMPLOYEES
GROUP BY JOB_ID;



--------------------------------
---------- PROBLEM 18 ----------
--------------------------------

SELECT (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM EMPLOYEES)) || '%'  AS PERCENTAGE_OF_EMPLOYEES 
FROM EMPLOYEES 
WHERE REGEXP_COUNT(FIRST_NAME||LAST_NAME,'\s') > 0 
GROUP BY NULL;



--------------------------------
---------- PROBLEM 19 ----------
--------------------------------
SELECT ROUND(VARIANCE(SALARY),-2) , DEPARTMENT_ID
FROM EMPLOYEES
WHERE SALARY > 4500
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) <7000;



--------------------------------
---------- PROBLEM 20 ----------
--------------------------------

SELECT AVG(SALARY) FROM EMPLOYEES
WHERE DEPARTMENT_ID = &DEPTID;



