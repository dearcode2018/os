@ rem ----- ��Ϣ -----
@ rem @filename DiskTest.bat
@ rem @version 1.0
@ rem @author qye.zheng
@ rem @description ���̲���

@ rem @warning Ϊ�˷�ֹ���Ļ������룬�����ļ���ʱ��Ӧ�ñ���ΪANSI�����ʽ.
@ rem ################################################################################


@ rem ����
@ title 
@ rem ########## begin  ##########

@ rem �ر���ʾ���ʹ��������ִ��ǰ����ʾ
@ rem @ echo off
@ echo off
@ rem ��������ʾ @ echo on

@ rem ----- ����������


@ rem ----- ���������

::wmic LogicalDisk where "Caption='C:'" get FreeSpace,Size /value 
::echo on
::wmic LogicalDisk where "Caption='C:'" get FreeSpace > disk.txt


:: for /F dir DiskTest.bat
:: �����ǰĿ¼�µ��ļ� (�ӵ����п�ʼ����� tokens=3*)
echo on
echo ===================
for /F "tokens=3* delims= " %%a in ('dir DiskTest.bat') do (
	::if not "<DIR>"=="%%a" if not "�ֽ�"=="%%b" if not "�����ֽ�"=="%%c" echo %%b
	:: if "DiskTest.bat"=="%%b" echo %%a
	::echo %%a ���ļ����� a��ʾ�ļ���С
	::echo %%b ���ļ����� b��ʾ�ļ���
	::echo %%c
	::if "DiskTest.bat"=="%%b" echo %%a
	echo %%b
) 


::wmic LogicalDisk where "Caption='C:'" set fs=get FreeSpace

 pause
@ rem pause

@ rem

@ rem
@ rem �����ʾ��Ϣ

::
:: 1) 
:: 2)
:: 3)
:: 4)
:: 5)
:: 6)
:: 7)
:: 8)
:: 9)
:: 10)

:: �ڳ����ĩβ�����Ը���ִ�еĽ��(�ɹ���ʧ��) ������ʾ��Ϣ���ɹ�����ֱ��ִ��exit����ʧ��
:: ����ִ��pause��Ȼ�����ͨ������̨�����Ϣ�����ԡ���λ����.
:: �����ڳ���������һ���ɹ���ʧ�ܵı�־-����ֵ���������������ִ������.

@ rem echo
@ rem exit
@ rem ########## end of ##########

@ rem ע��˵��: @ rem ע������  ���� :: ע������
@ rem rem ������ð�� ���� ������дע��
