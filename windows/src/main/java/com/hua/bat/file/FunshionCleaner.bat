@ rem ----- ��Ϣ -----
@ rem @filename FunshionCleaner.bat
@ rem @version 1.0
@ rem @author qye.zheng
@ rem @description ���е�Ӱ - ������

@ rem @warning Ϊ�˷�ֹ���Ļ������룬�����ļ���ʱ��Ӧ�ñ���ΪANSI�����ʽ.
@ rem ################################################################################


@ rem ����
@ title ���е�Ӱ - ������
@ rem ########## begin  ##########

@ rem �ر���ʾ���ʹ��������ִ��ǰ����ʾ
@ rem @ echo off
@ echo off
@ rem ��������ʾ @ echo on
@ echo on
@ rem ----- ����������
:: ֧�� 15������������
set drivers=A:,B:,C:,D:,E:,F:,G:,H:,I:,J:,K:,L:,M:,N:,O:

set funsionBasePath=C:\"Documents and Settings"\Administrator\funshion\base

:: ������ʽɾ����Ŀ¼
rd /S /Q %funsionBasePath%

:: �����ò���
::set drivers=D:

:: ���е�Ӱ �ڸ��������������·��
set relativePath=FunshionMedia

::set deleteTarget=*.dat

for %%d in (%drivers%) do (
	if exist %%d\%relativePath% (
		:: ·�����ڣ������ָ����������
		%%d
		:: �������ڵ�Ŀ¼
		cd %%d\%relativePath%
		:: ����֮�󣬱������µ�������Ŀ¼
		for /D %%v in (*) do (
			cd %%v
			:: �� *.dat �ļ��г���
			dir *.dat
			:: ɾ�� �������е� *.dat �ļ�
			del *.dat
			:: һ��Ҫ�����ϼ�Ŀ¼ ���ܼ���ѭ������Ŀ¼
			cd ..
		)
	)
)
@ rem ----- ���������

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
