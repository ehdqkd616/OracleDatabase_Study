-- ������ ����
-- �����ͺ��̽��� ������ ������ ����ϴ� ���� ���� ����
-- �����ͺ��̽��� ���� ��� ���Ѱ� å���� ������ ����

-- ����� ����(�Ϲ� ����)
-- �����ͺ��̽��� ���Ͽ� ����(Query), ����, ���� �ۼ� ���� �۾��� ������ �� �ִ� ����
-- ������ ���� ������ �ʿ��� �ּ����� ���Ѹ� ������ ���� ��Ģ���� ��
CREATE USER KH IDENTIFIED BY KH;
--      ����� ���� �̸�       ����� ���� ��й�ȣ
GRANT RESOURCE, CONNECT TO KH;

--  ���̺� : �����ͺ��̽� ������ ��� �����ʹ� ���̺� ����
--          ��� Į������ �����Ǵ� ���� �⺻���� �����ͺ��̽� ��ü

CREATE USER SCOTT IDENTIFIED BY SCOTT;
GRANT RESOURCE, CONNECT TO SCOTT;

CREATE USER CHOON IDENTIFIED BY CHOON;
GRANT RESOURCE, CONNECT TO CHOON;