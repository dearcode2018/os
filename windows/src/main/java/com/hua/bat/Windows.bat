@rem ˵��
@rem ���л���: Windows OS
@rem ��������� (���� ˫��/��cmd������bat�ļ��� ������)

@rem xx
@title 
@rem ########## begin ʾ��  ##########

@rem ʾ��: ��Ӧ�ó���(�����ַ���Ҫ��[˫����]������)
@rem start D:\"Program Files"\eclipse\eclipse.exe

@rem ʾ��: ����һ������
@rem set var_name=var_value

@rem ʾ��: ����һ������
@rem %var_name%

@rem ��ȡ��ǰ·��-ʾ��
set currentPath="%cd%"
set currentPath=%cd%

@rem ���õ�ǰĿ¼ bat ʾ��
call target.bat
call %cd%\target.bat

@rem ������дע��

@rem ��ȡbat�ļ��������ڵ�·������
%~dp0


@rem exit
@exit
@rem ########## end of ʾ�� ##########


@rem ########## begin openProgram ##########
@rem ��ͬ�����޸Ĵ˱���ֵ����
@ set myEclipse=D:\myeclipse\xx.exe
@rem open a program
@ start %myEclipse%

@rem ########## begin openProgram ##########



@rem ########## begin �������� ##########
@rem Զ���������� mstsc


@rem ########## end of �������� ##########











@rem ########## begin �ļ�����  ##########
@echo off 
echo �������ϵͳ�����ļ������Ե�...... 
del /f /s /q %systemdrive%\*.tmp 
del /f /s /q %systemdrive%\*._mp 
del /f /s /q %systemdrive%\*.log 
del /f /s /q %systemdrive%\*.gid 
del /f /s /q %systemdrive%\*.chk 
del /f /s /q %systemdrive%\*.old 
del /f /s /q %systemdrive%\recycled\*.* 
del /f /s /q %windir%\*.bak 
del /f /s /q %windir%\prefetch\*.* 
rd /s /q %windir%\temp & md %windir%\temp 
del /f /q %userprofile%\cookies\*.* 
del /f /q %userprofile%\recent\*.* 
del /f /s /q "%userprofile%\Local Settings\Temporary Internet Files\*.*" 
del /f /s /q "%userprofile%\Local Settings\Temp\*.*" 
del /f /s /q "%userprofile%\recent\*.*" 
echo ���ϵͳLJ��ɣ� 
echo. & pause 
@rem ########## end of �ļ�����  ##########































