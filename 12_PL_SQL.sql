-- PL/SQL (Procedural Language extension to SQL)
-- 오라클 자체에 내장되어 있는 절차적 언어
-- SQL문장 내에서 변수의 정의, 조건처리(TF), 반복처리(LOOP, FOR, WHILE)등을 지원하여 SQL단점 보완

-- PL/SQL 구조
--       선언부 : DECLARE로 시작
--               변수,상수 선언
--       실행부 : BEGIN으로 시작
--               로직 기술
--       예외처리부 : EXCEPTION
--                  예외 상황 발생 시 해결하기 위한 문장 기술

SET SERVEROUTPUT ON; -- 콘솔에 출력하기위한 SQL(주석이 옆에 붙어있으면 실행이 안됨 밑에꺼 실행할것)
SET SERVEROUTPUT ON;
--  System.out.println("Hello World");
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello World');
END;
/

-- 타입 변수 선언
-- 변수의 선언 및 초기화, 변수 값 출력
DECLARE
    EMP_ID NUMBER;          -- NUMBER타입의 변수 EMP_ID 선언   ==> JAVA : int emp_id;
    EMP_NAME VARCHAR2(30);  -- VARCHAR2타입 변수 EMP_NAME 선언 ==> JAVA : string emp_name;
    
    PI CONSTANT NUMBER := 3.14; -- NUMBER타입의 상수 PI 선언   ==> JAVA : final double pi = 3.14;
--  변수 값 대입 연산자 :=
BEGIN -- 실행부
    EMP_ID := 888;          -- EMP_ID변수에 888로 값 초기화
    EMP_NAME := '배장남';    -- EMP_NAME변수에 배장남으로 값 초기화
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
END;
/

-- 레퍼런스 변수의 선언과 초기화, 변수 값 출력
DECLARE
--    EMP_ID EMPLOYEE.EMP_ID%TYPE;    -- 변수 EMP_ID의 타입을 EMPLOYEE테이블의 EMP_ID컬럼 타입으로 지정
--    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    ID EMPLOYEE.EMP_ID%TYPE;
    NAME EMPLOYEE.EMP_NAME%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME -- 컬럼 명
    INTO ID, NAME   -- 변수 명
    FROM EMPLOYEE
    WHERE EMP_ID = '&사번'; -- 값 입력(Scanner역할) : '&안내문에출력될글'
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || NAME);
END;
/
    
DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    DEPT_CODE EMPLOYEE.DEPT_CODE%TYPE;
    JOB_CODE EMPLOYEE.JOB_CODE%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
    INTO EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
    FROM EMPLOYEE
    WHERE EMP_NAME = '&직원이름';
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('DEPT_CODE : ' || DEPT_CODE);
    DBMS_OUTPUT.PUT_LINE('JOB_CODE : ' || JOB_CODE);
    DBMS_OUTPUT.PUT_LINE('SALARY : ' || SALARY);
END;
/

-- 한 행에 대한 ROWTYPE변수 선언과 초기화
DECLARE
    E EMPLOYEE%ROWTYPE;
    -- %ROWTYPE : 테이블 또는 뷰의 컬럼 데이터 형, 크기, 속성 참조
BEGIN
    SELECT * 
    INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = '&사번';
    
    -- 사번, 이름, 주민번호, 급여
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || E.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('EMP_NO : ' || E.EMP_NO);
    DBMS_OUTPUT.PUT_LINE('SALARY : ' || E.SALARY);
END;
/

-- 선택문(조건문)
-- IF ~ THEN ~ END IF (단일 IF)
-- EMP_ID를 입력받아 해당 사원의 사번, 이름, 급여, 보너스율 출력
-- 단, 보너스를 받지 않는 사원은 보너스율 출력 전, '보너스를 지급받지 않는 사원입니다' 출력
DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS,0)
    INTO EMP_ID, EMP_NAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = '&사번';
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('SALARY : ' || SALARY);
    IF(BONUS = 0)
        THEN DBMS_OUTPUT.PUT_LINE('보너스를 지급받지 않는 사원입니다');
    END IF;
    DBMS_OUTPUT.PUT_LINE('BONUS : ' || BONUS*100 || '%');
END;
/
-- IF ~ THEN ~ ELSE ~ END IF (IF ~ ELSE문)
-- EMP_ID를 입력받아 해당 사원의 사번, 이름, 부서명, 소속 출력하시오
-- TEAM변수를 만들어 소속이 'KO'인 사원은 '국내팀', 아닌 사원은 '해외팀'으로 저장
DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    DEPT_TITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NATIONAL_CODE LOCATION.NATIONAL_CODE%TYPE;
    
    TEAM VARCHAR2(20);
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    INTO EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    FROM EMPLOYEE
         LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
         LEFT JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
    WHERE EMP_ID = '&사번';
    
    IF(NATIONAL_CODE = 'KO')
        THEN TEAM := '국내팀';
    ELSE 
        TEAM := '해외팀';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('부서명 : ' || DEPT_TITLE);
    DBMS_OUTPUT.PUT_LINE('소속 : ' || TEAM);
END;
/

DECLARE
    E EMPLOYEE%ROWTYPE;
    YSALARY NUMBER;
BEGIN
    SELECT *
    INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = '&사번';
    
    IF(E.BONUS IS NOT NULL)
        THEN YSALARY := E.SALARY * 12;
    ELSE
        YSALARY := (E.SALARY * (1+E.BONUS) * 12);
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('SALARY : ' || E.SALARY);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('연봉 : ' || TO_CHAR(YSALARY, 'FML999,999,999'));
END;
/



-- IF ~ THEN ~ ELSIF ~ ELSE ~ END IF (IF~ ELSE IF~ ELSE문)
-- 점수를 입력받아 SCORE변수에 저장하고
-- 90점 이상은 A, 80 B, 70 C, 60 D, 미만 F
-- GRADE변수에 저장
-- 출력 양식 : 당신의 점수는 90점이고, 학점은 A학점입니다.

DECLARE -- 변수 선언
    SCORE INT; -- NUMBER(38)
    GRADE VARCHAR2(2);
BEGIN
    SCORE := '&점수';
    IF(SCORE >= 90)
        THEN GRADE := 'A';
    ELSIF(SCORE >= 80)
        THEN GRADE := 'B';
    ELSIF(SCORE >= 70)
        THEN GRADE := 'C';
    ELSIF(SCORE >= 60)
        THEN GRADE := 'D';
    ELSE 
        GRADE := 'F';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('당신의 점수는 ' || SCORE || '점이고, 학점은 ' || GRADE || '입니다');
END;
/


-- CASE ~ WHEN ~ THEN ~ END (SWITCH ~ CASE문)
-- 사원 번호를 입력하여 해당 사원의 사번, 이름, 부서명 출력

-- IF END IF 사용
DECLARE
    EMP EMPLOYEE%ROWTYPE;
    DNAME VARCHAR2(20);
BEGIN
    SELECT *
    INTO EMP
    FROM EMPLOYEE
    WHERE EMP_ID = '&사번';
    
    IF EMP.DEPT_CODE = 'D1' THEN DNAME := '인사관리부';
    ELSIF EMP.DEPT_CODE = 'D2' THEN DNAME := '회계관리부';
    ELSIF EMP.DEPT_CODE = 'D3' THEN DNAME := '마케팅부';
    ELSIF EMP.DEPT_CODE = 'D4' THEN DNAME := '국내영업부';
    ELSIF EMP.DEPT_CODE = 'D5' THEN DNAME := '해외영업1부';
    ELSIF EMP.DEPT_CODE = 'D6' THEN DNAME := '해외영업2부';
    ELSIF EMP.DEPT_CODE = 'D7' THEN DNAME := '해외영업3부';
    ELSIF EMP.DEPT_CODE = 'D8' THEN DNAME := '기술지원부';
    ELSIF EMP.DEPT_CODE = 'D9' THEN DNAME := '총무부';
    ELSE DNAME := '부서가없습니다';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('사번    이름      부서명');
    DBMS_OUTPUT.PUT_LINE(EMP.EMP_ID || '    ' || EMP.EMP_NAME || '     ' || DNAME);
END;
/

DECLARE
    EMP EMPLOYEE%ROWTYPE;
    DNAME VARCHAR2(20);
BEGIN
    SELECT *
    INTO EMP
    FROM EMPLOYEE
    WHERE EMP_ID = '&사번';
    
    DNAME := CASE EMP.DEPT_CODE
                WHEN 'D1' THEN '인사관리부'
                WHEN 'D2' THEN '회계부'
                WHEN 'D3' THEN '마케팅부'
                WHEN 'D4' THEN '국내영업부'
                WHEN 'D5' THEN '해외영업1부'
                WHEN 'D6' THEN '해외영업2부'
                WHEN 'D7' THEN '해외영업3부'
                WHEN 'D8' THEN '기술지원부'
                WHEN 'D9' THEN '총무부'
             END;
    DBMS_OUTPUT.PUT_LINE('사번    이름      부서명');
    DBMS_OUTPUT.PUT_LINE(EMP.EMP_ID || '    ' || EMP.EMP_NAME || '     ' || DNAME);
END;
/
-- 반복문
-- BASIC LOOP : 내부에 처리문을 작성하고 마지막에 LOOP를 벗어날 조건 명시
/*
    LOOP
        처리문
        조건문
    END LOOP;
    
    조건문
        1) IF 조건식 THEN EXIT; END IF;
        2) EXIT WHEN 조건식;
*/

-- 1 ~ 5까지 순차적으로 출력
DECLARE
    N NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        N := N + 1;
        
--        IF N > 5 THEN EXIT;
--        END IF;
        EXIT WHEN N > 5;
    END LOOP;
END;
/

-- FOR LOOP
/*
    FOR 인덱스 IN [REVERSE] 초기값..최종값
    LOOP
        처리문
    END LOOF;
*/
-- 1 ~ 5까지 순서대로 출력

BEGIN
    FOR N IN 1..5
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/

-- 5 ~ 1까지 출력
BEGIN
    FOR N IN REVERSE 1..5
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/

-- 반복문을 이용한 데이터 삽입
CREATE TABLE TEST1(
    BUNHO NUMBER(3),
    NALJJA DATE
);

BEGIN
    FOR I IN 1..10
    LOOP
        INSERT INTO TEST1 VALUES(I, SYSDATE-I);
    END LOOP;
END;
/
SELECT * FROM TEST1;

-- 중첩 반복문
-- 구구단 짝수단 출력하기
BEGIN
    FOR I IN 2..9
    LOOP
        FOR J IN 1..9
        LOOP
        IF(MOD(I,2) = 0) THEN DBMS_OUTPUT.PUT_LINE(I || '*' || J || '=' || I*J);
        END IF;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('');
    END LOOP;
END;
/

-- WHILE LOOP
/*
    WHILE 조건
    LOOP
        처리문
    END LOOP;
*/

-- 1~5출력
DECLARE
    N NUMBER := 1;
BEGIN
    WHILE (N <= 5)
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        N := N+1;
    END LOOP;
END;
/

-- WHILE문으로 구구단 짝수단 출력
DECLARE
    I NUMBER := 1;
    J NUMBER := 1;
BEGIN
    WHILE (I <= 9)
    LOOP
        WHILE (J <= 9)
        LOOP
            IF(MOD(I,2) = 0)
            THEN 
            DBMS_OUTPUT.PUT_LINE(I || '*' || J || '=' || I*J);
            END IF;
            J := J + 1;
        END LOOP;
        J := 1;
        I := I + 1;
    END LOOP;
END;
/

-- 테이블 타입
-- 테이블 : 키와 값의 쌍으로 이루어진 컬렉션
-- 하나의 테이블의 한개의 컬럼 데이터 저장
/*
    TYPE 테이블명 IS TABLE OF 데이터타입
    INDEX BY BINARY_INTEGER;
*/
DECLARE
    -- 테이블 타입 선언
    TYPE EMP_ID_TABLE_TYPE IS TABLE OF EMPLOYEE.EMP_ID%TYPE
    INDEX BY BINARY_INTEGER;
    -- EMPLOYEE.EMP_ID 타입의 데이터를 저장할 수 있는 테이블 타입 EMP_ID_TABLE_TYPE 선언
    
    TYPE EMP_NAME_TABLE_TYPE IS TABLE OF EMPLOYEE.EMP_NAME%TYPE
    INDEX BY BINARY_INTEGER;
    -- EMPLOYEE.EMP_ID 타입의 데이터를 저장할 수 있는 테이블 타입 EMP_ID_TABLE_TYPE 선언
    
    -- 변수 선언
    -- 테이블 타입을 가져와서 변수타입에 지정
    EMP_ID_TABLE EMP_ID_TABLE_TYPE;
    EMP_NAME_TABLE EMP_NAME_TABLE_TYPE;
    
    I BINARY_INTEGER := 0;
BEGIN
    FOR K IN (SELECT EMP_ID, EMP_NAME FROM EMPLOYEE)
    -- K에 SELECT해온 행 하나하나가 들어감
    LOOP
        I := I+1;
        
        EMP_ID_TABLE(I) := K.EMP_ID;
        EMP_NAME_TABLE(I) := K.EMP_NAME;
    END LOOP;
    
    FOR J IN 1..I
    LOOP
        DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID_TABLE(J) || ' EMP_NAME : ' || EMP_NAME_TABLE(J));
    END LOOP;

END;
/

-- 레코드 타입
-- 서로 다른 유형의 데이터를 한 줄로 나열한 형태
-- 테이블 타입의 경우 한 타입만 들어갈 수 있다면 레코드 타입의 경우 내가 정한 여러 타입이 들어갈 수 있음
/*
    TYPE 레코드명 IS RECORD(
        필드명 필드타입 [[NOT NULL] := DEFAULT 값],
        필드명 필드타입 [[NOT NULL] := DEFAULT 값],
        ...
    );
*/

DECLARE
    -- 레코드 타입 선언
    TYPE EMP_RECORD_TYPE IS RECORD(
        EMP_ID EMPLOYEE.EMP_ID%TYPE,
        EMP_NAME EMPLOYEE.EMP_NAME%TYPE,
        DEPT_TITLE DEPARTMENT.DEPT_TITLE%TYPE,
        JOB_NAME JOB.JOB_NAME%TYPE
    );
    
    EMP_RECORD EMP_RECORD_TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
    INTO EMP_RECORD
    FROM EMPLOYEE
         LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
         LEFT JOIN JOB USING(JOB_CODE)
    WHERE EMP_NAME = '&이름';
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EMP_RECORD.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || EMP_RECORD.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('부서 : ' || EMP_RECORD.DEPT_TITLE);
    DBMS_OUTPUT.PUT_LINE('직급 : ' || EMP_RECORD.JOB_NAME);
END;
/

-- 예외처리
-- EXCEPTION절에 예외 상황 발생 시 해결하기 위한 문장 기술
-- 오라클에서 미리 정의한 예외에 대해서 예외처리를 할 수도 있고 사용자 정의 예외에 대해서 예외처리를 할 수도 있음

-- 미리 정의된 예외의 종류
-- NO_DATE_FOUND    : SELECT문이 아무런 데이터 행을 반환하지 못 할 때
-- DUP_VAL_ON_INDEX : UNIQUE제약을 갖는 컬럼에 중복된 데이터가 들어갔을 때
-- ZERO_DIVIDE      : 0으로 나눌 때
-- 등이 있음

BEGIN
    UPDATE EMPLOYEE
    SET EMP_ID = '&사번'
    WHERE EMP_ID = 200;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
    DBMS_OUTPUT.PUT_LINE('이미 존재하는 사번입니다.');
END;
/

DECLARE
    NAME VARCHAR2(30);
BEGIN
    SELECT EMP_NAME
    INTO NAME
    FROM EMPLOYEE
    WHERE EMP_ID = 5;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('조회 결과가 없습니다');
END;
/
























