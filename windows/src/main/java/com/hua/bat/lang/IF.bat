@ rem ----- ��Ϣ -----
@ rem @filename IF.bat
@ rem @version 1.0
@ rem @author qye.zheng
@ rem @description if��֧���

@ rem @warning Ϊ�˷�ֹ���Ļ������룬�����ļ���ʱ��Ӧ�ñ���ΪANSI�����ʽ.
@ rem ################################################################################


@ rem ����
@ title 
@ rem ########## begin  ##########

@ rem �ر���ʾ���ʹ��������ִ��ǰ����ʾ
@ rem @ echo off
echo off
@ rem ��������ʾ @ echo on
:: ��������
:: 1) if - ��֧���
:: if variableName=="����ֵ" [��ִ�е�����]  ���� if not ""=="%variableName%"
:: if not variableName=="����ֵ" [��ִ�е�����]
:: �ж��ļ���Ŀ¼�Ƿ����
:: if [not] exist pathVariable [��ִ�е�����]
:: if errorlevel ���� [��ִ�е�����]

:: lss - С�ڣ� leq - С�ڵ��ڣ�gtr - ���ڣ�geq - ���ڵ��� (����ֱ��ʹ������ >= �ķ���) 

:: �жϱ����Ƿ��Ѿ�����
if [not] defined variableName () 

:: ����ж�
if errorlevle  ����() else if  ()

:: if ģ��
if [not] [defined | exist | errorlevel | ==] (
	:: 
) else if [not] [defined | exist | errorlevel | ==] (
	::
) else if [not] [defined | exist | errorlevel | ==](
	::
) else (
	::
)

:: if ���ʾ��
set path1=C:\abc

set path2=C:\WINDOWS

if exist %path1% (
	echo %path1% exist!
) else if exist %path2% (
	echo %path2% exist!
) else (
	echo %path1% and %path2% both not exist!
)

set value=abc
if "abc"=="%value%" (
	echo true
) else (
	::
	echo false
)

@ rem ----- ����������


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
