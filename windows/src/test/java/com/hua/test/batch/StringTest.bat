@ rem ----- ��Ϣ -----
@ rem @filename StringTest.bat
@ rem @version 1.0
@ rem @author qye.zheng
@ rem @description �ַ�������

@ rem @warning Ϊ�˷�ֹ���Ļ������룬�����ļ���ʱ��Ӧ�ñ���ΪANSI�����ʽ.
@ rem ################################################################################


@ rem ����
@ title 
@ rem ########## begin  ##########

@ rem �ر���ʾ���ʹ��������ִ��ǰ����ʾ
@ rem @ echo off
echo off
@ rem ��������ʾ @ echo on

@ rem ----- ����������

set str1=welcome to batch!

:: �ַ������� �� ���� ƴ��
set str1=%str1%join

echo %str1%
echo %str1:~1%
echo %str1:~1,3%
echo %str1:~3,1%

echo ��ǰʱ���ǣ�%time% �� %time:~0,2%��%time:~3,2%��%time:~6,2%��%time:~9,2%����
:: echo ��ǰʱ���ǣ�%time% �� %time:~0,2%��%time:~3,2%��%time:~6,2%��%time:~9,2%����

set strReplace=abbcab
::ִ���滻
set strReplace=%strReplace:ab=AB%
echo %strReplace%


:: �����ַ���
set path=C:\Program Files
:: %~fl
::eho %~fl
::for %%i in (%path%) do (echo %~l)



@ rem ----- ���������

@ rem pause
pause
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
