@ rem ----- ��Ϣ -----
@ rem @filename CoreLang.bat
@ rem @version 1.0
@ rem @description ����
@ rem @author qye.zheng

@ rem @warning Ϊ�˷�ֹ���Ļ������룬�����ļ���ʱ��Ӧ�ñ���ΪANSI�����ʽ.
@ rem ################################################################################


@ rem ����
@ title CoreLang
@ rem ########## begin  ##########

@ rem �ر���ʾ���ʹ��������ִ��ǰ����ʾ
@ rem @ echo off
echo off
@ rem ��������ʾ @ echo on

:: choice /c ync /m "ȷ���밴 Y�����밴 N������ȡ���밴 C��" 
:: ��ע�⣬��if errorlevel�жϷ���ֵʱ��Ҫ������ֵ�Ӹߵ������У�: 
:: if errorlevel 3 go cancel
:: if errorlevel 2 go no
:: if errorlevel 1 go yes

:: ����û�ѡ���ֵ (1/2/3)
:: echo %errorlevel%

:: :yes
:: echo yes
:: :no
:: echo no
:cancel
:: echo cancel
@ rem ----- ����������


@ rem ----- ���������

@ rem pause

@ rem

@ rem
@ rem �����ʾ��Ϣ

:: ��������
:: 1) if - ��֧���
:: if variableName=="����ֵ" [��ִ�е�����]  ���� if not ""=="%variableName%"
:: if not variableName=="����ֵ" [��ִ�е�����]
:: �ж��ļ���Ŀ¼�Ƿ����
:: if [not] exist pathVariable [��ִ�е�����]
:: if errorlevel ���� [��ִ�е�����]
:: 2) 





:: 3) ѭ�����
:: for %%variableName in (set����) do ���� [����]
:: for %%v in (1 2 3 4 5 6 7) do ����
:: ע�� %%���ѭ������������ֻ���ǵ�����ĸ
:: ����/L��ѭ�� ��ֵ�� start ��ʼ��������step�����һ��ֵ���ܳ���end
:: for /L %%variable in (start, step, end) do ����

:: ���� /F��ѭ�������Զ��ַ������в�����Ҳ�ܹ�������ķ���ֵ���в���
:: set ������"string"��'command'��file-set
:: options�ǣ�eol=c��skip=n��delims=xxx��tokens=x,y,m-n��usebackq���е�һ�����������
:: for /F ["options"] %%variable in (set)

:: 4)
:: 5)
:: 6)
:: 7)
:: 8)
:: 9)
:: 10)

:: for %%n in (1 2 3 4 5 6 7) do echo %%n

for /L %%i in (1, 2, 8) do echo %%i

::: echo %random%

:: �ڳ����ĩβ�����Ը���ִ�еĽ��(�ɹ���ʧ��) ������ʾ��Ϣ���ɹ�����ֱ��ִ��exit����ʧ��
:: ����ִ��pause��Ȼ�����ͨ������̨�����Ϣ�����ԡ���λ����.
:: �����ڳ���������һ���ɹ���ʧ�ܵı�־-����ֵ���������������ִ������.



:: �൱�� return / ref
goto :eof


@ rem echo
pause
@ rem exit
@ rem ########## end of ##########

@ rem ע��˵��: @ rem ע������  ���� :: ע������
@ rem rem ��һ��/����ð�� ���� ������дע��
