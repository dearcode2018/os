@ rem ----- ��Ϣ -----
@ rem @filename JavaDoc.bat
@ rem @version 1.0
@ rem @author qye.zheng
@ rem @description ���� java document

@ rem @warning Ϊ�˷�ֹ���Ļ������룬�����ļ���ʱ��Ӧ�ñ���ΪANSI�����ʽ.
@ rem ################################################################################
@rem call %cd%\common.bat
@rem %~dp0 is varibable of bat file self
@rem cd bat file path
@ cd %~dp0
@rem call common config
@ call JdkConfig.bat

@ rem ����
@ title 
@ rem ########## begin  ##########

@ rem �ر���ʾ���ʹ��������ִ��ǰ����ʾ
@ rem @ echo off
@ echo off
@ rem ��������ʾ @ echo on

:: �����˹��ܣ���forѭ�����ַ��������ۻ�ƴ��
@setlocal enabledelayedexpansion

@ rem ----- ����������


@ rem ----- ���������
:: �л��������鵵��Ŀ¼
if exist %docDir% (cd %docDir%) else (echo %docDir%: Ŀ¼������!)
@ cd %docDir%

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
