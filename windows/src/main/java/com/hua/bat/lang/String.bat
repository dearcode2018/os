@ rem ----- ��Ϣ -----
@ rem @filename String.bat
@ rem @version 1.0
@ rem @description �ַ���
@ rem @author qye.zheng

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
:: �ַ���
:: 1) �±��0��ʼ
:: 2)  Ϊ�˷�ֹ�ַ��������к����ַ��������ܱ���Ϊ����
:: �����Ҫ��˫���Ű��ַ���������Χ��������Ӧ���ڱȽ�
:: ��ʱ��Ҳ��Ҫ���ַ���������˫���Ű�Χ���������� "abc"=="%strVar%"
::

set str1=abc
set str2=def
::�ַ���ƴ��
set str1=%str1%%str2%
:: ����ƴ���ַ�������
set str1=%str1%joinString

::����ַ���ֵ
echo %str1%

:: �ַ�����ȡ
set str3=good morning
:: 1) 1������ ����ʼ������ĩβ %strVar:~startIndex%���������ʾ���n���ַ� ���� %strVar:~-5% ��ȡ���5���ַ�
:: 2) 2������ ����ʼ������ȡָ���ĳ��� %strVar:~startIndex,length% �������ʾ�ӵ����ڼ����ַ���ʼ��ȡ���ٸ��ַ�
echo %str3:~1%
echo %str3:~0,3%

:: ��ȡʱ���ַ���
::echo ��ǰʱ���ǣ�%time% �� %time:~0,2%��%time:~3,2%��%time:~6,2%��%time:~9,2%����

:: ��ȡָ��λ�õ��ַ� index
:: %strVar:~startIndex,1%
:: ��ȡ�±���2���ַ�
echo %str3:2,1%

:: �ַ����滻 (�����ַ�������� �����滻)
:: �滻ʾ��
set strReplace=abyyab
::ִ���滻
set strReplace=%strReplace:ab=AB%
::�滻���� AByyAB
echo %strReplace%

:: ͨ�����ַ�ʽ���� ��ָ��������ֵ �滻Ϊ ָ����ֵ
call set var=%%var:%replaceVar%=replaceValue%%

:: �����ַ���
:: �������б�����֧�����䣬Ҫ����2������
:: 1) ���ַ�����ʾһ���ļ�·�� 2) ������ %x��ʾ��x ��ȡa-z A-Z 0-9��62���ַ��е�����һ






:: �����˹��ܣ���forѭ�����ַ��������ۻ�ƴ��
@setlocal enabledelayedexpansion
@set classpath=.
@for %%c in (a,b,c) do @set classpath=!classpath!;%%c
@set classpath=%classpath%;./bin;
@echo %classpath%





set str4=welcome to earth
set length=0
set string=%str4%

:stringLength
if not ""=="%string%" (
:: ����ֵ����1 /a ��ֵ�ۼ�
set /a length+=1
:: ��ȡ�ַ���(��1��ʼ��ĩβ)
set string=%string:~1%
:: ѭ������
goto stringLength
)

echo %length%


set str5=how do you do
set targetChar=n
:: �����ַ�������Ӱ��Դ�ַ���
set findChar=%str5%
set index=0

:findCharAt
if ""=="%findChar%" (
:: û���ҵ�
set index=-1
:: ֱ����������λ��
goto findChartLast
)
if not "%findChar:~0,1%"=="%targetChar%" (
set findChar=%findChar:~1%
:: ����ֵ����
set /a index+=1
goto findCharAt
)
:: ������ֵ
:findChartLast
echo %index%

@ rem ----- ���������



@ rem pause

@ rem

@ rem
@ rem �����ʾ��Ϣ

:: �ַ���
:: 1) �ַ��� - ƴ��
:: set str1=strValue
:: set str1=%str1%%str2%
:: 2) �ַ��� - ��ȡ
:: set str=%srcString:~��ʼ�±�(��0��ʼ), ��ȡ����%�� ��ָ��һ��������������substring(int startIndex) Ч��
:: 3) �ַ�������
:: ʹ��goto����һ��ѭ����䣬���Ͻ�ȡ�ַ����ĳ����������䳤��
:: 
:: 4) �����ַ������� findChart(char)
:: ͨ��goto����ѭ�� ��ȡ��һ���ַ���Ŀ���ַ��Ƚϣ�����������������λ�ã���û�ҵ��򷵻�-1
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
pause
@ rem exit
@ rem ########## end of ##########

@ rem ע��˵��: @ rem ע������  ���� :: ע������
@ rem rem ������ð�� ���� ������дע��
