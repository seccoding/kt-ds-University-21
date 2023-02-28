/*
 * 과제:
 * 이름으로 오름차순 정렬된 데이터 중 상위 30개
 * 와
 * 부서명으로 내림차순 정렬된 데이터 중 상위 5개
 * 를 조인해
 * 이름, 부서명, 직무명을 조회
 */

/*이름으로 오름차순 정렬된 데이터 중 상위 30개 
 * 이름으로 오름차순 정렬 후
 * 상위 30개 추출
 * 추출 데이터는 
 *  이름
 * ,부서명과 비교할 부서id
 * ,직무와 비교할 직무id
 * 
 * 부서명으로 내림차순 정렬된 데이터 중 상위 5개
 * 부서명으로 내림차순 정렬 후
 * 상위 5개 추출
 * 추출 데이터는 
 *  직원의 부서id와 비교할 부서id
 * ,조회할 부서명
 * 
 * 마지막에 직무를 합치면 됨
 */
--이름으로 오름차순 정렬 후

/*
 * NULL 데이터를 제외시킬 경우
 * INNER JOIN으로 EMP와 DEP를
 * DEPARTMENT_ID를 비교하여 합치고
 * SELECT
 *   FROM
 *  INNER JOIN
 *     ON
 * 
 * 
 * DEPARTMENT 부분이 NULL인 경우를 포함시킬 경우
 * LEFT OUTER JOIN으로 비교하여 합치면 된다
 * 
 * 
 */

SELECT *
  FROM (SELECT FIRST_NAME 
  			 , DEPARTMENT_ID
  			 , JOB_ID
          FROM EMPLOYEES
         ORDER BY FIRST_NAME ASC)
 WHERE ROWNUM <= 30
 ;

-- 부서명으로 내림차순 정렬 후
-- 상위 5개 추출
SELECT *
  FROM (SELECT DEPARTMENT_ID
             , DEPARTMENT_NAME
  		  FROM DEPARTMENTS
 		 ORDER BY DEPARTMENT_NAME DESC)
 WHERE ROWNUM <= 5
 ;
 -- INNER JOIN
/*
 * 직무명을 조회하기 위해 JOBS를 JOIN한다
 */

SELECT EMP.FIRST_NAME
	 , DEP.DEPARTMENT_NAME
	 , JOB.JOB_TITLE 
  FROM (SELECT FIRST_NAME 
  			 , DEPARTMENT_ID
		  	 , JOB_ID
  		  FROM (SELECT FIRST_NAME 
  					 , DEPARTMENT_ID
		  			 , JOB_ID
        		  FROM EMPLOYEES
		         ORDER BY FIRST_NAME ASC)
		 WHERE ROWNUM <= 30) EMP
 INNER JOIN (SELECT DEPARTMENT_ID
			      , DEPARTMENT_NAME
  			   FROM (SELECT DEPARTMENT_ID
			              , DEPARTMENT_NAME
			   		   FROM DEPARTMENTS
			 		  ORDER BY DEPARTMENT_NAME DESC)
			  WHERE ROWNUM <= 5) DEP
 	ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
 INNER JOIN JOBS JOB
 	ON EMP.JOB_ID = JOB.JOB_ID 
 	
 ;
