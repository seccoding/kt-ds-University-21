/*
 * 과제:
 * 이름으로 오름차순 정렬된 데이터 중 상위 30개와
 * 부서명으로 내림차순 정렬된 데이터 중 상위 5개를 조인해
 * 이름, 부서명, 직무명을 조회
 */


/*
 * 도시, 부서명, 이름, 성을 조회.
 */
SELECT LOC.CITY 
     , DEP.DEPARTMENT_NAME 
     , EMP.FIRST_NAME 
     , EMP.LAST_NAME 
  FROM EMPLOYEES EMP
 INNER JOIN DEPARTMENTS DEP
    ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID 
 INNER JOIN LOCATIONS LOC
    ON DEP.LOCATION_ID = LOC.LOCATION_ID 
;

/*
 * 'Canada' 에 근무하는 사원의 이름과 부서명을 조회.
 */
SELECT EMP.FIRST_NAME 
	 , DEP.DEPARTMENT_NAME 
  FROM EMPLOYEES EMP
 INNER JOIN DEPARTMENTS DEP
    ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID 
 INNER JOIN LOCATIONS LOC
    ON DEP.LOCATION_ID = LOC.LOCATION_ID 
 INNER JOIN COUNTRIES COU
    ON LOC.COUNTRY_ID = COU.COUNTRY_ID 
 WHERE COU.COUNTRY_NAME = 'Canada'
;

/*
 * 'SA_REP' 직무인 사원의 
 * 이름, 성, 연봉, 부서명, 직무명을 조회
 */
SELECT EMP.FIRST_NAME 
     , EMP.LAST_NAME 
     , EMP.SALARY 
     , DEP.DEPARTMENT_NAME 
     , JOB.JOB_TITLE 
  FROM EMPLOYEES EMP
 INNER JOIN JOBS JOB
    ON JOB.JOB_ID = EMP.JOB_ID
 INNER JOIN DEPARTMENTS DEP
    ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID 
 WHERE JOB.JOB_ID = 'SA_REP'
;
/*
 * 'MK_REP' 직무였던 사원의 
 * 이름, 성, 연봉, 부서명, 현재 직무명을 조회
 */
SELECT EMP.FIRST_NAME 
     , EMP.LAST_NAME 
     , EMP.SALARY 
     , DEP.DEPARTMENT_NAME 
     , JOB.JOB_TITLE 
  FROM EMPLOYEES EMP
 INNER JOIN JOB_HISTORY JH
    ON EMP.EMPLOYEE_ID = JH.EMPLOYEE_ID 
 INNER JOIN DEPARTMENTS DEP
    ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID 
 INNER JOIN JOBS JOB
    ON EMP.JOB_ID = JOB.JOB_ID 
 WHERE JH.JOB_ID = 'MK_REP'
;

/*
 * 'New Jersey' 주에서 근무중인 
 * 사원의 이름, 부서명, 연봉을 조회
 */
SELECT EMP.FIRST_NAME 
     , DEP.DEPARTMENT_NAME 
     , EMP.SALARY 
  FROM EMPLOYEES EMP
 INNER JOIN DEPARTMENTS DEP
    ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID 
 INNER JOIN LOCATIONS LOC
    ON DEP.LOCATION_ID = LOC.LOCATION_ID 
 WHERE LOC.STATE_PROVINCE = 'New Jersey'
;

/*
 * 'C'로 시작하는 도시에서 근무중인 
 * 사원의 이름, 부서명, 직무명, 도시명을 조회
 */
SELECT EMP.FIRST_NAME 
     , DEP.DEPARTMENT_NAME 
     , JOB.JOB_TITLE
     , LOC.CITY 
  FROM EMPLOYEES EMP
 INNER JOIN DEPARTMENTS DEP
    ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID 
 INNER JOIN LOCATIONS LOC
    ON DEP.LOCATION_ID = LOC.LOCATION_ID 
 INNER JOIN JOBS JOB
    ON EMP.JOB_ID = JOB.JOB_ID 
 WHERE LOC.CITY LIKE 'C%'
;

/*
 * 우편번호에 '7' 이 포함된 도시에서 근무중인 
 * 사원들의 사원번호, 직무명을 조회
 */
SELECT EMP.EMPLOYEE_ID 
     , JOB.JOB_TITLE 
  FROM EMPLOYEES EMP
 INNER JOIN DEPARTMENTS DEP
    ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID 
 INNER JOIN LOCATIONS LOC
    ON DEP.LOCATION_ID = LOC.LOCATION_ID 
 INNER JOIN JOBS JOB
    ON EMP.JOB_ID = JOB.JOB_ID 
 WHERE LOC.POSTAL_CODE LIKE '%7%'
;

/*
 * 회사 전체 평균연봉보다 많은 연봉을 받는 사원들의 
 * 이름과 부서명을 조회
 */
-- 평균연봉 = 6461.831
SELECT AVG(SALARY)
  FROM EMPLOYEES
;

SELECT *
  FROM EMPLOYEES EMP
 INNER JOIN DEPARTMENTS DEP
    ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID 
 WHERE EMP.SALARY > (SELECT AVG(SALARY)
                       FROM EMPLOYEES)
;


/*
 * Asia에 근무중인 사원들의
 * 사원번호, 이름, 성, 부서명, 직무명, 도시명을 조회
 */
SELECT EMP.EMPLOYEE_ID 
     , EMP.FIRST_NAME 
     , EMP.LAST_NAME 
     , DEP.DEPARTMENT_NAME 
     , JOB.JOB_TITLE 
     , LOC.CITY 
  FROM EMPLOYEES EMP
 INNER JOIN DEPARTMENTS DEP
    ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID 
 INNER JOIN LOCATIONS LOC
    ON DEP.LOCATION_ID = LOC.LOCATION_ID 
 INNER JOIN COUNTRIES COU
    ON LOC.COUNTRY_ID = COU.COUNTRY_ID 
 INNER JOIN REGIONS REG
    ON COU.REGION_ID = REG.REGION_ID 
 INNER JOIN JOBS JOB
    ON EMP.JOB_ID = JOB.JOB_ID 
 WHERE REG.REGION_NAME = 'Asia'
;

/*
 * 사원의 이름과 부서명을 조회.
 * 부서에 포함되어있거나 포함되지 않은 사원도 모두 조회.
 */
SELECT *
  FROM 기준테이블
  LEFT OUTER JOIN 참고테이블
    ON 기준테이블.PK = 참고테이블.FK
;

SELECT EMP.FIRST_NAME 
     , DEP.DEPARTMENT_NAME 
  FROM EMPLOYEES EMP
  LEFT OUTER JOIN DEPARTMENTS DEP
    ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID 
;

/*
 * 모든 도시에 위치한 부서를 조회.
 * 도시, 부서명
 */
SELECT LOC.CITY
     , DEP.DEPARTMENT_NAME 
  FROM LOCATIONS LOC
  LEFT OUTER JOIN DEPARTMENTS DEP
    ON LOC.LOCATION_ID = DEP.LOCATION_ID 
;

/*
 * 모든 도시의 도시별 부서의 개수를 조회
 * 도시명 | 부서 개수
 */
SELECT LOC.CITY 
     , COUNT(DEP.DEPARTMENT_ID)
  FROM LOCATIONS LOC
  LEFT OUTER JOIN DEPARTMENTS DEP
    ON LOC.LOCATION_ID = DEP.LOCATION_ID 
 GROUP BY LOC.CITY
;

/*
 * 국가별 지역의 개수를 조회.
 */
SELECT COU.COUNTRY_NAME 
     , COUNT(LOC.LOCATION_ID)
  FROM COUNTRIES COU
  LEFT OUTER JOIN LOCATIONS LOC
    ON COU.COUNTRY_ID = LOC.COUNTRY_ID 
 GROUP BY COU.COUNTRY_NAME 
;

/*
 * 직무별 사원의 수를 조회.
 */
SELECT JOB.JOB_TITLE 
     , COUNT(EMP.EMPLOYEE_ID)
  FROM JOBS JOB
  LEFT OUTER JOIN EMPLOYEES EMP
    ON JOB.JOB_ID = EMP.JOB_ID 
 GROUP BY JOB.JOB_TITLE 
;

/*
 * 직무별 사원의 수를 조회.
 * 단, 사원의 수가 5명 이상인 직무만 조회한다.
 */
SELECT JOB.JOB_TITLE 
	 , COUNT(EMP.EMPLOYEE_ID)
  FROM JOBS JOB
  LEFT OUTER JOIN EMPLOYEES EMP
    ON JOB.JOB_ID = EMP.JOB_ID 
 GROUP BY JOB.JOB_TITLE 
HAVING COUNT(EMP.EMPLOYEE_ID) >= 5
;

/*
 * 사원이 단 한명도 없는 부서명을 조회
 */ 
SELECT DEP.DEPARTMENT_NAME 
  FROM DEPARTMENTS DEP
  LEFT OUTER JOIN EMPLOYEES EMP
    ON DEP.DEPARTMENT_ID = EMP.DEPARTMENT_ID 
 GROUP BY DEP.DEPARTMENT_NAME 
HAVING COUNT(EMP.EMPLOYEE_ID) = 0
;

SELECT DEP.DEPARTMENT_NAME 
  FROM DEPARTMENTS DEP
  LEFT OUTER JOIN EMPLOYEES EMP
    ON DEP.DEPARTMENT_ID = EMP.DEPARTMENT_ID 
 WHERE EMP.EMPLOYEE_ID IS NULL
;

/*
 * 대륙별 지역의 수를 조회
 */
SELECT REG.REGION_NAME 
     , COUNT(LOC.LOCATION_ID)
  FROM REGIONS REG
  LEFT OUTER JOIN COUNTRIES COU
    ON REG.REGION_ID = COU.REGION_ID 
  LEFT OUTER JOIN LOCATIONS LOC
    ON COU.COUNTRY_ID = LOC.COUNTRY_ID 
 GROUP BY REG.REGION_NAME 
;

/*
 * 지역별 사원의 수를 조회
 */
SELECT LOC.CITY 
     , COUNT(EMP.EMPLOYEE_ID)
  FROM LOCATIONS LOC
  LEFT OUTER JOIN DEPARTMENTS DEP
    ON LOC.LOCATION_ID = DEP.LOCATION_ID 
  LEFT OUTER JOIN EMPLOYEES EMP
    ON DEP.DEPARTMENT_ID = EMP.DEPARTMENT_ID 
 GROUP BY LOC.CITY 
;

/*
 * INLINE VIEW 문제
 * 2005년에 입사한 사원들의 부서명과 이름을 조회 
 */
SELECT DEP.DEPARTMENT_NAME
     , EMP_05.FIRST_NAME
  FROM (SELECT FIRST_NAME
             , DEPARTMENT_ID
          FROM EMPLOYEES
         WHERE HIRE_DATE BETWEEN TO_DATE('2005-01-01', 'YYYY-MM-DD') AND TO_DATE('2005-12-31', 'YYYY-MM-DD') ) EMP_05 -- INLINE VIEW
 INNER JOIN DEPARTMENTS DEP
    ON EMP_05.DEPARTMENT_ID = DEP.DEPARTMENT_ID 
;

/*
 * 연봉을 많이 받는 사람들 중 상위 10명의 이름과 부서명을 조회
 */
-- 연봉을 많이 받는 사원 상위 10명 조회
SELECT *
  FROM (SELECT *
          FROM EMPLOYEES
         ORDER BY SALARY DESC)
 WHERE ROWNUM <= 10
;

-- 부서명까지 조회
SELECT EMP.FIRST_NAME
     , DEP.DEPARTMENT_NAME 
  FROM (SELECT FIRST_NAME
             , DEPARTMENT_ID
          FROM EMPLOYEES
         ORDER BY SALARY DESC) EMP
 INNER JOIN DEPARTMENTS DEP
    ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID 
 WHERE ROWNUM <= 10
 ;

/*
 * 이름으로 내림차순 정렬된 데이터중 상위 20개의
 * 사원번호, 이름, 부서명을 조회
 */
-- 이름으로 내림차순 정렬된 데이터
SELECT *
  FROM EMPLOYEES
 ORDER BY FIRST_NAME DESC
;
-- 이름으로 내림차순 정렬된 데이터중 상위 20개
SELECT *
  FROM (SELECT *
          FROM EMPLOYEES
         ORDER BY FIRST_NAME DESC)
 WHERE ROWNUM <= 20
;
-- 완성 쿼리
SELECT EMP.EMPLOYEE_ID
     , EMP.FIRST_NAME
     , DEP.DEPARTMENT_NAME 
  FROM (SELECT EMPLOYEE_ID
             , FIRST_NAME
             , DEPARTMENT_ID
          FROM EMPLOYEES
         ORDER BY FIRST_NAME DESC) EMP
 INNER JOIN DEPARTMENTS DEP
    ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID 
 WHERE ROWNUM <= 20
;
  
/*
 * 사원수가 가장 많은 부서의 사원명, 부서명을 조회
 */
-- 사원수가 가장 많은 부서 (사원 수 정렬)
SELECT COUNT(1) AS CNT
     , DEPARTMENT_ID
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
 ORDER BY CNT DESC
;
-- 그 중 1개 부서를 조회
SELECT DEPARTMENT_ID
  FROM (SELECT COUNT(1) AS CNT
             , DEPARTMENT_ID
          FROM EMPLOYEES
         GROUP BY DEPARTMENT_ID
         ORDER BY CNT DESC)
 WHERE ROWNUM = 1
 
-- 완성
SELECT DEP.DEPARTMENT_NAME 
     , EMP.FIRST_NAME 
  FROM (SELECT DEPARTMENT_ID
          FROM (SELECT COUNT(1) AS CNT
		             , DEPARTMENT_ID
                  FROM EMPLOYEES
                 GROUP BY DEPARTMENT_ID
                 ORDER BY CNT DESC)
         WHERE ROWNUM = 1) TOP_DEP
  INNER JOIN DEPARTMENTS DEP
     ON TOP_DEP.DEPARTMENT_ID = DEP.DEPARTMENT_ID 
  INNER JOIN EMPLOYEES EMP
     ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID 
;

SELECT DEP.DEPARTMENT_NAME 
     , EMP.FIRST_NAME 
  FROM DEPARTMENTS DEP
 INNER JOIN EMPLOYEES EMP
    ON DEP.DEPARTMENT_ID = EMP.DEPARTMENT_ID 
 WHERE DEP.DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                              FROM (SELECT COUNT(1) AS CNT
                                         , DEPARTMENT_ID
                                      FROM EMPLOYEES
                                     GROUP BY DEPARTMENT_ID
                                     ORDER BY CNT DESC)
                             WHERE ROWNUM = 1)
;
