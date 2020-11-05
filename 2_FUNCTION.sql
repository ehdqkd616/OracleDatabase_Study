-- �Լ�(function) : �÷��� ���� �о ����� ����� ����
-- ���� �� �Լ�(SINGLE ROW FUNCTION)
-- n���� ���� �־ n���� ����� ����
-- �׷� �Լ�(GROUP FUNCTION)
-- N���� ���� �־ 1���� ����� ����
-- SELECT���� �ΰ� ���� ���� : ��� ���� ������ �޶�

-- �Լ��� ����� �� �ִ� ��ġ
-- SELECT��, WHERE��, GROUP BY��, HAVING��, ORDER BY��

-- ���� �� �Լ�
-- 1. ���� ���� �Լ�

-- LENGTH / LENGTHB
-- LENGTH(�÷��� | '���ڿ�') : ���� �� ��ȯ
-- LENGTHB(�÷��� | '���ڿ�') : ������ ����Ʈ ������ ��ȯ
SELECT LENGTH('����Ŭ'), LENGTHB('����Ŭ') -- ����Ŭ���� �ѱ��� ���ڴ� 3BYTE�� �ν���
FROM DUAL;
-- DUAL�� ���� ���̺��� ����

SELECT EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE;

-- INSTR : �ش� ���ڿ��� ��ġ(ù��°���ִ� ��ġ)
-- ����Ŭ�� �����ε��� �ƴ�
SELECT INSTR('AABAACAABBAA','B')FROM DUAL;
SELECT INSTR('AABAACAABBAA','Z')FROM DUAL;
-- ��ġ�� �տ������� ��
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL; -- 1��°���� �б� �����ؼ� ó������ ������ B��ġ ��ȯ
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL; -- �ǵں��� �б� �����ؼ� ó������ ������ B��ġ ��ȯ
SELECT INSTR('AABAACAABBAA', 'C', -1) FROM DUAL; -- �ǵں��� �б� �����ؼ� ó������ ������ C��ġ ��ȯ
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL; -- 1��°���� �б� �����ؼ� �ι�°�� ������ B��ġ ��ȯ
SELECT INSTR('AABAACAABBAA', 'B', -1, 2) FROM DUAL; -- �ǵں��� �б� �����ؼ� �ι�°�� ������ B��ġ ��ȯ
SELECT INSTR('AABAACAABBAA', 'C', 1, 2) FROM DUAL; -- 1��°���� �б� �����ؼ� �ι�°�� ������ C��ġ ��ȯ

-- �̸����� @ ��ġ ��ȯ
SELECT EMAIL, INSTR(EMAIL, '@', 1, 1)
FROM EMPLOYEE;

-- LPAD / RPAD : �־��� �÷��̳� ���ڿ��� ������ ���ڿ��� ����/�����ʿ� ���ٿ� ���� N�� ���ڿ� ��ȯ
-- (������ ���ڿ� ���� �����ָ� �⺻������ ����)

SELECT LPAD(EMAIL, 20)
FROM EMPLOYEE;

SELECT RPAD(EMAIL, 20)
FROM EMPLOYEE;

SELECT LPAD(EMAIL, 20, '#') 
FROM EMPLOYEE;

SELECT RPAD(EMAIL, 20, DEPT_CODE)
FROM EMPLOYEE;

-- LTRIM / RTRIM / TRIM : �־��� �÷��̳� ���ڿ��� ���� �Ǵ� ������ �Ǵ� ��/��/���ʿ��� ������ ���� ����

SELECT LTRIM('   KH') FROM DUAL; -- ������ ���ڿ��� �������� �ʾ��� ��� ������ �⺻���� �Ǿ� ����
SELECT LTRIM('   KH', ' ') FROM DUAL; -- �ΰ� ������
SELECT LTRIM('000123456' , '0') FROM DUAL;
SELECT LTRIM('123123KH', '123') FROM DUAL;
SELECT LTRIM('123123KH123', '123') FROM DUAL;
SELECT LTRIM('ACABACCKH', 'ABC') FROM DUAL; -- ���ڿ��� ������ ������ ���� �ϳ��ϳ� ��
SELECT LTRIM('5781KH', '0123456789') FROM DUAL;

SELECT RTRIM('KH   ') FROM DUAL;
SELECT RTRIM('123456000', '0') FROM DUAL;
SELECT RTRIM('KHACABACC', 'ABC') FROM DUAL;

SELECT TRIM('      KH      ') FROM DUAL;
SELECT TRIM('Z' FROM 'ZZZKHZZZ') FROM DUAL;
SELECT TRIM('123' FROM '123132KH123321') FROM DUAL; -- Ʈ���� �ѱ��ڸ� �������� ������ ����
SELECT TRIM(LEADING 'Z' FROM 'ZZZ123456') FROM DUAL; -- ��
SELECT TRIM(TRAILING 'Z' FROM '123456ZZZ') FROM DUAL; -- ��
SELECT TRIM(BOTH 'Z' FROM 'ZZZ123456ZZZ') FROM DUAL; -- �翷

-- SUBSTR : �÷��̳� ���ڿ����� ������ ��ġ���� ���� ������ ���ڿ��� �߶� ��ȯ
SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL; -- 7��° ���ں��� �� ��ȯ
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 5, 0) FROM DUAL; -- NULL
SELECT SUBSTR('SHOWMETHEMONEY', 1, 6) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL; -- THE
SELECT SUBSTR('SHOWMETHEMONEY', -10, 2) FROM DUAL;

-- �̸�, �̸���, @���ĸ� ������ ���̵� ��ȸ
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1)
FROM EMPLOYEE;
-- �ֹε�Ϲ�ȣ���� ������ ��Ÿ���� �κи� �߶󺸱�
SELECT SUBSTR(EMP_NO, INSTR(EMP_NO, '-')+1, 1)
FROM EMPLOYEE;
-- �������� �ֹι�ȣ�� �̿��Ͽ� �����, ����, ����, ���� ��ȸ
SELECT EMP_NAME, SUBSTR(EMP_NO,1,2) || '��' ����, SUBSTR(EMP_NO,3,2) || '��' ���� , SUBSTR(EMP_NO,5,2) || '��' ����
FROM EMPLOYEE;

-- LOWER / UPPER / INITCAP
SELECT LOWER('Welcome To My World') FROM DUAL; -- �ҹ���
SELECT UPPER('Welcome To My World') FROM DUAL; -- �빮��
SELECT INITCAP('Welcome to My World') FROM DUAL; -- ���� �� ù �ձ��ڸ� �빮��

-- CONCAT : �� ���ڿ� Ȥ�� �÷� ����
SELECT CONCAT('�����ٶ�', 'ABCD') FROM DUAL;
SELECT '�����ٶ�' || 'ABCD' FROM DUAL;

-- REPLACE : ���ڿ��� ������ ���ڿ��� �ٲ�
SELECT REPLACE('����� ������ ���ﵿ', '���ﵿ', '�Ｚ��') FROM DUAL;
SELECT REPLACE('����ȣ �л��� ������ �����ϱ��?', '����', '����') FROM DUAL;

-- �̸����� �������� GMAIL.COM���� �����ϱ�
SELECT REPLACE(EMAIL, SUBSTR(EMAIL, INSTR(EMAIL,'@')+1),'gmail.com') �̸���
FROM EMPLOYEE;
-- �����, �ֹι�ȣ ��ȸ
-- ��, �ֹι�ȣ�� �������-���� ������ ���̰��ϰ� ������ ���� '*'�� �ٲٱ�
-- 1)
SELECT EMP_NAME �����, REPLACE(EMP_NO, SUBSTR(EMP_NO, 9),'******') �ֹε�Ϲ�ȣ
FROM EMPLOYEE;
-- 2)
SELECT EMP_NAME �����, CONCAT(SUBSTR(EMP_NO, 0, 8),'******') �ֹε�Ϲ�ȣ
FROM EMPLOYEE;
-- 3)
SELECT EMP_NAME �����, RPAD(SUBSTR(EMP_NO, 1, 8), 14,'*') �ֹε�Ϲ�ȣ
FROM EMPLOYEE;


-- 2. ���� ���� �Լ�

-- ABS : ���� ���� ��ȯ���ִ� �Լ�
SELECT ABS(10.9) FROM DUAL;
SELECT ABS(-10.9) FROM DUAL;
SELECT ABS(10) FROM DUAL;
SELECT ABS(-10) FROM DUAL;

-- MOD : ������ ���� ��ȯ���ִ� �Լ� (������ ���� ���� ����� ��ȯ���� ���, ���� ���� ������ ��ȯ���� ����)
SELECT MOD(10, 3) FROM DUAL;    -- 1
SELECT MOD(-10, 3) FROM DUAL;   -- -1
SELECT MOD(10, -3) FROM DUAL;   -- 1
SELECT MOD(10.9, 3) FROM DUAL;  -- 1.9
SELECT MOD(-10.9, 3) FROM DUAL; -- -1.9

SELECT MOD(-10, -3) FROM DUAL;  -- -1

-- ROUND : �ݿø� ���ִ� �Լ� 
SELECT ROUND(123.456) FROM DUAL;    -- 123
SELECT ROUND(123.678, 0) FROM DUAL; -- 124
SELECT ROUND(123.456, 1) FROM DUAL; -- 123.5
SELECT ROUND(123.456, 2) FROM DUAL; -- 123.46
SELECT ROUND(123.456, -2) FROM DUAL;-- 100 (���� ������ �� �տ������� �ݿø�)

SELECT ROUND(-10.61) FROM DUAL;

-- FLOOR : ����
SELECT FLOOR(123.456) FROM DUAL;
SELECT FLOOR(123.678) FROM DUAL;

-- TRUNC : ����(����)
SELECT TRUNC(123.456) FROM DUAL;
SELECT TRUNC(123.678) FROM DUAL;
SELECT TRUNC(123.456, 1) FROM DUAL;
SELECT TRUNC(123.456, -1) FROM DUAL;

-- CEIL : �ø�
SELECT CEIL(123.456) FROM DUAL;
SELECT CEIL(123.678) FROM DUAL;


-- 3. ��¥ ���� �Լ�
-- SYSDATE : ���� ��¥ ��ȯ

-- MONTHS_BETWEEN : ��¥�� ��¥ ������ ���� �� ���̸� ���ڷ� �����ϴ� �Լ�
SELECT EMP_NAME, HIRE_DATE, MONTHS_BETWEEN(SYSDATE, HIRE_DATE)
FROM EMPLOYEE;

-- ADD_MONTHS : ��¥�� ���ڸ�ŭ�� ���� ���� ���� ��¥ ����
SELECT ADD_MONTHS(SYSDATE, 5) FROM DUAL;
SELECT ADD_MONTHS(SYSDATE, 15) FROM DUAL;

-- NEXT_DAY : ���� ��¥���� ���Ϸ��� ���Ͽ� ���� ����� ��¥�� �����ϴ� �Լ�
SELECT SYSDATE, NEXT_DAY(SYSDATE, '�����') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 1) FROM DUAL;
-- ��, ��, ȭ, ��, ��, ��, ��
-- 1,  2,  3, 4,  5,  6, 7
SELECT SYSDATE, NEXT_DAY(SYSDATE, '��') FROM DUAL;
-- �Ǿտ� ȭ ���ڸ� ���� ȭ���Ϸ� �ν�
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'ȭ������ ���� ���� ������ �ϰ� ������?') FROM DUAL;
-- ù���� �ƴϸ� ����
SELECT SYSDATE, NEXT_DAY(SYSDATE, '��ȭ���� �ڱ� �̸��� �Ǵ��� �ñ��ϰ���') FROM DUAL;
-- ���� �ν��ϰ� ���ַ��� ALTER��
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THURSDAY') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THUR') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THUROSEMARY') FROM DUAL;
ALTER SESSION SET NLS_LANGUAGE = KOREAN;

-- LAST_DAY : �ش� ���� ������ ��¥ ����
SELECT SYSDATE, LAST_DAY(SYSDATE) FROM DUAL;

-- EXTRACT : ��¥���� ��, ��, �� �����Ͽ� ����
-- EXTRACT(YEAR FROM ��¥)
-- EXTRACT(MONTH FROM ��¥)
-- EXTRACT(DAY FROM ��¥)

-- ����� �̸�, �Ի� ��, �Ի� ��, �Ի� �� ��ȸ
SELECT EMP_NAME �̸� , EXTRACT(YEAR FROM HIRE_DATE) "�Ի� �⵵", EXTRACT(MONTH FROM HIRE_DATE) "�Ի� ��", EXTRACT(DAY FROM HIRE_DATE)"�Ի� ��"
FROM EMPLOYEE;

-- 4. �� ��ȯ �Լ�
-- TO_CHAR(��¥[, ����]) : ��¥�� �����͸� ������ �����ͷ�
-- TO_CHAR(����[, ����]) : ������ �����͸� ������ �����ͷ�
SELECT TO_CHAR(1234) D FROM DUAL;
SELECT TO_CHAR(1234, '99999') D FROM DUAL; -- 5ĭ, ������ ���� ,��ĭ ����
SELECT TO_CHAR(1234, '00000') D FROM DUAL; -- 5ĭ, ������ ����, ��ĭ 0
SELECT TO_CHAR(1234, 'L99999') D FROM DUAL; -- ��ȭ ����
SELECT TO_CHAR(1234, 'FML99999') D FROM DUAL; -- ������ �ƿ� ���ְ� ������ FM
SELECT TO_CHAR(1234, '$99999') D FROM DUAL;
SELECT TO_CHAR(1234, 'FM$99999') D FROM DUAL;
SELECT TO_CHAR(1234, '99,999') D FROM DUAL;
SELECT TO_CHAR(1234, 'FM99,999') D FROM DUAL;
SELECT TO_CHAR(1234, '00,000') D FROM DUAL;
SELECT TO_CHAR(1234, 'FM00,000') D FROM DUAL;
SELECT TO_CHAR(1234, '9.9EEEE') D FROM DUAL;
SELECT TO_CHAR(1234, '999') D FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL; -- �տ� PM,AM�پ ���̾��� �������
SELECT TO_CHAR(SYSDATE, 'MON DY, YYYY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-FMMM-DD DAY') FROM DUAL; -- FM ������ �ʿ���� 0 ����
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-FMDD DAY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YEAR, Q') || '�б�' FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY"��"MM"��" DD"��" DAY') FROM DUAL;

-- ���� ��¥ ���� ���
SELECT TO_CHAR(SYSDATE, 'YYYY'), TO_CHAR(SYSDATE, 'YY'), TO_CHAR(SYSDATE, 'YEAR')
FROM DUAL;

-- �� ���
SELECT TO_CHAR(SYSDATE, 'MM'), TO_CHAR(SYSDATE, 'MONTH'), TO_CHAR(SYSDATE, 'MON'), TO_CHAR(SYSDATE,'RM')
FROM DUAL;

-- �� ���
SELECT TO_CHAR(SYSDATE, 'DDD'), -- �̹��� ���� ��ĥ° ���
       TO_CHAR(SYSDATE, 'DD'), -- �̹��� ���� ��ĥ°���� ���
       TO_CHAR(SYSDATE,'D') -- �̹��� ���� ��ĥ°���� ���
FROM DUAL;

-- �б�, ���� ���
SELECT TO_CHAR(SYSDATE, 'Q'),
       TO_CHAR(SYSDATE, 'DAY'),
       TO_CHAR(SYSDATE, 'DY')
       FROM DUAL;

-- TO_DATE : ����/������ �����͸� ��¥�� �����ͷ�
SELECT TO_DATE('20100101', 'YYYYMMDD') FROM DUAL;
SELECT TO_DATE(20100101, 'YYYYMMDD') FROM DUAL;

-- 2010 01 01 => 2010. 1��
SELECT TO_CHAR(TO_DATE('20100101', 'YYYYMMDD'),'YYYY, MON')
FROM DUAL;

SELECT TO_CHAR(TO_DATE('041030 143000', 'YYMMDD HH24MISS'), 'YY-MON-DD HH:MI:SS PM')
FROM DUAL;

-- RR�� YY�� ����
SELECT TO_CHAR(TO_DATE('980630', 'YYMMDD'),'YYYYMMDD'), -- YY�� ���� ���� ����
       TO_CHAR(TO_DATE('140918', 'YYMMDD'),'YYYYMMDD'),
       TO_CHAR(TO_DATE('980630', 'RRMMDD'),'YYYYMMDD'), -- RR�� ���ڸ� ������ 50�� �̻��̸� �� ���� ����
       TO_CHAR(TO_DATE('140918', 'RRMMDD'),'YYYYMMDD')  -- RR�� ���ڸ� ������ 50�� �̸��̸� ���� ���� ����
FROM DUAL;

-- TO_NUMBER : ������ �����͸� ������ �����ͷ�
SELECT TO_NUMBER('123456789') FROM DUAL;
SELECT '123' + '456' FROM DUAL;

SELECT '123' + '456A' FROM DUAL;
SELECT '1,000,000' + '550,000' FROM DUAL;
SELECT TO_NUMBER('1,000,000', '99,999,999') FROM DUAL;
SELECT TO_NUMBER('1,000,000', '99,999,999') + TO_NUMBER('550,000', '999,999') FROM DUAL;

-- 5. NULL ó�� �Լ�
-- NVL(�÷� ��, �÷� ���� NULL�϶� �ٲ� ��)

SELECT EMP_NAME, NVL(BONUS,0)
FROM EMPLOYEE;

SELECT EMP_NAME, NVL(DEPT_CODE, '�����ϴ�')
FROM EMPLOYEE;

-- NVL2(�÷� ��, �ٲ� ��1, �ٲ� ��2) NULL�� �ƴϸ� ��1 NULL�̸� ��2
-- ���ʽ��� NULL�� ������ 0.5��, NULL�� �ƴ� ������ 0.7�� �����Ͽ� ��ȸ
SELECT EMP_NAME, BONUS, NVL2(BONUS,0.7,0.5)
FROM EMPLOYEE;

-- NULLIF(�񱳴��1, �񱳴��2) : �� ���� ���� �����ϸ� NULL �������� ������ �񱳴��1 ����
SELECT NULLIF(123,123) FROM DUAL;
SELECT NULLIF(123,124) FROM DUAL;


-- 6. ���� �Լ� : �������� �ܿ� ������ �� �ִ� ��� ����
-- DECODE(����|�÷���, ���ǰ�1, ���ð�1, ���ǰ�2, ���ð�2...)
-- ���ϰ����ϴ� �� �Ǵ� �÷��� ���ǽİ� ������ ��� �� ��ȯ
SELECT EMP_ID, EMP_NAME, EMP_NO,
       DECODE(SUBSTR(EMP_NO, 8, 1), 1, '��', 2, '��') ����
FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, EMP_NO,
       DECODE(SUBSTR(EMP_NO, 8, 1), 1, '��', '��') ����
FROM EMPLOYEE;
-- ������ ���ڷ� ���� �� ���� ���� ���� �ۼ��ϸ�
-- ELSE�� ó�� �ƹ� �͵� �ش���� ������ ������ ���ð��� ������ ������

-- CASE WHEN ���ǽ� THEN ��� ��
--      WHEN ���ǽ� THEN ��� ��
--      ELSE ��� ��
-- END
-- ���ϰ��� �ϴ� �� �Ǵ� �÷��� ���ǽİ� ������ ��� �� ��ȯ(������ ���� ����)
SELECT EMP_ID, EMP_NAME, EMP_NO,
       CASE WHEN SUBSTR(EMP_NO, 8, 1) = 1 THEN '��'
       ELSE '��'
       END ����
FROM EMPLOYEE;

-- �޿��� 500�� �ʰ� 1���, 350�� �ʰ� 2���, 200�� �ʰ� 3���, ������ 4���
SELECT EMP_ID, EMP_NAME, SALARY,
       CASE WHEN SALARY > 5000000 THEN '1���'
            WHEN SALARY > 3500000 THEN '2���'
            WHEN SALARY > 2000000 THEN '3���'
       ELSE '4���'
       END �޿����
FROM EMPLOYEE;

-- �׷� �Լ� : ���� ���� ������ �� ���� ����� ��ȯ
-- SUM(���ڰ� ��ϵ� �÷�) : �հ� ����
-- �� ����� �޿� ���� ��ȸ
SELECT SUM(SALARY)
FROM EMPLOYEE;

-- ���� ����� �޿� ���� ��ȸ
SELECT SUM(DECODE(SUBSTR(EMP_NO, 8, 1), 1, SALARY, 0))
FROM EMPLOYEE;

SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 1;

-- AVG(���ڰ� ��ϵ� �÷�) : ��� ����
-- EMPLOYEE���̺��� �� ����� �޿� ��� ��ȸ

SELECT AVG(SALARY)
FROM EMPLOYEE;

-- �� ����� BONUS �հ� ��ȸ
SELECT SUM(BONUS)
FROM EMPLOYEE;
-- �� ����� BONUS ��� ��ȸ
SELECT AVG(BONUS) ���, AVG(NVL(BONUS, 0)) "NULL �������"
FROM EMPLOYEE;
-- NULL���� ���� ���� ��� ��꿡�� ���� �Ǿ� ���

-- MIN, MAX : �ּڰ�, �ִ밪 
-- ���� ���� �޿�, ���ĺ� ������ ���� ���� �̸���, ���� ���� �Ի��� ��ȸ
SELECT MIN(SALARY), MIN(EMAIL), MIN(HIRE_DATE)
FROM EMPLOYEE;
-- ���� ���� �޿�, ���ĺ� ������ ���� �������� �̸���, ���� ���� �Ի��� ��ȸ
SELECT MAX(SALARY), MAX(EMAIL), MAX(HIRE_DATE)
FROM EMPLOYEE;

-- COUNT(* | �÷���) : ���� ������ ���� ����
-- COUNT(DISTINCT �÷���) : �ߺ��� ������ �� ���� ����
-- COUNT(*) : NULL�� ������ ��ü ���� ���� ����
-- COUNT(�÷���) : NULL�� ������ ��ü �� ���� ����
SELECT COUNT (*), COUNT (DEPT_CODE), COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;








