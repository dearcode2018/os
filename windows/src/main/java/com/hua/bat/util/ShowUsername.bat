@ rem ----- ��Ϣ -----
@ rem @filename x.bat
@ rem @version 1.0
@ rem @description 
@ rem @author qye.zheng

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


@ rem ----- ���������

echo �����û��ʺ�IDΪ��
echo.
for /f "skip=4 tokens=1-3" %%i in ('net user') do (
    if not "%%i"=="����ɹ���ɡ�" echo %%i
    if not "%%j"=="" echo %%j
    if not "%%k"=="" echo %%k
)
echo.
echo ��ǰ�û��ʺ�IDΪ��%username%
pause>nul

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
