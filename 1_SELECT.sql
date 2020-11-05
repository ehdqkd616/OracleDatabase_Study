-- SELECT
-- Result Set : SELECT 구문으로 데이터를 조회한 결과물, 반환된 행들의 집합 (0행 이상)

-- EMPLOYEE테이블의 사번과 이름, 급여 조회
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;

-- EMPLOYEE테이블의 모든 사원의 모든 정보 조회
SELECT EMP_ID,EMP_NAME,EMP_NO,EMAIL,PHONE,DEPT_CODE,JOB_CODE,SAL_LEVEL,SALARY,BONUS,MANAGER_ID,HIRE_DATE,ENT_DATE,ENT_YN 
FROM EMPLOYEE;

SELECT * 
FROM EMPLOYEE;

-- 미니 실습 문제
-- 1. JOB테이블의 모든 정보 조회
SELECT * FROM JOB;
-- 2. JOB테이블의 직급 이름 조회
SELECT JOB_NAME FROM JOB;
-- 3. DEPARTMENT테이블의 모든 정보 조회
SELECT * FROM DEPARTMENT;
-- 4. EMPLOYEE테이블의 직원명, 이메일, 전화번호, 고용일 조회
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE FROM EMPLOYEE;
-- 5. EMPLOYEE테이블의 고용일, 사원 이름, 월급 조회
SELECT HIRE_DATE, EMP_NAME,SALARY FROM EMPLOYEE;

-- 컬럼 값 산술 연산
-- SELECT 시 컬럼 명 입력 부분에 계산에 필요한 컬럼 명, 숫자, 연산자를 이용해서 결과 조회 가능

-- EMPLOYEE 테이블에 직원 명, 연봉 조회 (연봉 = 급여*12)
SELECT EMP_NAME,SALARY*12
FROM EMPLOYEE;

-- EMPLOYEE테이블에서 직원의 직원 명, 연봉, 보너스를 추가한 연봉 조회
SELECT EMP_NAME, SALARY*12, (SALARY + SALARY*BONUS) * 12
FROM EMPLOYEE;

SELECT EMP_NAME, SALARY*12, (SALARY *(1+BONUS)) * 12
FROM EMPLOYEE;

-- 미니 실습 문제 2!
-- 1. EMPLOYEE 테이블에서 이름, 연봉, 총수령액(보너스포함), 실수령액(총수령액 - (연봉*세금3%)) 조회
SELECT EMP_NAME,SALARY*12, (SALARY *(1+BONUS)) * 12 , ((SALARY *(1+BONUS)) * 12) - (SALARY*12*0.03) 
FROM EMPLOYEE;
-- 2. EMPLOYEE 테이블에서 이름, 고용일, 근무일수(오늘 날짜 - 고용일) 조회
SELECT EMP_NAME, HIRE_DATE, FLOOR(SYSDATE - HIRE_DATE)
FROM EMPLOYEE;

SELECT SYSDATE - HIRE_DATE 근무일수, ROUND(SYSDATE - HIRE_DATE) 반올림, CEIL(SYSDATE - HIRE_DATE) 올림,
       FLOOR(SYSDATE - HIRE_DATE) 내림, TRUNC(SYSDATE - HIRE_DATE) 버림
FROM EMPLOYEE;

-- 컬럼 별칭 쓰는 법 4가지

-- 컬럼 명 AS 별칭
-- 컬럼 명 "별칭"
-- 컬럼 명 AS "별칭"
-- 컬럼 명 별칭
-- 별칭에 띄어쓰기, 특수문자, 숫자 포함될 경우 무조건 ""으로 묶어야함

-- EMPLOYEE 테이블에서 직원의 직원명 (별칭 : 이름), 연봉(별칭 : 연봉(원)), 보너스를 추가한 연봉 (별칭 : 총소득(원)) 조회
SELECT EMP_NAME 이름, SALARY*12 "연봉(원)",  SALARY * (1+BONUS) * 12 AS "총소득(원)"
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 이름, 고용일, 근무일수(오늘날짜 - 고용일) 조회
SELECT EMP_NAME AS 이름, HIRE_DATE AS 고용일, SYSDATE-HIRE_DATE 근무일수
FROM EMPLOYEE
WHERE EMP_NAME != '선동일';

-- 리터럴
-- 테이블 안에 값은 없는데 컬럼에 있는것 처럼 지정하는것 SELECT절에 사용
-- 문자나 날짜 리터럴은 ' ' 기호 사용되며 모든 행에 반복 표시 됨

-- EMPLOYEE 테이블에서 직원의 직원 번호, 사원 명, 급여, 단위(데이터 값 : 원) 조회
SELECT EMP_ID "직원 번호", EMP_NAME "사원 명", SALARY 급여, '원' 단위
FROM EMPLOYEE;


-- DISTINCT 컬럼에 포함된 중복 값을 한 번씩만 표기하고자 할 때 사용
-- DISTINCT는 SELECT절에 딱 한번만 쓸 수 있음
-- 두개 같이 중복제거 할경우 행 끼리 겹치진 않음
SELECT JOB_CODE
FROM EMPLOYEE;

-- 직급코드 중복제거
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

-- 직급코드, 부서코드 중복제거 하여 조회
SELECT DISTINCT DEPT_CODE, JOB_CODE
FROM EMPLOYEE;

-- WHERE절 : SELECT에 걸리는 조건문이 들어가는 절
-- 조회할 테이블에서 조건이 맞는 값을 가진 행을 골라냄
-- 비교 연산자
-- = 같냐, > 크냐, < 작냐, >= 크거나 같냐, <= 작거나 같냐
-- !=,^=,<> 안 같냐

-- 부서코드가 'D9'인 직원 이름, 부서코드 조회
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- 급여가 4000000 이상인 직원의 이름, 급여 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- 부서코드가 D9이 아닌 사원의 사번, 이름, 부서코드 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
-- WHERE DEPT_CODE != 'D9';
-- WHERE DEPT_CODE ^= 'D9';
WHERE DEPT_CODE <> 'D9';

-- EMPLOYEE테이블에서 퇴사 여부가 N인 직원을 조회하고
-- 근무 여부를 재직중으로 표시하여 사번, 이름, 고용일, 근무 여부 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE, '재직중' 근무여부
FROM EMPLOYEE
WHERE ENT_YN = 'N';

-- 미니 실습 문제
-- 월급 3000000이상인 사원 이름, 월급, 고용일 조회
SELECT EMP_NAME 이름, SALARY 월급, HIRE_DATE 고용일
FROM EMPLOYEE
WHERE SALARY >= 3000000;
-- SAL_LEVEL이 S1인 사원의 이름, 월급, 고용일, 연락처 조회
SELECT EMP_NAME 이름, SALARY 월급, HIRE_DATE 고용일, PHONE 연락처
FROM EMPLOYEE
WHERE SAL_LEVEL = 'S1';
-- 실수령액(총수령액 - (연봉*세금3%))이 5천만원 이상인 사원의 이름,월급,실수령액,고용일 조회
SELECT EMP_NAME 이름, SALARY 월급, (SALARY*12*(1+BONUS)) - (SALARY*12*0.03) 실수령액, HIRE_DATE 고용일
FROM EMPLOYEE
WHERE (SALARY*12*(1+BONUS)) - (SALARY*12*0.03) >= 50000000;

-- 논리 연산자 : AND / OR
-- EMPLOYEE테이블에서 부서코드가 'D6'이고 급여를 2백만원 보다 많이 받는 직원의 이름, 부서코드, 급여 조회
SELECT EMP_NAME 이름, DEPT_CODE 부서코드, SALARY 급여
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' AND SALARY > 2000000;

-- 부서코드가 'D6'이거나 급여를 2백만원보다 많이 받는 직원의 이름, 부서코드, 급여 조회
SELECT EMP_NAME 이름, DEPT_CODE 부서코드, SALARY 급여
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR SALARY > 2000000;

-- 급여를 350만 이상 600만 이하를 받는 직원의 사번, 이름, 급여, 부서코드, 직급 코드 조회
SELECT EMP_ID 사번, EMP_NAME 이름, SALARY 급여, DEPT_CODE 부서코드, JOB_CODE "직급 코드"
FROM EMPLOYEE
WHERE 6000000 >= SALARY AND SALARY >= 3500000;

-- 미니 실습 문제
-- 월급이 400만이상이고 JOB_CODE가 J2인 사원의 전체 내용 조회
SELECT *
FROM EMPLOYEE
WHERE JOB_CODE = 'J2' AND SALARY >= 4000000;
-- DEPT_CODE가 D9이거나 D5인 사원 중 고용일이 02년 1월 1일 보다 빠른 사원의 이름, 부서코드, 고용일 조회
SELECT EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE = 'D9' OR DEPT_CODE = 'D5') AND '02/01/01' > HIRE_DATE;

-- BETWEEN AND : 하한 값 이상 상한 값 이하
-- 컬럼명 BETWEEN 하한 값 AND 상한 값
-- 하한 값 <= 컬럼 <= 상한 값

-- 급여 350만 보다 많이 600만 보다 적게 받는 사원의 이름, 급여 조회
SELECT EMP_NAME,SALARY
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000;

SELECT EMP_NAME,SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;

-- 반대로 350만 미만, 또는 600만을 초과하는 직원의 사번, 이름, 급여, 부서코드, 직급코드 조회(NOT)

SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE SALARY NOT BETWEEN 3500000 AND 6000000;

SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE NOT SALARY BETWEEN 3500000 AND 6000000;

-- 미니 실습 문제
-- 고용일이 '90/01/01'~'01/01/01' 인 사원의 전체 내용 조회
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';

-- LIKE : 비교하려는 값이 지정한 특정 패턴을 만족 시키는지 조회
-- %,_
-- % : 0글자 이상
-- _ : 1글자
-- '글자%' : 글자로 시작하는 값
-- '%글자%' : 글자를 포함하는 값
-- '%글자' : 글자로 끝나는 값
-- '_' : 한 글자
-- '__' : 두 글자
-- '박__' : 박으로 시작되는 세 글자
-- '글자_' : 글자로 시작하는 세 글자
-- '_글자_' : 앞뒤에 한글자씩있고 가운데 글자가 있는 값
-- '_글자' : 글자로 끝나는 세 글자

-- 성이 전씨인 사원의 사번, 이름, 고용일 조회
SELECT EMP_ID 사번, EMP_NAME 이름, HIRE_DATE 고용일
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';

-- 이름에 '하'가 포함된 직원의 이름, 주민번호, 부서코드 조회
SELECT EMP_NAME 이름, EMP_NO 주민번호, DEPT_CODE 부서코드
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%';

-- 전화번호 4번째 자리가 9로 시작하는 사원의 사번, 이름, 전화번호 조회
SELECT EMP_ID 사번, EMP_NAME 이름, PHONE 전화번호
FROM EMPLOYEE
WHERE PHONE LIKE '___9%';

-- 이메일 중 _ 앞글자가 3자리인 이메일 주소를 가진 사원의 사번, 이름, 이메일 주소 조회
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '____%';
-- 와일드카드인 _가 검색하고자 하는 조건 안에 들어가는 문자와 같기 때문에
-- 문자 자체가 아닌 와일드 카드로 인식

-- ESCAPE OPTION : 데이터로 처리할 패턴 기호 앞에 임의의 문자를 사용하고 ESCAPE OPTION 등록
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
--WHERE EMAIL LIKE '___#_%' ESCAPE '#';
--WHERE EMAIL LIKE '___A_%' ESCAPE 'A'; -- 문자도 상관없음
WHERE EMAIL LIKE '___ _%' ESCAPE ' '; -- 띄어쓰기도 상관없음

-- NOT LIKE : 특정 패턴을 만족시키지 않는 값 조회
-- 김씨 성이 아닌 직원의 사번, 이름, 고용일 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
--WHERE NOT EMP_NAME LIKE '김%';
WHERE EMP_NAME NOT LIKE '김%';

-- 미니 실습 문제
-- 1. 이름 끝이 '연'으로 끝나는 사원의 이름 조회
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';
-- 2. 번호 처음 3자리가 010이 아닌 사원의 이름, 전화번호를 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';
-- 3. 메일주소 '_'의 앞이 4자 이면서 DEPT_CODE가 D9 또는 D6이고
--    고용일이 90/01/01 ~ 00/12/01이고, 급여가 270만 이상인 사원의 전체를 조회
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '____A_%' ESCAPE 'A' AND (DEPT_CODE = 'D9' OR DEPT_CODE = 'D6') 
                                      AND HIRE_DATE BETWEEN '90/01/01' AND '00/12/01'
                                      AND SALARY >= 2700000;

-- IS NULL / IS NOT NULL
-- IS NULL : 컬럼 값이 NULL인 경우
-- IS NOT NULL : 컬럼 값이 NULL이 아닌 경우

-- 보너스를 받지 않는 사원의 사번, 이름, 급여, 보너스 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;

-- 보너스를 받는 사원의 사번, 이름, 급여, 보너스 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;

-- 관리자도 없고 부서배치도 받지 않는 직원의 이름, 관리자, 부서코드 조회
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;
-- 부서 배치를 받지 않았지만 보너스를 받는 직원의 이름, 보너스, 부서코드 조회
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

-- IN
-- 비교하려는 값 목록에 일치하는 값이 있으면 TRUE를 반환하는 연산자
-- 부서코드가 D6이거나 D9인 사원의 이름, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9' OR DEPT_CODE = 'D6';

SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN('D6','D9');

-- 직급 코드가 J1,J2,J3,J4인 사람들의 이름, 직급 코드, 급여 조회
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE = 'J1' OR JOB_CODE = 'J2' OR JOB_CODE = 'J3' OR JOB_CODE = 'J4';

SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN('J1','J2','J3','J4');

-- 연결 연산자 || : 여러 컬럼을 연결하거나 컬럼과 리터럴을 연결하는 연산자
-- 사번, 이름, 급여를 연결하여 조회
SELECT EMP_ID || EMP_NAME || SALARY 
FROM EMPLOYEE;

-- '사원 명의 월급은 급여원입니다.' 형식으로 조회
SELECT EMP_NAME || '의 월급은 '|| SALARY || '원입니다.'
FROM EMPLOYEE;


SELECT EMP_ID, EMP_NAME, NVL(DEPT_CODE, "부서 없음"), SALARY
FROM EMPLOYEE
WHERE (DEPT_CODE, SALARY) IN (SELECT DEPT_CODE, MAX(SALARY)
FROM EMPLOYEE
GROUP BY NVL(DEPT_CODE, "부서 없음"))
ORDER BY NVL(DEPT_CODE, "부서 없음");


