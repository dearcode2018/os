@ rem ----- ��Ϣ -----
@ rem @filename Choice.bat
@ rem @version 1.0
@ rem @author qye.zheng
@ rem @description ѡ��/ѡ��

@ rem @warning Ϊ�˷�ֹ���Ļ������룬�����ļ���ʱ��Ӧ�ñ���ΪANSI�����ʽ.
@ rem ################################################################################


@ rem ����
@ title 
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
