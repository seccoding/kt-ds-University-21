--1. 부서장 정보 조회
--    - 부서장들의 부서명, 사원정보
-- 	  - Case 1 Scala Query
-- 부서정보 테이블에서 부서장번호를 조회한다.
SELECT MANAGER_ID
     , DEPARTMENT_NAME
     , (SELECT FIRST_NAME
          FROM EMPLOYEES
         WHERE EMPLOYEE_ID = DEP.MANAGER_ID) AS FIRST_NAME
     , (SELECT LAST_NAME
          FROM EMPLOYEES
         WHERE EMPLOYEE_ID = DEP.MANAGER_ID) LAST_NAME 
  FROM DEPARTMENTS DEP
 WHERE MANAGER_ID IS NOT NULL
;

SELECT MANAGER_ID
     , DEPARTMENT_NAME
     , (SELECT FIRST_NAME || ' ' || LAST_NAME
          FROM EMPLOYEES
         WHERE EMPLOYEE_ID = DEP.MANAGER_ID) NAME
  FROM DEPARTMENTS DEP
 WHERE MANAGER_ID IS NOT NULL
;
--	  - Case 2 Join
SELECT DEP.DEPARTMENT_NAME 
     , EMP.FIRST_NAME 
     , EMP.LAST_NAME 
  FROM EMPLOYEES EMP
 INNER JOIN DEPARTMENTS DEP
    ON EMP.EMPLOYEE_ID = DEP.MANAGER_ID 
;

--2. 재귀 조인
--    - 사원들의 상사를 조회
-- 부하직원의 사원번호, 이름, 성, 상사의 사원번호, 이름, 성
SELECT EMP.EMPLOYEE_ID 
     , EMP.FIRST_NAME 
     , EMP.LAST_NAME 
     , (SELECT EMPLOYEE_ID
          FROM EMPLOYEES
         WHERE EMPLOYEE_ID = EMP.MANAGER_ID) MANAGER_ID
     , (SELECT FIRST_NAME
          FROM EMPLOYEES 
         WHERE EMPLOYEE_ID = EMP.MANAGER_ID) MANAGER_FIRST_NAME
     , (SELECT LAST_NAME
          FROM EMPLOYEES
         WHERE EMPLOYEE_ID = EMP.MANAGER_ID) MANAGER_LAST_NAME
  FROM EMPLOYEES EMP -- 부하직원
 WHERE MANAGER_ID IS NOT NULL
;

SELECT EMP.EMPLOYEE_ID 
     , EMP.FIRST_NAME 
     , EMP.LAST_NAME 
     , MAN.EMPLOYEE_ID MANAGER_ID
     , MAN.FIRST_NAME MANAGER_FIRST_NAME
     , MAN.LAST_NAME MANAGER_LAST_NAME
  FROM EMPLOYEES EMP -- 부하직원
 INNER JOIN EMPLOYEES MAN -- 상사
    ON EMP.MANAGER_ID = MAN.EMPLOYEE_ID 
;

--3. 계층 조회
--    - 계층으로 보여주기
 SELECT LEVEL 
      , EMPLOYEE_ID
      , FIRST_NAME
      , LAST_NAME
      , MANAGER_ID
   FROM EMPLOYEES
  START WITH MANAGER_ID IS NULL
CONNECT BY PRIOR EMPLOYEE_ID = MANAGER_ID
;
 
-- 113번 사원의 모든 상사를 조회 (계층쿼리)
 SELECT LEVEL
      , EMPLOYEE_ID
      , FIRST_NAME
      , LAST_NAME 
      , MANAGER_ID
   FROM EMPLOYEES
  START WITH EMPLOYEE_ID = 113
CONNECT BY PRIOR MANAGER_ID = EMPLOYEE_ID 
  ORDER BY LEVEL DESC
;

-- 5. (NOT) EXISTS
-- 부하직원이 없는 말단사원의 모든 사원정보 조회
SELECT *
  FROM EMPLOYEES E1
 WHERE NOT EXISTS (SELECT 1
                     FROM EMPLOYEES E2
                    WHERE E2.MANAGER_ID = E1.EMPLOYEE_ID)
;

-- 부하직원이 있는 사원의 모든 사원정보 조회
SELECT *
  FROM EMPLOYEES E1
 WHERE EXISTS (SELECT 1
                 FROM EMPLOYEES E2
                WHERE E2.MANAGER_ID = E1.EMPLOYEE_ID)
;

-- 6. (NOT) IN
-- 부하직원이 없는 말단사원의 모든 사원정보 조회
SELECT *
  FROM EMPLOYEES E1
 WHERE E1.EMPLOYEE_ID NOT IN (SELECT MANAGER_ID
                                FROM EMPLOYEES E2
                               WHERE E2.MANAGER_ID = E1.EMPLOYEE_ID)
;

-- 부하직원이 있는 사원의 모든 사원정보 조회
SELECT *
  FROM EMPLOYEES E1
 WHERE E1.EMPLOYEE_ID IN (SELECT MANAGER_ID
                            FROM EMPLOYEES E2)

-- 7. DECODE 
-- AD_PRES -> AP
-- AD_VP -> AV
-- IT_PROG -> IP
-- FI_MGR -> FM
-- FI_ACCOUNT -> FA
-- PU_MAN -> PM
-- 다 아니면 '-'
-- 으로 변환하여 조회
-- JOB_ID, MIN_JOB_ID
SELECT JOB_ID
     , DECODE(JOB_ID
            , 'AD_PRES', 'AP'
            , 'AD_VP', 'AV'
            , 'IT_PROG', 'IP'
            , 'FI_MGR', 'FM'
            , 'FI_ACCOUNT', 'FA'
            , 'PU_MAN', 'PM'
            , '-') AS MIN_JOB_ID
  FROM EMPLOYEES
;

-- JOB_ID 의 자리수가 4라면 'FOUR'
--                 5라면 'FIVE'
--                 6이라면 'SIX'
--                 그 외 '-'
SELECT JOB_ID
     , LENGTH(JOB_ID)
     , DECODE(LENGTH(JOB_ID)
            , 4, 'FOUR'
            , 5, 'FIVE'
            , 6, 'SIX'
            , '-') LEN
  FROM EMPLOYEES
;

-- 8. CASE
-- AD_PRES -> AP
-- AD_VP -> AV
-- IT_PROG -> IP
-- FI_MGR -> FM
-- FI_ACCOUNT -> FA
-- PU_MAN -> PM
-- 다 아니면 '-'
-- 으로 변환하여 조회
-- JOB_ID, MIN_JOB_ID
SELECT JOB_ID
     , CASE JOB_ID
          WHEN 'AD_PRES' THEN 
             'AP'
          WHEN 'AD_VP' THEN 
             'AV'
          WHEN 'IT_PROG' THEN 
             'IP'
          WHEN 'FI_MGR' THEN 
             'FM'
          ELSE
             '-'
        END MIN_JOB_ID
  FROM EMPLOYEES
;

-- 연봉이 평균연봉보다 많이 받으면 "고액연봉"
-- 연봉이 평균연봉보다 적게 받으면 "저연봉"
-- 둘 다 아니면, "평균연봉"
-- 으로 조회
SELECT AVG(SALARY)
  FROM EMPLOYEES
;

SELECT SALARY
     , CASE 
	     WHEN SALARY >= (SELECT AVG(SALARY)
	                       FROM EMPLOYEES) THEN
	     	'고액연봉'
	     WHEN SALARY < (SELECT AVG(SALARY)
                          FROM EMPLOYEES) THEN
	     	'저연봉'
	     ELSE
	     	'평균연봉'
	   END SALARY_TYPE
  FROM EMPLOYEES
;

-- 9. NVL
-- 상사가 없는 경우 '-' 로 출력
-- NVL
SELECT EMPLOYEE_ID
     , MANAGER_ID
     , NVL(MANAGER_ID, -1)
     , NVL(TO_CHAR(MANAGER_ID), '-')
  FROM EMPLOYEES
;
-- CASE
SELECT EMPLOYEE_ID
     , MANAGER_ID
     , CASE 
     	WHEN MANAGER_ID IS NULL THEN
--     		-1
     		'-'
     	ELSE
--     		MANAGER_ID
     		TO_CHAR(MANAGER_ID)
       END NVL_MANAGER_ID
  FROM EMPLOYEES
;
                            
-- 10. LPAD
-- 11. RPAD
-- 12. TO_CHAR
-- 13. TO_DATE
-- 14. SUBSTR
-- 15. LEN
-- 16. LTRIM
-- 17. RTRIM
-- 18. TRIM
-- 19. ADD_MONTHS
-- 20. SYSDATE
