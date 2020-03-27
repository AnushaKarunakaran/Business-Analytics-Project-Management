--------------------------------
---------- PROBLEM 1  ----------
--------------------------------

SELECT employee_id, hire_date, 
CASE WHEN TO_CHAR(hire_date,'DD')<=15 THEN NEXT_DAY(LAST_DAY(hire_date)-7,'Friday') 
          ELSE NEXT_DAY(LAST_DAY(hire_date),'Friday') END AS FIRSTSALDAY
FROM employees;


--------------------------------
---------- PROBLEM 2  ----------
--------------------------------

SELECT department_id, MAX(salary)
FROM employees
GROUP BY department_id;


--------------------------------
---------- PROBLEM 3  ----------
--------------------------------

SELECT employee_id, hire_date, 
(CASE WHEN TO_CHAR(ADD_MONTHS(hire_date,20*12),'D') = 2  THEN ADD_MONTHS(hire_date,20*12) 
            ELSE NEXT_DAY(ADD_MONTHS(hire_date,20*12),'Monday') END) as "CLAIM DATE"
FROM employees;


--------------------------------
---------- PROBLEM 4  ----------
--------------------------------

SELECT last_name,  (CASE WHEN MOD(employee_id,2)=1 THEN 'ODD' ELSE 'EVEN' END)
FROM employees
WHERE LENGTH(phone_number) = 12;


--------------------------------
---------- PROBLEM 5  ----------
--------------------------------


SELECT last_name, 
(CASE WHEN MOD(length(last_name),2)=0 THEN 
 CONCAT(UPPER(SUBSTR(last_name,0,FLOOR(length(last_name) * 0.5))), LOWER(SUBSTR(last_name,FLOOR(length(last_name) * 0.5)+1)))
 ELSE 
 CONCAT(UPPER(SUBSTR(last_name,0,FLOOR(length(last_name) * 0.5)+1)), LOWER(SUBSTR(last_name,FLOOR(length(last_name) * 0.5)+2)))
 END) AS "New name"
FROM employees;



--OR


SELECT UPPER(SUBSTR(last_name,0,CEIL(LENGTH(last_name)/2)))||
LOWER(SUBSTR(last_name,CEIL(LENGTH(last_name)/2)+1,LENGTH(last_name))) as "New name"
FROM employees;


--------------------------------
---------- PROBLEM 6  ----------
--------------------------------

SELECT AVG(MIN(salary))
FROM employees
GROUP BY department_id;


--------------------------------
---------- PROBLEM 7  ----------
--------------------------------

--Interpreting name as first name and last name
SELECT manager_id, COUNT(*)
FROM employees
WHERE manager_id IS NOT NULL AND lower(first_name||last_name)  NOT LIKE '%a%'
GROUP BY manager_id;

--Interpreting name as first name
SELECT manager_id, COUNT(*)
FROM employees
WHERE manager_id IS NOT NULL AND lower(first_name)  NOT LIKE '%a%'
GROUP BY manager_id;

--Interpreting name as last name
SELECT manager_id, COUNT(*)
FROM employees
WHERE  manager_id IS NOT NULL AND  lower(last_name)  NOT LIKE '%a%'
GROUP BY manager_id;


--------------------------------
---------- PROBLEM 8  ----------
--------------------------------

SELECT (ADD_MONTHS(trunc(sysdate,'year'),12) - TRUNC(sysdate,'year')) -- number of days in the year calc
                -TO_CHAR(sysdate,'DDD') AS "Remaining days"
FROM dual;


--------------------------------
---------- PROBLEM 9  ----------
--------------------------------

SELECT SUBSTR(phone_number,1,3), COUNT(*),MIN(salary)
FROM employees
WHERE LENGTH(phone_number) = 12
GROUP BY SUBSTR(phone_number,1,3)
ORDER BY 3 DESC;

--------------------------------
---------- PROBLEM 10 ----------
--------------------------------

select Employee_id, floor(sum(months_between(end_date,start_date)/12)) as "Years Worked"
from job_history group by Employee_id;


--------------------------------
---------- PROBLEM 11 ----------
--------------------------------


SELECT phone_number, CASE WHEN INSTR(SUBSTR(phone_number,-4),'5')>0 AND INSTR(SUBSTR(phone_number,-4),'6')>0 
THEN 1 ELSE 0 END AS "Flagged employees"
FROM employees;

--------------------------------
---------- PROBLEM 12 ----------
--------------------------------

SELECT sum(CASE WHEN INSTR(SUBSTR(phone_number,-4),'5')>0 OR INSTR(SUBSTR(phone_number,-4),'6')>0 
THEN 1 ELSE 0 END) AS "# of Flagged Employees"
FROM employees;


--------------------------------
---------- PROBLEM 13 ----------
--------------------------------

select Last_Name,
Replace(Replace(REPLACE(Replace(LOWER(Last_Name),'s','K'),'k','A'),'a','E'),'e','S') AS "New Last Name" from employees order by 2 desc;

--- Another solution 
SELECT LAST_NAME,TRANSLATE(LAST_NAME,'SsKkAaEe','KKAAEESS')
FROM EMPLOYEES order by 2 desc;

--------------------------------
---------- PROBLEM 14 ----------
--------------------------------

select Manager_id,Trunc(sum(CURRENT_DATE - HIRE_DATE)) AS "Number of Days" from employees group by Manager_id order by 2 desc;


--------------------------------
---------- PROBLEM 15 ----------
--------------------------------

select job_id,count(*) AS "# of Employees",round(median(salary)),round(avg(salary)),
case when median(salary)=avg(salary) then 'symmetric'
when median(salary)<avg(salary) then 'right skewed'
else 'left skewed' end as "Type of SKew"
from employees
group by job_id
order by Sum(salary);



--------------------------------
---------- PROBLEM 16 ----------
--------------------------------

select phone_number,
case when instr(phone_number,'.')+ instr(phone_number,'.',1,2) + instr(phone_number,'.',1,3) >15
then 'INT' 
else 'DOM' end as "Category"
from employees;


--------------------------------
---------- PROBLEM 17 ----------
--------------------------------

select first_name,Last_Name,
substr(first_name,1,1) || 
substr(upper(Last_name),-1,1) ||
to_char(hire_date,'MON') ||
(Length(first_name||Last_Name) - Length(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(upper(first_name||Last_Name),'A',''),'E',''),'I',''),'O',''),'U','')))
 As "User_ID"
from employees;



--------------------------------
---------- PROBLEM 18 ----------
--------------------------------

select last_name,salary
from employees
where substr(last_name,1,1) not like '%K%'
and salary<&sal;

