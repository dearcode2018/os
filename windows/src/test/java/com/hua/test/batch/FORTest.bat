@ rem ----- ��Ϣ -----
@ rem @filename FORTest.bat
@ rem @version 1.0
@ rem @author qye.zheng
@ rem @description forѭ������

@ rem @warning Ϊ�˷�ֹ���Ļ������룬�����ļ���ʱ��Ӧ�ñ���ΪANSI�����ʽ.
@ rem ################################################################################


@ rem ����
@ title 
@ rem ########## begin  ##########

@ rem �ر���ʾ���ʹ��������ִ��ǰ����ʾ
@ rem @ echo off
echo off
@ rem ��������ʾ @ echo on

::for /F ["options"] %%s in (set) do (ѭ����)
:: set Ϊ "string" / 'command' / file-set
:: options �� eol=c��skip=n��delims=xxx��tokens=x,y,m-n��usebackq���е�һ�����������
:: ʹ������options �� skip / tokens / delims

:: set str="1,23,3,4,10"
:: for /F
:: for /F "tokens=1-3 delims=," %%a in (%str%) do (echo %%a %%b %%c)

:: �����ǰĿ¼�µ��ļ�
::for /F "tokens=3* delims= " %%a in ('dir') do (
	::if not "<DIR>"=="%%a" if not "�ֽ�"=="%%b" if not "�����ֽ�"=="%%c" echo %%b
::) 


:: /D / R
:: for /D %%d in (.) do (
:: 	echo %%d
:: )
@ echo on
:: ��ĸ���� A -- E (��֧�� ��ĸ ��ʽ�ĵ���)
:: for /L %%d in (A,1,E) do (
:: 	echo %%d
:: )

:: ֧�� 15������������
set drivers=A,B,C,D,E,F,G,H,I,J,K,L,M,N,O
set drivers=C:
set targetPath=
for %%d in (%drivers%) do (
	if exist %%d\Oracle (
		%%d
		cd %%d\Oracle
		:: ����֮�󣬱������µ�������Ŀ¼
		for /D %%v in (*) do (
			cd %%v
			dir .
		)
	)
)

@ rem ----- ����������


@ rem ----- ���������
@ pause
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
