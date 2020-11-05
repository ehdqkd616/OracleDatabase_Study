-- 함수(function) : 컬럼의 값을 읽어서 계산한 결과를 리턴
-- 단일 행 함수(SINGLE ROW FUNCTION)
-- n개의 값을 넣어서 n개의 결과를 리턴
-- 그룹 함수(GROUP FUNCTION)
-- N개의 값을 넣어서 1개의 결과를 리턴
-- SELECT절에 두개 같이 못씀 : 결과 행의 개수가 달라서

-- 함수를 사용할 수 있는 위치
-- SELECT절, WHERE절, GROUP BY절, HAVING절, ORDER BY절

-- 단일 행 함수
-- 1. 문자 관련 함수

-- LENGTH / LENGTHB
-- LENGTH(컬럼명 | '문자열') : 글자 수 반환
-- LENGTHB(컬럼명 | '문자열') : 글자의 바이트 사이즈 반환
SELECT LENGTH('오라클'), LENGTHB('오라클') -- 오라클에서 한글은 글자당 3BYTE로 인식함
FROM DUAL;
-- DUAL은 가상 테이블을 말함

SELECT EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE;

-- INSTR : 해당 문자열의 위치(첫번째에있는 위치)
-- 오라클은 제로인덱스 아님
SELECT INSTR('AABAACAABBAA','B')FROM DUAL;
SELECT INSTR('AABAACAABBAA','Z')FROM DUAL;
-- 위치는 앞에서부터 잼
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL; -- 1번째부터 읽기 시작해서 처음으로 나오는 B위치 반환
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL; -- 맨뒤부터 읽기 시작해서 처음으로 나오는 B위치 반환
SELECT INSTR('AABAACAABBAA', 'C', -1) FROM DUAL; -- 맨뒤부터 읽기 시작해서 처음으로 나오는 C위치 반환
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL; -- 1번째부터 읽기 시작해서 두번째로 나오는 B위치 반환
SELECT INSTR('AABAACAABBAA', 'B', -1, 2) FROM DUAL; -- 맨뒤부터 읽기 시작해서 두번째로 나오는 B위치 반환
SELECT INSTR('AABAACAABBAA', 'C', 1, 2) FROM DUAL; -- 1번째부터 읽기 시작해서 두번째로 나오는 C위치 반환

-- 이메일의 @ 위치 반환
SELECT EMAIL, INSTR(EMAIL, '@', 1, 1)
FROM EMPLOYEE;

-- LPAD / RPAD : 주어진 컬럼이나 문자열에 임의의 문자열을 왼쪽/오른쪽에 덧붙여 길이 N의 문자열 반환
-- (임의의 문자열 지정 안해주면 기본적으로 공백)

SELECT LPAD(EMAIL, 20)
FROM EMPLOYEE;

SELECT RPAD(EMAIL, 20)
FROM EMPLOYEE;

SELECT LPAD(EMAIL, 20, '#') 
FROM EMPLOYEE;

SELECT RPAD(EMAIL, 20, DEPT_CODE)
FROM EMPLOYEE;

-- LTRIM / RTRIM / TRIM : 주어진 컬럼이나 문자열의 왼쪽 또는 오른쪽 또는 앞/뒤/양쪽에서 지정한 문자 제거

SELECT LTRIM('   KH') FROM DUAL; -- 삭제할 문자열을 지정하지 않았을 경우 공백이 기본값이 되어 제거
SELECT LTRIM('   KH', ' ') FROM DUAL; -- 두개 같은거
SELECT LTRIM('000123456' , '0') FROM DUAL;
SELECT LTRIM('123123KH', '123') FROM DUAL;
SELECT LTRIM('123123KH123', '123') FROM DUAL;
SELECT LTRIM('ACABACCKH', 'ABC') FROM DUAL; -- 문자열로 조건을 잡을땐 문자 하나하나 비교
SELECT LTRIM('5781KH', '0123456789') FROM DUAL;

SELECT RTRIM('KH   ') FROM DUAL;
SELECT RTRIM('123456000', '0') FROM DUAL;
SELECT RTRIM('KHACABACC', 'ABC') FROM DUAL;

SELECT TRIM('      KH      ') FROM DUAL;
SELECT TRIM('Z' FROM 'ZZZKHZZZ') FROM DUAL;
SELECT TRIM('123' FROM '123132KH123321') FROM DUAL; -- 트림은 한글자만 조건으로 잡을수 있음
SELECT TRIM(LEADING 'Z' FROM 'ZZZ123456') FROM DUAL; -- 앞
SELECT TRIM(TRAILING 'Z' FROM '123456ZZZ') FROM DUAL; -- 뒤
SELECT TRIM(BOTH 'Z' FROM 'ZZZ123456ZZZ') FROM DUAL; -- 양옆

-- SUBSTR : 컬럼이나 문자열에서 지정한 위치부터 지정 개수의 문자열을 잘라내 반환
SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL; -- 7번째 문자부터 쭉 반환
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 5, 0) FROM DUAL; -- NULL
SELECT SUBSTR('SHOWMETHEMONEY', 1, 6) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL; -- THE
SELECT SUBSTR('SHOWMETHEMONEY', -10, 2) FROM DUAL;

-- 이름, 이메일, @이후를 제외한 아이디 조회
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1)
FROM EMPLOYEE;
-- 주민등록번호에서 성별을 나타내는 부분만 잘라보기
SELECT SUBSTR(EMP_NO, INSTR(EMP_NO, '-')+1, 1)
FROM EMPLOYEE;
-- 직원들의 주민번호를 이용하여 사원명, 생년, 생월, 생일 조회
SELECT EMP_NAME, SUBSTR(EMP_NO,1,2) || '년' 생년, SUBSTR(EMP_NO,3,2) || '월' 생월 , SUBSTR(EMP_NO,5,2) || '일' 생일
FROM EMPLOYEE;

-- LOWER / UPPER / INITCAP
SELECT LOWER('Welcome To My World') FROM DUAL; -- 소문자
SELECT UPPER('Welcome To My World') FROM DUAL; -- 대문자
SELECT INITCAP('Welcome to My World') FROM DUAL; -- 띄어쓰기 후 첫 앞글자만 대문자

-- CONCAT : 두 문자열 혹은 컬럼 연결
SELECT CONCAT('가나다라', 'ABCD') FROM DUAL;
SELECT '가나다라' || 'ABCD' FROM DUAL;

-- REPLACE : 문자열을 지정한 문자열로 바꿈
SELECT REPLACE('서울시 강남구 역삼동', '역삼동', '삼성동') FROM DUAL;
SELECT REPLACE('서정호 학생의 별명은 군인일까요?', '군인', '에코') FROM DUAL;

-- 이메일의 도메인을 GMAIL.COM으로 변경하기
SELECT REPLACE(EMAIL, SUBSTR(EMAIL, INSTR(EMAIL,'@')+1),'gmail.com') 이메일
FROM EMPLOYEE;
-- 사원명, 주민번호 조회
-- 단, 주민번호는 생년월일-성별 까지만 보이게하고 나머지 값은 '*'로 바꾸기
-- 1)
SELECT EMP_NAME 사원명, REPLACE(EMP_NO, SUBSTR(EMP_NO, 9),'******') 주민등록번호
FROM EMPLOYEE;
-- 2)
SELECT EMP_NAME 사원명, CONCAT(SUBSTR(EMP_NO, 0, 8),'******') 주민등록번호
FROM EMPLOYEE;
-- 3)
SELECT EMP_NAME 사원명, RPAD(SUBSTR(EMP_NO, 1, 8), 14,'*') 주민등록번호
FROM EMPLOYEE;


-- 2. 숫자 관련 함수

-- ABS : 절대 값을 반환해주는 함수
SELECT ABS(10.9) FROM DUAL;
SELECT ABS(-10.9) FROM DUAL;
SELECT ABS(10) FROM DUAL;
SELECT ABS(-10) FROM DUAL;

-- MOD : 나머지 값을 반환해주는 함수 (무조건 나눌 값이 양수면 반환값도 양수, 나눌 값이 음수면 반환값도 음수)
SELECT MOD(10, 3) FROM DUAL;    -- 1
SELECT MOD(-10, 3) FROM DUAL;   -- -1
SELECT MOD(10, -3) FROM DUAL;   -- 1
SELECT MOD(10.9, 3) FROM DUAL;  -- 1.9
SELECT MOD(-10.9, 3) FROM DUAL; -- -1.9

SELECT MOD(-10, -3) FROM DUAL;  -- -1

-- ROUND : 반올림 해주는 함수 
SELECT ROUND(123.456) FROM DUAL;    -- 123
SELECT ROUND(123.678, 0) FROM DUAL; -- 124
SELECT ROUND(123.456, 1) FROM DUAL; -- 123.5
SELECT ROUND(123.456, 2) FROM DUAL; -- 123.46
SELECT ROUND(123.456, -2) FROM DUAL;-- 100 (음수 넣으면 점 앞에서부터 반올림)

SELECT ROUND(-10.61) FROM DUAL;

-- FLOOR : 내림
SELECT FLOOR(123.456) FROM DUAL;
SELECT FLOOR(123.678) FROM DUAL;

-- TRUNC : 버림(절삭)
SELECT TRUNC(123.456) FROM DUAL;
SELECT TRUNC(123.678) FROM DUAL;
SELECT TRUNC(123.456, 1) FROM DUAL;
SELECT TRUNC(123.456, -1) FROM DUAL;

-- CEIL : 올림
SELECT CEIL(123.456) FROM DUAL;
SELECT CEIL(123.678) FROM DUAL;


-- 3. 날짜 관련 함수
-- SYSDATE : 오늘 날짜 반환

-- MONTHS_BETWEEN : 날짜와 날짜 사이의 개월 수 차이를 숫자로 리턴하는 함수
SELECT EMP_NAME, HIRE_DATE, MONTHS_BETWEEN(SYSDATE, HIRE_DATE)
FROM EMPLOYEE;

-- ADD_MONTHS : 날짜에 숫자만큼의 개월 수를 더해 날짜 리턴
SELECT ADD_MONTHS(SYSDATE, 5) FROM DUAL;
SELECT ADD_MONTHS(SYSDATE, 15) FROM DUAL;

-- NEXT_DAY : 기준 날짜에서 구하려는 요일에 가장 가까운 날짜를 리턴하는 함수
SELECT SYSDATE, NEXT_DAY(SYSDATE, '목요일') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 1) FROM DUAL;
-- 일, 월, 화, 수, 목, 금, 토
-- 1,  2,  3, 4,  5,  6, 7
SELECT SYSDATE, NEXT_DAY(SYSDATE, '목') FROM DUAL;
-- 맨앞에 화 글자를 보고 화요일로 인식
SELECT SYSDATE, NEXT_DAY(SYSDATE, '화진씨는 지금 무슨 생각을 하고 있을까?') FROM DUAL;
-- 첫글자 아니면 에러
SELECT SYSDATE, NEXT_DAY(SYSDATE, '연화씨도 자기 이름이 되는지 궁금하겠지') FROM DUAL;
-- 영어 인식하게 해주려면 ALTER문
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THURSDAY') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THUR') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THUROSEMARY') FROM DUAL;
ALTER SESSION SET NLS_LANGUAGE = KOREAN;

-- LAST_DAY : 해당 월에 마지막 날짜 리턴
SELECT SYSDATE, LAST_DAY(SYSDATE) FROM DUAL;

-- EXTRACT : 날짜에서 년, 월, 일 추출하여 리턴
-- EXTRACT(YEAR FROM 날짜)
-- EXTRACT(MONTH FROM 날짜)
-- EXTRACT(DAY FROM 날짜)

-- 사원의 이름, 입사 년, 입사 월, 입사 일 조회
SELECT EMP_NAME 이름 , EXTRACT(YEAR FROM HIRE_DATE) "입사 년도", EXTRACT(MONTH FROM HIRE_DATE) "입사 월", EXTRACT(DAY FROM HIRE_DATE)"입사 일"
FROM EMPLOYEE;

-- 4. 형 변환 함수
-- TO_CHAR(날짜[, 포맷]) : 날짜형 데이터를 문자형 데이터로
-- TO_CHAR(숫자[, 포맷]) : 숫자형 데이터를 문자형 데이터로
SELECT TO_CHAR(1234) D FROM DUAL;
SELECT TO_CHAR(1234, '99999') D FROM DUAL; -- 5칸, 오른쪽 정렬 ,빈칸 공백
SELECT TO_CHAR(1234, '00000') D FROM DUAL; -- 5칸, 오른쪽 정렬, 빈칸 0
SELECT TO_CHAR(1234, 'L99999') D FROM DUAL; -- 원화 설정
SELECT TO_CHAR(1234, 'FML99999') D FROM DUAL; -- 공백을 아예 없애고 싶으면 FM
SELECT TO_CHAR(1234, '$99999') D FROM DUAL;
SELECT TO_CHAR(1234, 'FM$99999') D FROM DUAL;
SELECT TO_CHAR(1234, '99,999') D FROM DUAL;
SELECT TO_CHAR(1234, 'FM99,999') D FROM DUAL;
SELECT TO_CHAR(1234, '00,000') D FROM DUAL;
SELECT TO_CHAR(1234, 'FM00,000') D FROM DUAL;
SELECT TO_CHAR(1234, '9.9EEEE') D FROM DUAL;
SELECT TO_CHAR(1234, '999') D FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL; -- 앞에 PM,AM붙어도 차이없이 오후출력
SELECT TO_CHAR(SYSDATE, 'MON DY, YYYY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-FMMM-DD DAY') FROM DUAL; -- FM 붙으면 필요없는 0 제거
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-FMDD DAY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YEAR, Q') || '분기' FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY"년"MM"월" DD"일" DAY') FROM DUAL;

-- 오늘 날짜 연도 출력
SELECT TO_CHAR(SYSDATE, 'YYYY'), TO_CHAR(SYSDATE, 'YY'), TO_CHAR(SYSDATE, 'YEAR')
FROM DUAL;

-- 월 출력
SELECT TO_CHAR(SYSDATE, 'MM'), TO_CHAR(SYSDATE, 'MONTH'), TO_CHAR(SYSDATE, 'MON'), TO_CHAR(SYSDATE,'RM')
FROM DUAL;

-- 일 출력
SELECT TO_CHAR(SYSDATE, 'DDD'), -- 이번년 기준 며칠째 출력
       TO_CHAR(SYSDATE, 'DD'), -- 이번달 기준 며칠째인지 출력
       TO_CHAR(SYSDATE,'D') -- 이번주 기준 며칠째인지 출력
FROM DUAL;

-- 분기, 요일 출력
SELECT TO_CHAR(SYSDATE, 'Q'),
       TO_CHAR(SYSDATE, 'DAY'),
       TO_CHAR(SYSDATE, 'DY')
       FROM DUAL;

-- TO_DATE : 문자/숫자형 데이터를 날짜형 데이터로
SELECT TO_DATE('20100101', 'YYYYMMDD') FROM DUAL;
SELECT TO_DATE(20100101, 'YYYYMMDD') FROM DUAL;

-- 2010 01 01 => 2010. 1월
SELECT TO_CHAR(TO_DATE('20100101', 'YYYYMMDD'),'YYYY, MON')
FROM DUAL;

SELECT TO_CHAR(TO_DATE('041030 143000', 'YYMMDD HH24MISS'), 'YY-MON-DD HH:MI:SS PM')
FROM DUAL;

-- RR과 YY의 차이
SELECT TO_CHAR(TO_DATE('980630', 'YYMMDD'),'YYYYMMDD'), -- YY는 현재 세기 기준
       TO_CHAR(TO_DATE('140918', 'YYMMDD'),'YYYYMMDD'),
       TO_CHAR(TO_DATE('980630', 'RRMMDD'),'YYYYMMDD'), -- RR는 두자리 연도가 50년 이상이면 전 세기 기준
       TO_CHAR(TO_DATE('140918', 'RRMMDD'),'YYYYMMDD')  -- RR는 두자리 연도가 50년 미만이면 현재 세기 기준
FROM DUAL;

-- TO_NUMBER : 문자형 데이터를 숫자형 데이터로
SELECT TO_NUMBER('123456789') FROM DUAL;
SELECT '123' + '456' FROM DUAL;

SELECT '123' + '456A' FROM DUAL;
SELECT '1,000,000' + '550,000' FROM DUAL;
SELECT TO_NUMBER('1,000,000', '99,999,999') FROM DUAL;
SELECT TO_NUMBER('1,000,000', '99,999,999') + TO_NUMBER('550,000', '999,999') FROM DUAL;

-- 5. NULL 처리 함수
-- NVL(컬럼 명, 컬럼 값이 NULL일때 바꿀 값)

SELECT EMP_NAME, NVL(BONUS,0)
FROM EMPLOYEE;

SELECT EMP_NAME, NVL(DEPT_CODE, '없습니다')
FROM EMPLOYEE;

-- NVL2(컬럼 명, 바꿀 값1, 바꿀 값2) NULL이 아니면 값1 NULL이면 값2
-- 보너스가 NULL인 직원은 0.5로, NULL이 아닌 직원은 0.7로 변경하여 조회
SELECT EMP_NAME, BONUS, NVL2(BONUS,0.7,0.5)
FROM EMPLOYEE;

-- NULLIF(비교대상1, 비교대상2) : 두 개의 값이 동일하면 NULL 동일하지 않으면 비교대상1 리턴
SELECT NULLIF(123,123) FROM DUAL;
SELECT NULLIF(123,124) FROM DUAL;


-- 6. 선택 함수 : 여러가지 겨우 선택할 수 있는 기능 제공
-- DECODE(계산식|컬럼명, 조건값1, 선택값1, 조건값2, 선택값2...)
-- 비교하고자하는 값 또는 컬럼이 조건식과 같으면 결과 값 반환
SELECT EMP_ID, EMP_NAME, EMP_NO,
       DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남', 2, '여') 성별
FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, EMP_NO,
       DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남', '여') 성별
FROM EMPLOYEE;
-- 마지막 인자로 조건 값 없이 선택 값을 작성하면
-- ELSE문 처럼 아무 것도 해당되지 않을때 마지막 선택값을 무조건 선택함

-- CASE WHEN 조건식 THEN 결과 값
--      WHEN 조건식 THEN 결과 값
--      ELSE 결과 값
-- END
-- 비교하고자 하는 값 또는 컬럼이 조건식과 같으면 결과 값 반환(조건은 범위 가능)
SELECT EMP_ID, EMP_NAME, EMP_NO,
       CASE WHEN SUBSTR(EMP_NO, 8, 1) = 1 THEN '남'
       ELSE '여'
       END 성별
FROM EMPLOYEE;

-- 급여가 500만 초과 1등급, 350만 초과 2등급, 200만 초과 3등급, 나머지 4등급
SELECT EMP_ID, EMP_NAME, SALARY,
       CASE WHEN SALARY > 5000000 THEN '1등급'
            WHEN SALARY > 3500000 THEN '2등급'
            WHEN SALARY > 2000000 THEN '3등급'
       ELSE '4등급'
       END 급여등급
FROM EMPLOYEE;

-- 그룹 함수 : 여러 행을 넣으면 한 개의 결과만 반환
-- SUM(숫자가 기록된 컬럼) : 합계 리턴
-- 전 사원의 급여 총합 조회
SELECT SUM(SALARY)
FROM EMPLOYEE;

-- 남자 사원의 급여 총합 조회
SELECT SUM(DECODE(SUBSTR(EMP_NO, 8, 1), 1, SALARY, 0))
FROM EMPLOYEE;

SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 1;

-- AVG(숫자가 기록된 컬럼) : 평균 리턴
-- EMPLOYEE테이블에서 전 사원의 급여 평균 조회

SELECT AVG(SALARY)
FROM EMPLOYEE;

-- 전 사원의 BONUS 합계 조회
SELECT SUM(BONUS)
FROM EMPLOYEE;
-- 전 사원의 BONUS 평균 조회
SELECT AVG(BONUS) 평균, AVG(NVL(BONUS, 0)) "NULL 잡은평균"
FROM EMPLOYEE;
-- NULL값을 가진 행은 평균 계산에서 제외 되어 계산

-- MIN, MAX : 최솟값, 최대값 
-- 가장 적은 급여, 알파벳 순서가 가장 빠른 이메일, 가장 빠른 입사일 조회
SELECT MIN(SALARY), MIN(EMAIL), MIN(HIRE_DATE)
FROM EMPLOYEE;
-- 가장 많은 급여, 알파벳 순서가 가장 마지막인 이메일, 가장 느린 입사일 조회
SELECT MAX(SALARY), MAX(EMAIL), MAX(HIRE_DATE)
FROM EMPLOYEE;

-- COUNT(* | 컬럼명) : 행의 개수를 세서 리턴
-- COUNT(DISTINCT 컬럼명) : 중복을 제거한 행 개수 리턴
-- COUNT(*) : NULL을 포함한 전체 행의 개수 리턴
-- COUNT(컬럼명) : NULL을 제외한 전체 행 개수 리턴
SELECT COUNT (*), COUNT (DEPT_CODE), COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;








