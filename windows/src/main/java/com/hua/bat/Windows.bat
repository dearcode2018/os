@rem 说明
@rem 运行环境: Windows OS
@rem 批处理程序 (可以 双击/在cmd下输入bat文件名 来运行)

@rem xx
@title 
@rem ########## begin 示例  ##########

@rem 示例: 打开应用程序(特殊字符需要用[双引号]括起来)
@rem start D:\"Program Files"\eclipse\eclipse.exe

@rem 示例: 设置一个变量
@rem set var_name=var_value

@rem 示例: 引用一个变量
@rem %var_name%

@rem 获取当前路径-示例
set currentPath="%cd%"
set currentPath=%cd%

@rem 调用当前目录 bat 示例
call target.bat
call %cd%\target.bat

@rem 可以书写注释

@rem 获取bat文件自身所在的路径变量
%~dp0


@rem exit
@exit
@rem ########## end of 示例 ##########


@rem ########## begin openProgram ##########
@rem 不同环境修改此变量值即可
@ set myEclipse=D:\myeclipse\xx.exe
@rem open a program
@ start %myEclipse%

@rem ########## begin openProgram ##########



@rem ########## begin 常用命令 ##########
@rem 远程桌面连接 mstsc


@rem ########## end of 常用命令 ##########











@rem ########## begin 文件清理  ##########
@echo off 
echo 正在清除系统垃圾文件，请稍等...... 
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
echo 清除系统LJ完成！ 
echo. & pause 
@rem ########## end of 文件清理  ##########































