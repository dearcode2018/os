@ rem ----- ��Ϣ -----
@ rem @filename JarSource.bat
@ rem @version 1.0
@ rem @author qye.zheng
@ rem @description �鵵javaԴ�ļ�

@ rem @warning Ϊ�˷�ֹ���Ļ������룬�����ļ���ʱ��Ӧ�ñ���ΪANSI�����ʽ.
@ rem ################################################################################
@rem call %cd%\common.bat
@rem %~dp0 is varibable of bat file self
@rem cd bat file path
@ cd %~dp0
@rem call common config
@ call JdkConfig.bat

@ rem ����
@ title Java Archive Source File
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
if exist %jarDir% (
	cd %jarDir%
	:: ����Ŀ¼��ƴ��Ŀ¼����
	for /D %%v in (*) do (
	set dirs=!dirs! %%v
	)
) else (
	echo %jarDir%:Ŀ¼������!
	@ pause
)
	set sourceJarName=%jarPrefixName%-sources.jar
	:: ���� jar ���� (Ӧ���� !dirs! ������ %dirs%��%dirs%Ӧ�÷��ڷ�֧�������ⲿʹ��)
	jar cvf %sourceJarName% %dirs%
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
