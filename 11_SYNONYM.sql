-- 동의어(SYNONYM) : 다른 DB가 가진 객체에 대한 별명 혹은 줄임말
-- 동의어를 사용하여 간단하게 접근할 수 있도록 함

-- 비공개 동의어 : 객체에 대한 접근 권한을 부여 받은 사용자가 정의한 동의어로 해당 사용자만 사용 가능
CREATE SYNONYM EMP FOR EMPLOYEE;
-- ORA-01031: insufficient privileges
-- 권한이 충분치 않습니다

GRANT CREATE SYNONYM TO KH; -- (SYSTEM계정)

SELECT * FROM EMPLOYEE;
SELECT * FROM EMP;

-- 공개 동의어 : 모든 권한을 주는 사용자(DBA)가 정의한 동의어
--             모든 사용자가 사용할 수 있음
SELECT * FROM KH.EMPLOYEE;
SELECT * FROM KH.EMP;
SELECT * FROM KH.DEPARTMENT;

CREATE PUBLIC SYNONYM DEPT FOR KH.DEPARTMENT;

SELECT * FROM DEPT;

-- 동의어 삭제
DROP SYNONYM EMP;
SELECT * FROM EMP;
DROP SYNONYM DEPT;
-- ORA-01434: private synonym to be dropped does not exist
-- PUBLIC SYNONYM이라서 PUBLIC 붙여줘야함
DROP PUBLIC SYNONYM DEPT;
-- ORA-01031: insufficient privileges
-- 권한 없음(사용자 계정에서 삭제해야함)


