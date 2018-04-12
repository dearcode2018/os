@ rem ----- 信息 -----
@ rem @filename AddAutoStartReg.bat
@ rem @version 1.0
@ rem @author qye.zheng
@ rem @description 添加自动启动注册表数据

@ rem @warning 为了防止中文环境乱码，保存文件的时候，应该保存为ANSI编码格式.
@ rem ################################################################################
:: 获取bat文件所在的磁盘驱动器，例如 C:
set currentDriver=%~dp0
set currentDriver=%currentDriver:~0,2%
:: 执行完其他批处理脚本，进入当前脚本所在的路径
%currentDriver%
cd %~dp0

@ rem 标题
@ title 
@ rem ########## begin  ##########

@ rem 关闭显示命令，使所有命令执行前不显示
@ rem @ echo off
@ echo off
@ rem 打开命令显示 @ echo on

@ rem ----- 变量声明区

@ rem ----- -----------------------------------自定义变量区--------------------------------------------------------
@rem 自动启动应用(软件)的名称，对应在主表目录下创建一个项
set ITEM_NAME=HiJson2

@rem 自动启动应用(软件)的路径，对应在主表目录下项的值，一般为字符串，要用双引号包围起来
set APP_PATH="C:\Users\admin\Desktop\HiJson.exe"


@ rem ----- -----------------------------------系统变量区--------------------------------------------------------
@rem 自动启动的注册表目录
set REG_KEY=HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run

@rem 先删除，然后在添加，/f表示没有提示直接删除
reg delete %REG_KEY% /v %ITEM_NAME% /f

reg add %REG_KEY% /v %ITEM_NAME% /d %APP_PATH%
@ rem ----- 程序设计区

@ rem pause

@ rem

@ rem
@ rem 输出提示信息

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

:: 在程序的末尾，可以根据执行的结果(成功或失败) 给出提示信息，成功可以直接执行exit，而失败
:: 可以执行pause，然后可以通过控制台输出信息来调试、定位问题.
:: 可以在程序中设置一个成功或失败的标志-布尔值，来决定最后程序的执行流程.

@ rem echo
@ rem exit
@ rem ########## end of ##########

@ rem 注释说明: @ rem 注释内容  或者 :: 注释内容
@ rem rem 或两个冒号 后面 都可以写注释
