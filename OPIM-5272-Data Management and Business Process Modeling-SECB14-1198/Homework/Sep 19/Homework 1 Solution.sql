
--------------------------------
---------- PROBLEM 1  ----------
--------------------------------
SELECT last_name,job_id, hire_date 
FROM Employees
WHERE  TO_CHAR(hire_date,'W')='1' AND TO_CHAR(hire_date,'D')='2';

SELECT * FROM EMPLOYEES WHERE ROWNUM<4;

--------------------------------
---------- PROBLEM 2  ----------
--------------------------------
SELECT last_name, hire_date, job_id 
FROM Employees 
WHERE MOD(TO_NUMBER(TO_CHAR(hire_date,'MM')),3) = '1' ;




--------------------------------
---------- PROBLEM 3  ----------
--------------------------------
SELECT avg(DEPT.max)FROM(
SELECT max(salary) AS MAX
FROM Employees 
GROUP BY Department_id) DEPT;



--------------------------------
---------- PROBLEM 4  ----------
--------------------------------

SELECT CONCAT(CONCAT(first_name,' '),last_name) AS "Full Name", CONCAT(email,'@gmail.com') AS "Email ID",
CONCAT(CONCAT(CONCAT(CONCAT(CONCAT('+1(', SUBSTR(phone_number,1,3)),')'),SUBSTR(phone_number,5,3)),'-'),SUBSTR(phone_number,9,4))AS "Phone Number" 
FROM Employees 
WHERE LENGTH(phone_number)=12;

--------------------------------
---------- PROBLEM 5  ----------
--------------------------------
SELECT last_name AS "Experienced Employee", Hire_date AS "Hire Date"
FROM Employees 
WHERE  EXTRACT(YEAR FROM date '2001-01-01')-  EXTRACT(YEAR FROM hire_date)>10;



--------------------------------
---------- PROBLEM 6  ----------
--------------------------------
SELECT first_name 
FROM Employees 
WHERE Manager_Id=100 AND NOT REGEXP_LIKE(last_name,'[aeiouAEIOU]{2}') 
ORDER BY last_name ASC;

SELECT CEIL(24.75) FROM DUAL;


--------------------------------
---------- PROBLEM 7  ----------
--------------------------------
SELECT last_name, commission_pct, NVL2 (commission_pct, commission_pct, salary*0.015) AS "new_commission_pct"
FROM employees;



--------------------------------
---------- PROBLEM 8  ----------
--------------------------------
SELECT start_date, end_date,
TRUNC((MONTHS_BETWEEN(end_date, start_date))/12) AS "YEARS",
TRUNC(mod(MONTHS_BETWEEN(end_date, start_date),12)) AS "MONTHS",
(end_date - ADD_MONTHS(start_date, MONTHS_BETWEEN(end_date, start_date))) AS "DAYS"
FROM job_history;



--------------------------------
---------- PROBLEM 9  ----------
--------------------------------
SELECT last_name
FROM employees
WHERE first_name LIKE '%a%' OR first_name LIKE '%A%';



--------------------------------
---------- PROBLEM 10 ----------
--------------------------------
SELECT last_name, phone_number
FROM employees
WHERE phone_number LIKE '1%' AND ((phone_number LIKE '%5%') OR (phone_number LIKE '%6%'));



--------------------------------
---------- PROBLEM 11 ----------
--------------------------------
SELECT INITCAP(last_name), ROUND(MONTHS_BETWEEN(sysdate, hire_date)) AS "Number of Months"
FROM employees
WHERE last_name LIKE 'B%' OR last_name LIKE 'K%' OR last_name LIKE 'M%'
ORDER BY MONTHS_BETWEEN(sysdate, hire_date);



--------------------------------
---------- PROBLEM 12 ----------
--------------------------------
SELECT SUBSTR(street_address,INSTR(street_address,' ',-1)),street_address 
FROM locations;




--------------------------------
---------- PROBLEM 13 ----------
--------------------------------
undefine letter;
SELECT first_name, last_name
FROM employees
WHERE (UPPER(last_name) NOT LIKE UPPER('%&&letter%')) AND (UPPER(first_name) LIKE UPPER('%&letter%&letter%'))
and (UPPER(first_name) LIKE UPPER('%&letter%&letter%') or first_name LIKE LOWER('%&letter%&letter%')); 


--------------------------------
---------- PROBLEM 14 ----------
--------------------------------
SELECT last_name,NVL2(manager_id,((ROUND(MONTHS_BETWEEN(sysdate,hire_date)))*100)+(0.1*salary),0) "Calculated Bonus" 
FROM employees 
ORDER BY "Calculated Bonus";




--------------------------------
---------- PROBLEM 15 ----------
--------------------------------
SELECT first_name, last_name, hire_date  
FROM employees 
WHERE TO_CHAR(hire_date,'DD') = 7 OR TO_CHAR(hire_date,'MM')=7;




--------------------------------
---------- PROBLEM 16 ----------
--------------------------------
SELECT last_name, ADD_MONTHS(hire_date,9) AS "Probation Period"
FROM employees
WHERE salary < 8000;



--------------------------------
---------- PROBLEM 17 ----------
--------------------------------
undefine cents;

SELECT FLOOR(((('&&cents')-FLOOR('&cents'))*100)/25) as quarters,  
FLOOR(mod((((&cents)-FLOOR(&cents))*100),25)/10) as dimes,
FLOOR(mod(mod((((&cents)-FLOOR(&cents))*100),25),10)/5) as nikles,
FLOOR(mod(mod(mod((((&cents)-FLOOR(&cents))*100),25),10),5)/1) as pennies
FROM dual;



--------------------------------
---------- PROBLEM 18 ----------
--------------------------------
SELECT last_name
FROM employees
WHERE email LIKE UPPER('___n%')  
ORDER BY SUBSTR(email, 2,1);



--------------------------------
---------- PROBLEM 19 ----------
--------------------------------
SELECT job_title, SUBSTR(job_title,1, INSTR(job_title, ' ')-1)
FROM jobs;



--------------------------------
---------- PROBLEM 20 ----------
--------------------------------
SELECT last_name, TRANSLATE(last_name, 'SsKkAaEe', 'KKAAEESS') AS new_last_name 
FROM employees 
ORDER BY new_last_name DESC;
    
	
	
