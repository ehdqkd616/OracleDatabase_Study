-- SELECT
-- Result Set : SELECT �������� �����͸� ��ȸ�� �����, ��ȯ�� ����� ���� (0�� �̻�)

-- EMPLOYEE���̺��� ����� �̸�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;

-- EMPLOYEE���̺��� ��� ����� ��� ���� ��ȸ
SELECT EMP_ID,EMP_NAME,EMP_NO,EMAIL,PHONE,DEPT_CODE,JOB_CODE,SAL_LEVEL,SALARY,BONUS,MANAGER_ID,HIRE_DATE,ENT_DATE,ENT_YN 
FROM EMPLOYEE;

SELECT * 
FROM EMPLOYEE;

-- �̴� �ǽ� ����
-- 1. JOB���̺��� ��� ���� ��ȸ
SELECT * FROM JOB;
-- 2. JOB���̺��� ���� �̸� ��ȸ
SELECT JOB_NAME FROM JOB;
-- 3. DEPARTMENT���̺��� ��� ���� ��ȸ
SELECT * FROM DEPARTMENT;
-- 4. EMPLOYEE���̺��� ������, �̸���, ��ȭ��ȣ, ����� ��ȸ
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE FROM EMPLOYEE;
-- 5. EMPLOYEE���̺��� �����, ��� �̸�, ���� ��ȸ
SELECT HIRE_DATE, EMP_NAME,SALARY FROM EMPLOYEE;

-- �÷� �� ��� ����
-- SELECT �� �÷� �� �Է� �κп� ��꿡 �ʿ��� �÷� ��, ����, �����ڸ� �̿��ؼ� ��� ��ȸ ����

-- EMPLOYEE ���̺� ���� ��, ���� ��ȸ (���� = �޿�*12)
SELECT EMP_NAME,SALARY*12
FROM EMPLOYEE;

-- EMPLOYEE���̺��� ������ ���� ��, ����, ���ʽ��� �߰��� ���� ��ȸ
SELECT EMP_NAME, SALARY*12, (SALARY + SALARY*BONUS) * 12
FROM EMPLOYEE;

SELECT EMP_NAME, SALARY*12, (SALARY *(1+BONUS)) * 12
FROM EMPLOYEE;

-- �̴� �ǽ� ���� 2!
-- 1. EMPLOYEE ���̺��� �̸�, ����, �Ѽ��ɾ�(���ʽ�����), �Ǽ��ɾ�(�Ѽ��ɾ� - (����*����3%)) ��ȸ
SELECT EMP_NAME,SALARY*12, (SALARY *(1+BONUS)) * 12 , ((SALARY *(1+BONUS)) * 12) - (SALARY*12*0.03) 
FROM EMPLOYEE;
-- 2. EMPLOYEE ���̺��� �̸�, �����, �ٹ��ϼ�(���� ��¥ - �����) ��ȸ
SELECT EMP_NAME, HIRE_DATE, FLOOR(SYSDATE - HIRE_DATE)
FROM EMPLOYEE;

SELECT SYSDATE - HIRE_DATE �ٹ��ϼ�, ROUND(SYSDATE - HIRE_DATE) �ݿø�, CEIL(SYSDATE - HIRE_DATE) �ø�,
       FLOOR(SYSDATE - HIRE_DATE) ����, TRUNC(SYSDATE - HIRE_DATE) ����
FROM EMPLOYEE;

-- �÷� ��Ī ���� �� 4����

-- �÷� �� AS ��Ī
-- �÷� �� "��Ī"
-- �÷� �� AS "��Ī"
-- �÷� �� ��Ī
-- ��Ī�� ����, Ư������, ���� ���Ե� ��� ������ ""���� �������

-- EMPLOYEE ���̺��� ������ ������ (��Ī : �̸�), ����(��Ī : ����(��)), ���ʽ��� �߰��� ���� (��Ī : �Ѽҵ�(��)) ��ȸ
SELECT EMP_NAME �̸�, SALARY*12 "����(��)",  SALARY * (1+BONUS) * 12 AS "�Ѽҵ�(��)"
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� �̸�, �����, �ٹ��ϼ�(���ó�¥ - �����) ��ȸ
SELECT EMP_NAME AS �̸�, HIRE_DATE AS �����, SYSDATE-HIRE_DATE �ٹ��ϼ�
FROM EMPLOYEE
WHERE EMP_NAME != '������';

-- ���ͷ�
-- ���̺� �ȿ� ���� ���µ� �÷��� �ִ°� ó�� �����ϴ°� SELECT���� ���
-- ���ڳ� ��¥ ���ͷ��� ' ' ��ȣ ���Ǹ� ��� �࿡ �ݺ� ǥ�� ��

-- EMPLOYEE ���̺��� ������ ���� ��ȣ, ��� ��, �޿�, ����(������ �� : ��) ��ȸ
SELECT EMP_ID "���� ��ȣ", EMP_NAME "��� ��", SALARY �޿�, '��' ����
FROM EMPLOYEE;


-- DISTINCT �÷��� ���Ե� �ߺ� ���� �� ������ ǥ���ϰ��� �� �� ���
-- DISTINCT�� SELECT���� �� �ѹ��� �� �� ����
-- �ΰ� ���� �ߺ����� �Ұ�� �� ���� ��ġ�� ����
SELECT JOB_CODE
FROM EMPLOYEE;

-- �����ڵ� �ߺ�����
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

-- �����ڵ�, �μ��ڵ� �ߺ����� �Ͽ� ��ȸ
SELECT DISTINCT DEPT_CODE, JOB_CODE
FROM EMPLOYEE;

-- WHERE�� : SELECT�� �ɸ��� ���ǹ��� ���� ��
-- ��ȸ�� ���̺��� ������ �´� ���� ���� ���� ���
-- �� ������
-- = ����, > ũ��, < �۳�, >= ũ�ų� ����, <= �۰ų� ����
-- !=,^=,<> �� ����

-- �μ��ڵ尡 'D9'�� ���� �̸�, �μ��ڵ� ��ȸ
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- �޿��� 4000000 �̻��� ������ �̸�, �޿� ��ȸ
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- �μ��ڵ尡 D9�� �ƴ� ����� ���, �̸�, �μ��ڵ� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
-- WHERE DEPT_CODE != 'D9';
-- WHERE DEPT_CODE ^= 'D9';
WHERE DEPT_CODE <> 'D9';

-- EMPLOYEE���̺��� ��� ���ΰ� N�� ������ ��ȸ�ϰ�
-- �ٹ� ���θ� ���������� ǥ���Ͽ� ���, �̸�, �����, �ٹ� ���� ��ȸ
SELECT EMP_ID, EMP_NAME, HIRE_DATE, '������' �ٹ�����
FROM EMPLOYEE
WHERE ENT_YN = 'N';

-- �̴� �ǽ� ����
-- ���� 3000000�̻��� ��� �̸�, ����, ����� ��ȸ
SELECT EMP_NAME �̸�, SALARY ����, HIRE_DATE �����
FROM EMPLOYEE
WHERE SALARY >= 3000000;
-- SAL_LEVEL�� S1�� ����� �̸�, ����, �����, ����ó ��ȸ
SELECT EMP_NAME �̸�, SALARY ����, HIRE_DATE �����, PHONE ����ó
FROM EMPLOYEE
WHERE SAL_LEVEL = 'S1';
-- �Ǽ��ɾ�(�Ѽ��ɾ� - (����*����3%))�� 5õ���� �̻��� ����� �̸�,����,�Ǽ��ɾ�,����� ��ȸ
SELECT EMP_NAME �̸�, SALARY ����, (SALARY*12*(1+BONUS)) - (SALARY*12*0.03) �Ǽ��ɾ�, HIRE_DATE �����
FROM EMPLOYEE
WHERE (SALARY*12*(1+BONUS)) - (SALARY*12*0.03) >= 50000000;

-- �� ������ : AND / OR
-- EMPLOYEE���̺��� �μ��ڵ尡 'D6'�̰� �޿��� 2�鸸�� ���� ���� �޴� ������ �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME �̸�, DEPT_CODE �μ��ڵ�, SALARY �޿�
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' AND SALARY > 2000000;

-- �μ��ڵ尡 'D6'�̰ų� �޿��� 2�鸸������ ���� �޴� ������ �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME �̸�, DEPT_CODE �μ��ڵ�, SALARY �޿�
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR SALARY > 2000000;

-- �޿��� 350�� �̻� 600�� ���ϸ� �޴� ������ ���, �̸�, �޿�, �μ��ڵ�, ���� �ڵ� ��ȸ
SELECT EMP_ID ���, EMP_NAME �̸�, SALARY �޿�, DEPT_CODE �μ��ڵ�, JOB_CODE "���� �ڵ�"
FROM EMPLOYEE
WHERE 6000000 >= SALARY AND SALARY >= 3500000;

-- �̴� �ǽ� ����
-- ������ 400���̻��̰� JOB_CODE�� J2�� ����� ��ü ���� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE JOB_CODE = 'J2' AND SALARY >= 4000000;
-- DEPT_CODE�� D9�̰ų� D5�� ��� �� ������� 02�� 1�� 1�� ���� ���� ����� �̸�, �μ��ڵ�, ����� ��ȸ
SELECT EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE = 'D9' OR DEPT_CODE = 'D5') AND '02/01/01' > HIRE_DATE;

-- BETWEEN AND : ���� �� �̻� ���� �� ����
-- �÷��� BETWEEN ���� �� AND ���� ��
-- ���� �� <= �÷� <= ���� ��

-- �޿� 350�� ���� ���� 600�� ���� ���� �޴� ����� �̸�, �޿� ��ȸ
SELECT EMP_NAME,SALARY
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000;

SELECT EMP_NAME,SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;

-- �ݴ�� 350�� �̸�, �Ǵ� 600���� �ʰ��ϴ� ������ ���, �̸�, �޿�, �μ��ڵ�, �����ڵ� ��ȸ(NOT)

SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE SALARY NOT BETWEEN 3500000 AND 6000000;

SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE NOT SALARY BETWEEN 3500000 AND 6000000;

-- �̴� �ǽ� ����
-- ������� '90/01/01'~'01/01/01' �� ����� ��ü ���� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';

-- LIKE : ���Ϸ��� ���� ������ Ư�� ������ ���� ��Ű���� ��ȸ
-- %,_
-- % : 0���� �̻�
-- _ : 1����
-- '����%' : ���ڷ� �����ϴ� ��
-- '%����%' : ���ڸ� �����ϴ� ��
-- '%����' : ���ڷ� ������ ��
-- '_' : �� ����
-- '__' : �� ����
-- '��__' : ������ ���۵Ǵ� �� ����
-- '����_' : ���ڷ� �����ϴ� �� ����
-- '_����_' : �յڿ� �ѱ��ھ��ְ� ��� ���ڰ� �ִ� ��
-- '_����' : ���ڷ� ������ �� ����

-- ���� ������ ����� ���, �̸�, ����� ��ȸ
SELECT EMP_ID ���, EMP_NAME �̸�, HIRE_DATE �����
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%';

-- �̸��� '��'�� ���Ե� ������ �̸�, �ֹι�ȣ, �μ��ڵ� ��ȸ
SELECT EMP_NAME �̸�, EMP_NO �ֹι�ȣ, DEPT_CODE �μ��ڵ�
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%';

-- ��ȭ��ȣ 4��° �ڸ��� 9�� �����ϴ� ����� ���, �̸�, ��ȭ��ȣ ��ȸ
SELECT EMP_ID ���, EMP_NAME �̸�, PHONE ��ȭ��ȣ
FROM EMPLOYEE
WHERE PHONE LIKE '___9%';

-- �̸��� �� _ �ձ��ڰ� 3�ڸ��� �̸��� �ּҸ� ���� ����� ���, �̸�, �̸��� �ּ� ��ȸ
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '____%';
-- ���ϵ�ī���� _�� �˻��ϰ��� �ϴ� ���� �ȿ� ���� ���ڿ� ���� ������
-- ���� ��ü�� �ƴ� ���ϵ� ī��� �ν�

-- ESCAPE OPTION : �����ͷ� ó���� ���� ��ȣ �տ� ������ ���ڸ� ����ϰ� ESCAPE OPTION ���
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
--WHERE EMAIL LIKE '___#_%' ESCAPE '#';
--WHERE EMAIL LIKE '___A_%' ESCAPE 'A'; -- ���ڵ� �������
WHERE EMAIL LIKE '___ _%' ESCAPE ' '; -- ���⵵ �������

-- NOT LIKE : Ư�� ������ ������Ű�� �ʴ� �� ��ȸ
-- �达 ���� �ƴ� ������ ���, �̸�, ����� ��ȸ
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
--WHERE NOT EMP_NAME LIKE '��%';
WHERE EMP_NAME NOT LIKE '��%';

-- �̴� �ǽ� ����
-- 1. �̸� ���� '��'���� ������ ����� �̸� ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��';
-- 2. ��ȣ ó�� 3�ڸ��� 010�� �ƴ� ����� �̸�, ��ȭ��ȣ�� ��ȸ
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';
-- 3. �����ּ� '_'�� ���� 4�� �̸鼭 DEPT_CODE�� D9 �Ǵ� D6�̰�
--    ������� 90/01/01 ~ 00/12/01�̰�, �޿��� 270�� �̻��� ����� ��ü�� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '____A_%' ESCAPE 'A' AND (DEPT_CODE = 'D9' OR DEPT_CODE = 'D6') 
                                      AND HIRE_DATE BETWEEN '90/01/01' AND '00/12/01'
                                      AND SALARY >= 2700000;

-- IS NULL / IS NOT NULL
-- IS NULL : �÷� ���� NULL�� ���
-- IS NOT NULL : �÷� ���� NULL�� �ƴ� ���

-- ���ʽ��� ���� �ʴ� ����� ���, �̸�, �޿�, ���ʽ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;

-- ���ʽ��� �޴� ����� ���, �̸�, �޿�, ���ʽ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;

-- �����ڵ� ���� �μ���ġ�� ���� �ʴ� ������ �̸�, ������, �μ��ڵ� ��ȸ
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;
-- �μ� ��ġ�� ���� �ʾ����� ���ʽ��� �޴� ������ �̸�, ���ʽ�, �μ��ڵ� ��ȸ
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

-- IN
-- ���Ϸ��� �� ��Ͽ� ��ġ�ϴ� ���� ������ TRUE�� ��ȯ�ϴ� ������
-- �μ��ڵ尡 D6�̰ų� D9�� ����� �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9' OR DEPT_CODE = 'D6';

SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN('D6','D9');

-- ���� �ڵ尡 J1,J2,J3,J4�� ������� �̸�, ���� �ڵ�, �޿� ��ȸ
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE = 'J1' OR JOB_CODE = 'J2' OR JOB_CODE = 'J3' OR JOB_CODE = 'J4';

SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN('J1','J2','J3','J4');

-- ���� ������ || : ���� �÷��� �����ϰų� �÷��� ���ͷ��� �����ϴ� ������
-- ���, �̸�, �޿��� �����Ͽ� ��ȸ
SELECT EMP_ID || EMP_NAME || SALARY 
FROM EMPLOYEE;

-- '��� ���� ������ �޿����Դϴ�.' �������� ��ȸ
SELECT EMP_NAME || '�� ������ '|| SALARY || '���Դϴ�.'
FROM EMPLOYEE;


SELECT EMP_ID, EMP_NAME, NVL(DEPT_CODE, "�μ� ����"), SALARY
FROM EMPLOYEE
WHERE (DEPT_CODE, SALARY) IN (SELECT DEPT_CODE, MAX(SALARY)
FROM EMPLOYEE
GROUP BY NVL(DEPT_CODE, "�μ� ����"))
ORDER BY NVL(DEPT_CODE, "�μ� ����");


