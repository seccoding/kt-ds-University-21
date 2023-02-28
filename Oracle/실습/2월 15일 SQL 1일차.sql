/*
EMPLOYEES 테이블에서 SALARY가 10000 ~ 15000 사이인
데이터의 EMPLOYEE_ID, FIRST_NAME, SALARY를
SALARY로 내림차순 하여 조회한다.
*/
-- CASE 1
SELECT EMPLOYEE_ID
	 , FIRST_NAME
	 , SALARY
  FROM EMPLOYEES
 WHERE SALARY BETWEEN 10000 AND 15000
 ORDER BY SALARY DESC
;

-- CASE 2
SELECT EMPLOYEE_ID
	 , FIRST_NAME
	 , SALARY
  FROM EMPLOYEES
 WHERE SALARY >= 10000
   AND SALARY <= 15000
 ORDER BY SALARY DESC
;

/*
EMPLOYEES 테이블에서 
JOB_ID가 FI_MGR 이거나 ST_MAN
이고 SALARY가 10000 이하인 
데이터의 모든 컬럼을 HIRE_DATE 로 오름차순 정렬하여
조회한다.
 */
SELECT *
  FROM EMPLOYEES
 WHERE (JOB_ID = 'FI_MGR'
    OR JOB_ID = 'ST_MAN')
   AND SALARY <= 10000
 ORDER BY HIRE_DATE ASC
;

/*
EMPLOYEES 테이블에서 
JOB_ID가 FI_MGR 이거나 ST_MAN
이고 SALARY가 10000 이하인 
데이터의 모든 컬럼을 HIRE_DATE 로 오름차순 정렬하여
조회한다.
 */
SELECT *
  FROM EMPLOYEES
 WHERE JOB_ID IN ('FI_MGR', 'ST_MAN')
   AND SALARY <= 10000
 ORDER BY HIRE_DATE ASC
;

/*
EMPLOYEES 테이블에서 
JOB_ID가 FI_MGR, ST_MAN을 제외한 데이터 중 SALARY가 10000 이하인 
데이터의 모든 컬럼을 HIRE_DATE 로 오름차순 정렬하여
조회한다.
 */
-- CASE 1
SELECT *
  FROM EMPLOYEES
 WHERE JOB_ID != 'FI_MGR'
   AND JOB_ID != 'ST_MAN'
   AND SALARY <= 10000
 ORDER BY HIRE_DATE ASC
;

-- CASE 2
SELECT *
  FROM EMPLOYEES
 WHERE JOB_ID NOT IN ('FI_MGR', 'ST_MAN')
   AND SALARY <= 10000
 ORDER BY HIRE_DATE ASC 
;

/*
 * EMPLOYEES 테이블에서 FIRST_NAME 이 'S'로 시작하는 
 * 모든 데이터들의 모든 컬럼을 조회한다.
 */
SELECT *
  FROM EMPLOYEES
 WHERE FIRST_NAME LIKE 'S%'
;

/**
 * EMPLOYEES 테이블에서 FIRST_NAME 이 'n' 으로 끝나는
 * 모든 데이터들의 모든 컬럼을 조회한다.
 */
SELECT *
  FROM EMPLOYEES
 WHERE FIRST_NAME LIKE '%n'
;

/*
 * EMPLOYEES 테이블에서 FIRST_NAME 에 eve 가 포함된
 * 모든 데이터들의 모든 컬럼을 조회한다.
 */
SELECT *
  FROM EMPLOYEES
 WHERE FIRST_NAME LIKE '%eve%'
;

/*
 * EMPLOYEES 테이블에서 FIRST_NAME에 'Ste' 가 포함된
 * 모든 데이터의 모든 컬럼을 조회한다.
 */
SELECT *
  FROM EMPLOYEES
 WHERE FIRST_NAME LIKE '%Ste%'
;
/*
 * EMPLOYEES 테이블에서 PHONE_NUMBER 가 '515.' 으로 시작하는
 * 모든 데이터들의 모든 컬럼을 조회한다. 단, FIRST_NAME 으로
 * 내림차순 한다.
 */
SELECT *
  FROM EMPLOYEES
 WHERE PHONE_NUMBER LIKE '515.%'
 ORDER BY FIRST_NAME DESC
;

/*
 * EMPLOYEES 테이블에서 JOB_ID 가 'PRES' 로 끝나는
 * 모든 데이터들의 모든 컬럼을 LAST_NAME 으로 오름차순 정렬하여 조회한다.
 */
SELECT *
  FROM EMPLOYEES
 WHERE JOB_ID LIKE '%PRES'
 ORDER BY LAST_NAME ASC
;

/*
 * DEPARTMENTS 테이블에서 DEPARTMENT_NAME 에 
 * 소문자 i 또는 대문자 I 가 포함된 데이터들의
 * DEPARTMENT_ID, DEPARTMENT_NAME 을 
 * LOCATION_ID 로 내림차순 정렬하여 조회한다.
 */
SELECT DEPARTMENT_ID
     , DEPARTMENT_NAME
  FROM DEPARTMENTS
 WHERE DEPARTMENT_NAME LIKE '%i%'
    OR DEPARTMENT_NAME LIKE '%I%'
 ORDER BY LOCATION_ID DESC
;

/*
 * DEPARTMENTS 테이블에서 DEPARTMENT_NAME 에 
 * 'IT' 가 없는 모든 DEPARTMENT_NAME을 내림차순 하여 조회한다.
 */
SELECT DEPARTMENT_NAME
  FROM DEPARTMENTS
 WHERE DEPARTMENT_NAME NOT LIKE '%IT%'
 ORDER BY DEPARTMENT_NAME DESC
;

/*
 * DEPARMTENT 테이블에서 DEPARTMENT_NAME에 
 * 'Co' 가 포함되어 있지만, 'T'글자가 없는 모든
 * DEPARTMENT_NAME을 조회한다.
 */
SELECT DEPARTMENT_NAME
  FROM DEPARTMENTS
 WHERE DEPARTMENT_NAME LIKE '%Co%'
   AND DEPARTMENT_NAME NOT LIKE '%T%'
;

/*
 * EMPLOYEES 테이블에서 FIRST_NAME 이 3자리 글자인 데이터의
 * 모든 컬럼을 조회한다.
 */
SELECT *
  FROM EMPLOYEES
 WHERE FIRST_NAME LIKE '___'
;

/*
 * EMPLOYEES 테이블에서 FIRST_NAME의 다섯 번째 글자가 'd' 인
 * 데이터의 모든 컬럼을 조회한다.
 */
SELECT *
  FROM EMPLOYEES
 WHERE FIRST_NAME LIKE '____d'
;

/*
 * EMPLOYEES 테이블에서 LAST_NAME 의 두 번째 글자가 
 * 'e' 인 모든 데이터의 모든 컬럼을 조회한다.
 */
SELECT *
  FROM EMPLOYEES
 WHERE LAST_NAME LIKE '_e%'
;

/*
 * EMPLOYEES 테이블에서 JOB_ID 별 데이터의 수를 조회한다.
 */
SELECT JOB_ID
     , COUNT(1)
  FROM EMPLOYEES
 GROUP BY JOB_ID
;

/*
 * EMPLOYEES 테이블에서 DEPARTMENT_ID별 데이터의 수를 
 * 조회한다.
 * 
 * DEPARTMENT_ID, 데이터의 수
 */
SELECT DEPARTMENT_ID
	 , COUNT(1)
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
;

/*
 * EMPLOYEES 테이블에서 DEPARTMENT_ID 별 연봉(SALARY)의 합을 조회한다.
 * DEPARTMENT_ID | 연봉의 합
 */
SELECT DEPARTMENT_ID
 	 , SUM(SALARY)
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
;

/*
 * EMPLOYEES 테이블에서 JOB_ID 별 연봉(SALARY)의 합을 조회한다.
 * JOB_ID | 연봉의 합
 */
SELECT JOB_ID
	 , SUM(SALARY)
  FROM EMPLOYEES
 GROUP BY JOB_ID

/*
 * EMPLOYEES 테이블에서 DEPARTMENT_ID, JOB_ID 별 
 * 	연봉(SALARY)의 합을 조회한다.
 * DEPARTMENT_ID | JOB_ID | 연봉의 합
 */
 SELECT DEPARTMENT_ID
 	  , JOB_ID
 	  , SUM(SALARY)
   FROM EMPLOYEES
  GROUP BY DEPARTMENT_ID
  	  , JOB_ID
;


/*
 * EMPLOYEES 테이블에서 DEPARTMENT_ID 별 최고 연봉을 조회한다.
 * DEPARTMENT_ID | 최고연봉
 */
SELECT DEPARTMENT_ID
	 , MAX(SALARY)
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
;

/*
 * EMPLOYEES 테이블에서 JOB_ID 별 최저 연봉을 조회한다.
 * JOB_ID | 최저연봉
 */
SELECT JOB_ID
	 , MIN(SALARY)
  FROM EMPLOYEES
 GROUP BY JOB_ID
;

/*
 * EMPLOYEES 테이블에서 DEPARTMENT_ID, JOB_ID 별 
 * 	최고연봉을 조회한다.
 * DEPARTMENT_ID | JOB_ID | 최고연봉
 */
SELECT DEPARTMENT_ID
	 , JOB_ID
	 , MAX(SALARY)
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID 
     , JOB_ID

/*
 * EMPLOYEES 테이블의 최고 연봉과 최저 연봉, 평균 연봉, 연봉의 합을 조회한다.
 * 최고연봉 | 최저연봉 | 평균연봉 | 연봉의 합
 */
SELECT MAX(SALARY)
	 , MIN(SALARY)
	 , AVG(SALARY)
	 , SUM(SALARY)
  FROM EMPLOYEES
;

/*
 * EMPLOYEES 테이블에서 DEPARTMENT_ID 별 
 * 데이터의 수, 최고 연봉, 최저연봉, 평균연봉, 연봉의 합을 조회한다.
 * DEPARTMENT_ID|데이터의 수|최고 연봉|최저연봉|평균연봉|연봉의 합
 */
SELECT DEPARTMENT_ID
	 , COUNT(1)
	 , MAX(SALARY)
	 , MIN(SALARY)
	 , AVG(SALARY)
	 , SUM(SALARY)
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID  
;

/*
 * EMPLOYEES 테이블에서 MANAGER_ID 별
 * 데이터의 수, 최고 연봉, 최저연봉, 평균연봉, 연봉의 합을 조회한다.
 * MANAGER_ID|데이터의 수|최고 연봉|최저연봉|평균연봉|연봉의 합
 */
SELECT MANAGER_ID
	 , COUNT(1)
	 , MAX(SALARY)
	 , MIN(SALARY)
	 , AVG(SALARY)
	 , SUM(SALARY)
  FROM EMPLOYEES
 GROUP BY MANAGER_ID  
;

/*
 * EMPLOYEES 테이블에서 JOB_ID가 'SA_REP' 가 아닌 데이터에서
 * DEPARTMENT_ID 별 최고연봉과 최저연봉, 평균연봉을 조회한다.
 * DEPARTMENT_ID|최고연봉|최저연봉|평균연봉
 */
SELECT DEPARTMENT_ID
	 , MAX(SALARY)
	 , MIN(SALARY)
	 , AVG(SALARY)
  FROM EMPLOYEES
 WHERE JOB_ID != 'SA_REP'
 GROUP BY DEPARTMENT_ID
;

/*
 * DEPARTMENT_ID별 데이터가 3개 이상인 
 * DEPARTMENT_ID와 데이터의 수를 조회한다.
 * */
SELECT DEPARTMENT_ID
	 , COUNT(1)
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
HAVING COUNT(1) > 1
;

/*
 * EMPLOYEES 테이블에서 
 * 2명 이상의 부하직원(COUNT)을 데리고 있는 
 * 상사(MANAGER_ID)의 번호와 부하직원의 수를 조회한다.
 */
SELECT MANAGER_ID
	 , COUNT(1)
  FROM EMPLOYEES
 GROUP BY MANAGER_ID 
HAVING COUNT(1) >= 2
;

/*
 * EMPLOYEES 테이블에서 JOB_ID 별 평균연봉이 7000 이상인 
 * JOB_ID와 평균연봉, 최고연봉, 최저연봉을 조회한다.
 */
SELECT JOB_ID
	 , AVG(SALARY)
	 , MAX(SALARY)
	 , MIN(SALARY)
  FROM EMPLOYEES
 GROUP BY JOB_ID
HAVING AVG(SALARY) >= 7000
;

/*
 * EMPLOYEES 테이블에서 DEPARTMENT_ID 별 
 * 데이터의 수가 3 이상, 평균연봉이 5000 이상인
 * DEPARTMENT_ID와 데이터의 수, 평균연봉, 최고연봉, 최저연봉을 조회한다.
 */
SELECT DEPARTMENT_ID
	 , COUNT(1)
	 , AVG(SALARY)
	 , MAX(SALARY)
	 , MIN(SALARY)
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
HAVING COUNT(1) >= 3
   AND AVG(SALARY) >= 5000
;

/*
 * 최저 연봉보다 많이 받는 사원들의 모든 정보를 조회한다.
 * 만약 최저연봉이 3000 이라면
 */
SELECT *
  FROM EMPLOYEES
 WHERE SALARY > (SELECT MIN(SALARY)
                   FROM EMPLOYEES)
;

/*
 * 평균 연봉보다 많이 받는 사원들의 모든 정보를 조회한다.
 */
SELECT *
  FROM EMPLOYEES
 WHERE SALARY > (SELECT AVG(SALARY)
                   FROM EMPLOYEES)
;

/*
 * EMPLOYEES 테이블에서
 * FIRST_NAME은 'Steven'
 * LAST_NAME은 'King'
 * 을 MANAGER_ID 로 두고 있는 모든 데이터를 조회한다.
 */
SELECT *
  FROM EMPLOYEES
 WHERE MANAGER_ID = (SELECT EMPLOYEE_ID
                       FROM EMPLOYEES
                      WHERE FIRST_NAME = 'Steven'
                        AND LAST_NAME = 'King')
;
  
/*
 * EMPLOYEES 테이블에서 EMPLOYEE_ID 가 102번인 사원의 연봉과
 * 동일한 연봉을 받는 모든 사원의 정보를 조회한다.
 * 단, 102번은 조회에서 제외한다.
 */
SELECT *
  FROM EMPLOYEES
 WHERE SALARY = (SELECT SALARY
                   FROM EMPLOYEES
                  WHERE EMPLOYEE_ID = 102)
   AND EMPLOYEE_ID != 102
;

/*
 * EMPLOYEES 테이블에서 EMPLOYEE_ID가 113번과
 * 동일한 DEPARTMENT_ID를 가지는 모든 사원의 정보를 출력한다.
 * 단, 113번은 조회에서 제외한다.
 */
SELECT *
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                          FROM EMPLOYEES
                         WHERE EMPLOYEE_ID = 113)
   AND EMPLOYEE_ID != 113
;

/*
 * EMPLOYEES 테이블에서 
 * EMPLOYEE_ID 가 115번인 데이터의 JOB_ID와 
 * 같은 JOB_ID를 가진 데이터를 모두 조회한다.
 * 단, 115번은 조회에서 제외한다.
 */
SELECT *
  FROM EMPLOYEES
 WHERE JOB_ID = (SELECT JOB_ID
                   FROM EMPLOYEES
                  WHERE EMPLOYEE_ID = 115)
   AND EMPLOYEE_ID != 115
;

/*
 * EMPLOYEES 테이블에서 
 * FIRST_NAME이 J로 시작하는 데이터의 JOB_ID와 
 * 같은 JOB_ID를 가진 데이터를 모두 조회한다.
 */
SELECT *
  FROM EMPLOYEES
 WHERE JOB_ID = (SELECT JOB_ID
                   FROM EMPLOYEES
                  WHERE FIRST_NAME LIKE 'J%')
;

SELECT *
  FROM EMPLOYEES
 WHERE JOB_ID IN (SELECT JOB_ID
                   FROM EMPLOYEES
                  WHERE FIRST_NAME LIKE 'J%')
;

/*
 * EMPLOYEES 테이블에서
 * EMPLOYEE_ID가 116번, 201번의 데이터의 SALARY와
 * 같은 SALARY를 가진 데이터를 모두 조회한다.
 * 단, 116번과 201번은 조회에서 제외한다.
 */
SELECT *
  FROM EMPLOYEES
 WHERE SALARY IN (SELECT SALARY
                    FROM EMPLOYEES
                   WHERE EMPLOYEE_ID IN (116, 201))
   AND EMPLOYEE_ID NOT IN (116, 201)
;

/*
 * EMPLOYEES 테이블에서
 * EMPLOYEE_ID가 103번, 206, 115번의 데이터의 MANGER_ID와
 * 같은 MANGER_ID를 가진 데이터를 모두 조회한다.
 * 단, 103번, 206번, 115번은 조회에서 제외한다.
 */
SELECT *
  FROM EMPLOYEES
 WHERE MANAGER_ID IN (SELECT MANAGER_ID
                        FROM EMPLOYEES
                       WHERE EMPLOYEE_ID IN (103, 206, 115))
   AND EMPLOYEE_ID NOT IN (103, 206, 115)
;
