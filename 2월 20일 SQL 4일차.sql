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



-- 8. CASE
-- 연봉이 평균연봉보다 많이 받으면 "고액연봉"
-- 연봉이 평균연봉보다 적게 받으면 "저연봉"
-- 둘 다 아니면, "평균연봉"
-- 으로 조회

-- 9. NVL
-- 상사가 없는 경우 "-" 로 출력


                            
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
