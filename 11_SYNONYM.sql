-- ���Ǿ�(SYNONYM) : �ٸ� DB�� ���� ��ü�� ���� ���� Ȥ�� ���Ӹ�
-- ���Ǿ ����Ͽ� �����ϰ� ������ �� �ֵ��� ��

-- ����� ���Ǿ� : ��ü�� ���� ���� ������ �ο� ���� ����ڰ� ������ ���Ǿ�� �ش� ����ڸ� ��� ����
CREATE SYNONYM EMP FOR EMPLOYEE;
-- ORA-01031: insufficient privileges
-- ������ ���ġ �ʽ��ϴ�

GRANT CREATE SYNONYM TO KH; -- (SYSTEM����)

SELECT * FROM EMPLOYEE;
SELECT * FROM EMP;

-- ���� ���Ǿ� : ��� ������ �ִ� �����(DBA)�� ������ ���Ǿ�
--             ��� ����ڰ� ����� �� ����
SELECT * FROM KH.EMPLOYEE;
SELECT * FROM KH.EMP;
SELECT * FROM KH.DEPARTMENT;

CREATE PUBLIC SYNONYM DEPT FOR KH.DEPARTMENT;

SELECT * FROM DEPT;

-- ���Ǿ� ����
DROP SYNONYM EMP;
SELECT * FROM EMP;
DROP SYNONYM DEPT;
-- ORA-01434: private synonym to be dropped does not exist
-- PUBLIC SYNONYM�̶� PUBLIC �ٿ������
DROP PUBLIC SYNONYM DEPT;
-- ORA-01031: insufficient privileges
-- ���� ����(����� �������� �����ؾ���)


