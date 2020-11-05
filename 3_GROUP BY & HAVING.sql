-- ORDER BY�� : SELECT�� �÷��� ������ ������ �� ���
-- ORDER BY �÷��� | �÷� ��Ī | �÷��������� [ASC] | DESC
SELECT EMP_ID, EMP_NAME, SALARY �޿�, DEPT_CODE
FROM EMPLOYEE
-- ORDER BY EMP_NAME; -- �⺻������ ��������
-- ORDER BY EMP_NAME ASC; -- ��������
-- ORDER BY EMP_NAME DESC; -- ��������
-- ORDER BY DEPT_CODE ; -- �μ��ڵ� ��������
-- ORDER BY DEPT_CODE NULLS FIRST; -- �μ��ڵ� �������� (�ΰ��� ���� ����)
-- ORDER BY 2; -- �÷����������� ���� ��������
ORDER BY �޿�; -- ��Ī�� ���� ��������

/*
    SELECT �ִ� ����   ����
    
    SELECT �÷� ����   5.
    FROM �̾ƿ� ��     1.
    WHERE ���ǹ�       2.
    GROUP BY          3.
    HAVING            4.
    ORDER BY          6.
*/

-- GROUP BY : ���� ���� ���� ��� �ϳ��� ó���� �������� ���
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE; -- ��� ���� ������ �ٸ�

SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- �μ��ڵ�� ���ʽ��� �޴� ������� ��ȸ�ϰ� �μ��ڵ� ������ ����

SELECT DEPT_CODE, COUNT(BONUS)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- �μ��ڵ� �� �׷��� �����Ͽ� �μ��ڵ�, �׷� �� �޿��� �հ�, �׷� �� �޿��� ���,
-- �ο����� ��ȸ�ϰ� �μ� �ڵ� ������ ����
SELECT DEPT_CODE �μ��ڵ�, SUM(SALARY) �հ�, ROUND(AVG(SALARY)) ���, COUNT(*) �ο���
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- �����ڵ�, ���ʽ��� �޴� ������� ��ȸ�Ͽ� �����ڵ� ������ ��������
SELECT JOB_CODE, COUNT(BONUS)
FROM EMPLOYEE
WHERE BONUS IS NOT NULL -- COUNT(BONUS) �� 0�� ������ ���� ���� ������
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-- ����, ���� �� �޿� ���, �޿� �հ�, �ο� �� ��ȸ�ϰ� �ο� ���� �������� ����
-- GROUP BY�� ��Ī�� ������ ����
SELECT DECODE(SUBSTR(EMP_NO,8,1),1,'��','��') ����, FLOOR(AVG(SALARY)), SUM(SALARY), COUNT(*) �ο���
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO,8,1),1,'��','��')
ORDER BY �ο��� DESC;

-- �μ� �ڵ庰�� ���� ������ ����� �޿� �հ� ��ȸ
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE; -- ���� �÷��� �Բ� ���� �� ����

-- HAVING : �׷��Լ��� ���� �� �׷쿡 ���� ������ ������ �� ���
-- �μ��ڵ�� �޿� 300���� �̻��� ������ �׷캰 ���(�ݿø�) �޿� ��ȸ
SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM EMPLOYEE
WHERE SALARY >= 3000000
GROUP BY DEPT_CODE;
-- �μ��ڵ�� �޿� ����� 300���� �̻��� �׷� ��ȸ
SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING ROUND(AVG(SALARY)) >= 3000000;

-- �μ� �� �׷��� �޿� �հ� �� 9�鸸���� �ʰ��ϴ� �μ� �ڵ�� �޿� �հ�(�μ� �ڵ� ������ ����)
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) > 9000000
ORDER BY DEPT_CODE;

-- �����Լ�(ROLLUP, CUBE) : �׷� �� ������ ��� ���� ���� ���
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE) -- �������� ������ ���� ����
ORDER BY JOB_CODE;

SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(JOB_CODE) -- �������� ������ ���� ����
ORDER BY JOB_CODE;

-- ROLLUP�Լ� : �׷캰�� �߰�����ó���ϴ� �Լ�
-- ���ڷ� ���� ���� �� �߿��� ���� ���� ������ ���ڿ� ���� �׷캰 �߰� ����
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE) -- �׷캰 ����� �߰� ����
ORDER BY DEPT_CODE;

-- CUBE�Լ� : �׷캰�� �߰�����ó���ϴ� �Լ�
-- ���ڷ� ���� ���� �� ��� �׷캰 �߰� ����
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE) -- ��� �׷� ���� ���� ������ ��� ��ȯ
ORDER BY DEPT_CODE;


-- GROUPING �Լ�
-- ROLLUP�̳� CUBE�� ���� ���⹰�� ���ڷ� ���޹��� �÷��� ���⹰�̸� 0 ��ȯ, �ƴϸ� 1 ��ȯ
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY), 
                            GROUPING(DEPT_CODE) �μ����׷칭�λ���, 
                            GROUPING(JOB_CODE) ���޺��׷칭�λ���
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY(DEPT_CODE);


-- ���� ������
-- UNION : ������, OR
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID = 200
UNION
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID = 201;

-- DEPT_CODE�� D5�̰ų� �޿��� 300������ �ʰ��ϴ� ������ ���, �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- UNION ALL : OR + AND (������ + ������) --> �ߺ��� �κ��� �ι� ����
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- INTERSECT : AND (������)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- MINUS : ������ (��ġ�ºκ� ������ ���ڽŸ�)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- GROUPING SETS : �׷캰�� ó���� ���� ���� SELECT���� �ϳ��� ��ĥ �� ���
SELECT DEPT_CODE, JOB_CODE, MANAGER_ID, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE, MANAGER_ID;

SELECT DEPT_CODE, MANAGER_ID, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE, MANAGER_ID;

SELECT JOB_CODE, MANAGER_ID, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY JOB_CODE, MANAGER_ID;

SELECT DEPT_CODE, JOB_CODE, MANAGER_ID, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY GROUPING SETS(
        (DEPT_CODE, JOB_CODE, MANAGER_ID),
        (DEPT_CODE, MANAGER_ID),
        (JOB_CODE, MANAGER_ID))
ORDER BY DEPT_CODE;