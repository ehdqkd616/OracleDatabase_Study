-- ������(SEQUENCE) : �ڵ� ��ȣ �߻���
CREATE SEQUENCE SEQ_EMPID -- ������ �̸� ����
START WITH 300 -- ���� ���� 300
INCREMENT BY 5 -- ���� ����
MAXVALUE 310 -- �ִ� ����
NOCYCLE -- ����Ŭ �� ���ڴ�
NOCACHE ; -- �޸� �󿡼� �������� �ʰڴ�

SELECT * FROM USER_SEQUENCES; -- ����ڰ� ���� ������ ��ȸ

-- SEQUENCE
-- ��������.CURRVAL : ���� ������ �������� ��
-- ��������.NEXTVAL : �������� ������Ű�ų� ���ʷ� ������ ����
                    ----------------- ��������.NEXTVAL = ��������.CURRVAL + INCREMENT BY ��
SELECT SEQ_EMPID.CURRVAL FROM DUAL;
-- ORA-08002: sequence SEQ_EMPID.CURRVAL is not yet defined in this session
-- ������ ������ ���� ���ߴµ� ��ȸ�Ϸ��ؼ� ����

SELECT SEQ_EMPID.NEXTVAL FROM DUAL;
SELECT SEQ_EMPID.CURRVAL FROM DUAL;
SELECT SEQ_EMPID.NEXTVAL FROM DUAL;
SELECT SEQ_EMPID.NEXTVAL FROM DUAL;
SELECT SEQ_EMPID.NEXTVAL FROM DUAL;
-- ORA-08004: sequence SEQ_EMPID.NEXTVAL exceeds MAXVALUE and cannot be instantiated
-- MAXVALUE�ʰ��ؼ� ���� (NOCYCLE)
SELECT SEQ_EMPID.CURRVAL FROM DUAL;
-- ���������� ȣ��� ������ NEXTVAL�� ���� ����

-- CURRVAL / NEXTVAL ��� ���� �� �Ұ���
-- ��� ����
--      ���������� �ƴ� SELECT ��
--      INSERT���� SELECT��
--      INSERT���� VALUES��
--      UPDATE���� SET��
-- ��� �Ұ���
--      VIEW�� SELECT��
--      DISTINCTŰ���尡 �ִ� SELECT��
--      GROUP BY, HAVING, ORDER BY���� SELECT��
--      SELECT, UPDATE, DELETE���� ��������
--      CREATE TABLE, ALTER TABLE�� DEFAULT��

-- ���� ���ڰ� 300�̰� �������� 1�̸� �ִ� ���ڰ� 10000�� ���ȯ �� ĳ�� ����� ���ϴ� SEQ_EID ������ ����
CREATE SEQUENCE SEQ_EID
START WITH 300
INCREMENT BY 1
MAXVALUE 10000
NOCYCLE
NOCACHE;

COMMIT;

INSERT INTO EMPLOYEE
VALUES(SEQ_EID.NEXTVAL, 'ȫ�浿', '666666-6666667', 'hong_gd@kh.or.kr', '01066666667', 'D2', 'J7', 'S1',
       5000000, 0.1, 200, SYSDATE, NULL, DEFAULT);
       
SELECT * FROM EMPLOYEE;

CREATE TABLE TMP_EMPLOYEE(
    E_ID NUMBER DEFAULT SEQ_EID.NEXTVAL,
    -- ORA-00984: column not allowed here
    -- �������� DEFAULT���� ������ ����
    E_NAME VARCHAR2(30)
);

ROLLBACK;


-- ������ ����
ALTER SEQUENCE SEQ_EMPID
INCREMENT BY 10
MAXVALUE 400
NOCYCLE
NOCACHE;

SELECT * FROM USER_SEQUENCES;
-- START WITH(���۰�) ���� �Ұ�

SELECT SEQ_EMPID.NEXTVAL FROM DUAL;
SELECT SEQ_EMPID.CURRVAL FROM DUAL;





