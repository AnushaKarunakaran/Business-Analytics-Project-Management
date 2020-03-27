---------------------
----PROBLEM 1--------
---------------------

SELECT 
    SUM(
        CASE
            WHEN HIRE_DATE BETWEEN '01-JAN-80' AND '31-DEC-89'
                THEN 1
            ELSE
                0
        END
        ) "80s",
    SUM(
        CASE
            WHEN HIRE_DATE BETWEEN '01-JAN-90' AND '31-DEC-99'
                THEN 1
            ELSE
                0
        END
        ) "90s" 
FROM Employees;

---------------------
----PROBLEM 2--------
---------------------

SELECT max(salary),min(salary) 
FROM Employees 
WHERE JOB_ID LIKE '%AD%';

---------------------
----PROBLEM 3--------
---------------------

SELECT DISTINCT(EXTRACT(YEAR FROM END_DATE)-EXTRACT(YEAR FROM START_DATE)) AS YEARS_IN_ORG ,COUNT(*) OVER (PARTITION BY EXTRACT(YEAR FROM END_DATE)-EXTRACT(YEAR FROM START_DATE)) AS NUMBER_OF_EMPLOYEES
FROM JOB_HISTORY
ORDER BY YEARS_IN_ORG ASC;

SELECT TO_CHAR(SYSDATE, 'DDD') FROM dual;

---------------------
----PROBLEM 4--------
---------------------

SELECT DEPARTMENT_ID,COUNT(DISTINCT(MANAGER_ID)),ROUND(AVG(SALARY)) AS AVG_SALARY ,MEDIAN(SALARY) AS MEDIAN_SALARY
FROM EMPLOYEES
WHERE MANAGER_ID IS NOT NULL AND DEPARTMENT_ID IS NOT NULL
GROUP BY DEPARTMENT_ID
HAVING COUNT(DISTINCT(MANAGER_ID)) >= 2 AND ROUND(AVG(SALARY)) = MEDIAN(SALARY);


---------------------
----PROBLEM 5--------
---------------------

SELECT LAST_NAME,
(   
    CASE 
        WHEN MOD(EMPLOYEE_ID,2)=0
            THEN 'Even'
    ELSE
        'Odd'
    END) "INDICATOR"
FROM EMPLOYEES;

---------------------
----PROBLEM 6--------
---------------------

SELECT COUNT(*) AS "Total IT Employees", SUM(
CASE
    WHEN MOD(TO_CHAR(HIRE_DATE,'Q'),4) = '1'
        THEN 1
    ELSE
        0
END
) "Q1",
SUM(
CASE
    WHEN MOD(TO_CHAR(HIRE_DATE,'Q'),4) = '2'
        THEN 1
    ELSE
        0
END
) "Q2",
SUM(
CASE
    WHEN MOD(TO_CHAR(HIRE_DATE,'Q'),4) = '3'
        THEN 1
    ELSE
        0
END
) "Q3",
SUM(
CASE
    WHEN MOD(TO_CHAR(HIRE_DATE,'Q'),4) = '0'
        THEN 1
    ELSE
        0
END
) "Q4" 
FROM EMPLOYEES
WHERE JOB_ID LIKE '%IT%';

---------------------
----PROBLEM 7--------
---------------------

SELECT last_name,job_id,hire_date,
(CASE
    WHEN JOB_ID LIKE '%IT%'
        THEN ADD_MONTHS(Hire_date-1,9)
    WHEN JOB_ID LIKE '%SA%' OR JOB_ID LIKE '%MK%'
        THEN ADD_MONTHS(Hire_date-1,12)
    ELSE
        ADD_MONTHS(Hire_date-1,6)
END) "PROBATION END DATE" 
FROM Employees;

---------------------
----PROBLEM 8--------
---------------------

SELECT DISTINCT(SUBSTR(JOB_ID,INSTR(JOB_ID,'_',-1)+1))AS "JOB_ID" , COUNT(JOB_ID) OVER (PARTITION BY SUBSTR(JOB_ID,INSTR(JOB_ID,'_',-1)+1)) 
FROM EMPLOYEES
GROUP BY JOB_ID
HAVING MIN(SALARY) > 5000;

---------------------
----PROBLEM 9--------
---------------------

SELECT 
    SUM(
        CASE
            WHEN SALARY < 5000
                THEN 1
            ELSE
                0
        END
        ) "TIER 3",
     SUM(
        CASE
            WHEN SALARY > 5000 AND SALARY <= 10000
                THEN 1
            ELSE
                0
        END
        ) "TIER 2",
    SUM(
        CASE
            WHEN SALARY > 10000
                THEN 1
            ELSE
                0
        END
        ) "TIER 1"

FROM Employees;

---------------------
----PROBLEM 10-------
---------------------

SELECT COALESCE(MANAGER_ID,0),SUM(ROUND(SYSDATE - HIRE_DATE)) AS "NUMBER OF DAYS" 
FROM EMPLOYEES
WHERE MANAGER_ID IS NOT NULL 
GROUP BY MANAGER_ID
ORDER BY 2 DESC;


---------------------
----PROBLEM 11-------
---------------------

-- Prints the first non-null value
SELECT DECODE(COALESCE(COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID),NULL,'ALL NULL VALUES',COALESCE(COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID)) AS FIRST_NULL FROM EMPLOYEES;

-- Below is an example of when all the three values are null - It prints ALL NULL VALUES
SELECT COALESCE(NULL,NULL,NULL,'ALL NULL VALUES') FROM DUAL;

---------------------
----PROBLEM 12-------
---------------------

SELECT
DEPARTMENT_ID, COUNT(EMPLOYEE_ID),
SUM(
    CASE
        WHEN SALARY >= &Input
            THEN 1
        ELSE
            0
END),ROUND(AVG(SALARY)) AS AVG_SALARY
FROM EMPLOYEES
WHERE JOB_ID <> '&JOBID' 
GROUP BY DEPARTMENT_ID;
 
---------------------
----PROBLEM 13-------
---------------------

SELECT COUNT(*) TOTAL,
SUM(DECODE(TO_CHAR(HIRE_DATE,'YYYY'),1991,1,0)) "1991",
SUM(DECODE(TO_CHAR(HIRE_DATE,'YYYY'),1993,1,0)) "1993",
SUM(DECODE(TO_CHAR(HIRE_DATE,'YYYY'),1995,1,0)) "1995",
SUM(DECODE(TO_CHAR(HIRE_DATE,'YYYY'),1997,1,0)) "1997"
FROM EMPLOYEES;

---------------------
----PROBLEM 14-------
---------------------

SELECT MIN(HIRE_DATE),COUNT(EMPLOYEE_ID) FROM EMPLOYEES
GROUP BY JOB_ID
HAVING MEDIAN(SALARY) > 6000;

---------------------
----PROBLEM 15-------
---------------------

SELECT ROUND(AVG(SALARY)) AS AVG_SALARY
FROM EMPLOYEES
GROUP BY JOB_ID
HAVING MEDIAN(SALARY) > ROUND(AVG(SALARY));

---------------------
----PROBLEM 16-------
---------------------

SELECT DEPARTMENT_ID,EXTRACT(YEAR FROM HIRE_DATE),MIN(SALARY),MAX(SALARY),MEDIAN(SALARY) FROM EMPLOYEES
GROUP BY DEPARTMENT_ID,EXTRACT(YEAR FROM HIRE_DATE)
ORDER BY DEPARTMENT_ID DESC ,EXTRACT(YEAR FROM HIRE_DATE) DESC;

---------------------
----PROBLEM 17-------
---------------------

SELECT TO_CHAR(HIRE_DATE,'MON') "MONTH", COUNT(EMPLOYEE_ID)
FROM EMPLOYEES
GROUP BY TO_CHAR(HIRE_DATE,'MON'),EXTRACT(MONTH FROM HIRE_DATE)
HAVING COUNT(EMPLOYEE_ID) >= 1
ORDER BY EXTRACT(MONTH FROM HIRE_DATE) ASC;

---------------------
----PROBLEM 18-------
---------------------

SELECT EXTRACT(YEAR FROM HIRE_DATE),COUNT(DISTINCT(EXTRACT(DAY FROM HIRE_DATE))) AS "DISTINCT_DATES",AVG(SALARY)
FROM EMPLOYEES
WHERE SALARY >= 5000
GROUP BY EXTRACT(YEAR FROM HIRE_DATE)
HAVING AVG(SALARY) <13000
ORDER BY EXTRACT(YEAR FROM HIRE_DATE);

---------------------
----PROBLEM 19-------
---------------------

SELECT DISTINCT(MANAGER_ID),COUNT(EMPLOYEE_ID),SUM(SALARY) AS EXISTING_SALARY ,SUM(
CASE WHEN COMMISSION_PCT IS NULL 
        THEN 1.2*SALARY
    ELSE
        SALARY+100000*COMMISSION_PCT
    END) AS "NEW_SALARY"
FROM EMPLOYEES
WHERE MANAGER_ID IS NOT NULL AND SALARY < 11000 
GROUP BY MANAGER_ID
HAVING SUM(
CASE WHEN COMMISSION_PCT IS NULL 
        THEN 1.2*SALARY
    ELSE
        SALARY+100000*COMMISSION_PCT
    END) < 9000;

---------------------
----PROBLEM 20-------
---------------------

SELECT ROUND(AVG(MAX),2),ROUND(VARIANCE(MAX),2) FROM
(
SELECT MAX(SALARY) AS MAX FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NOT NULL
GROUP BY DEPARTMENT_ID
);