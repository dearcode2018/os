@ rem ----- ��Ϣ -----
@ rem @filename FileCopy.bat
@ rem @version 1.0
@ rem @author qye.zheng
@ rem @description �ļ�����

@ rem @warning Ϊ�˷�ֹ���Ļ������룬�����ļ���ʱ��Ӧ�ñ���ΪANSI�����ʽ.
@ rem ################################################################################


@ rem ����
@ title �ļ�����
@ rem ########## begin  ##########

@ rem �ر���ʾ���ʹ��������ִ��ǰ����ʾ
@ rem @ echo off
@ echo off
@ rem ��������ʾ @ echo on

@ rem ----- ����������



@ rem ----- ���������

::copy /Y  E:\FunshionMedia\�����μ�-MP4\�����μ�-��28��.mp4 G:\VIDEO

if errorlevel 0 (
	echo copy success!
) else (
	echo copy failure!
)

cd E:\FunshionMedia\�����μ�-MP4
E:

for /f "delims=" %%a in ('dir/a/b *.%lx%') do call :a "%%a"
for /f "delims=" %%a in ('dir/a/b/on *.%lx%') do set/a "n+=1"&ren "%%a" "!n:~-3!%%~xa" 

::for /R %%v in (.,*) do (
::	echo %%v
::)

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
