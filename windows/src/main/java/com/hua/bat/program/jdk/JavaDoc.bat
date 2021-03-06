@ rem ----- 信息 -----
@ rem @filename JavaDoc.bat
@ rem @version 1.0
@ rem @author qye.zheng
@ rem @description 生成 java document

@ rem @warning 为了防止中文环境乱码，保存文件的时候，应该保存为ANSI编码格式.
@ rem ################################################################################
@rem call %cd%\common.bat
@rem %~dp0 is varibable of bat file self
@rem cd bat file path
@ cd %~dp0
@rem call common config
@ call JdkConfig.bat

@ rem 标题
@ title 
@ rem ########## begin  ##########

@ rem 关闭显示命令，使所有命令执行前不显示
@ rem @ echo off
@ echo off
@ rem 打开命令显示 @ echo on

:: 启动此功能，在for循环中字符串才能累积拼接
@setlocal enabledelayedexpansion

@ rem ----- 变量声明区


@ rem ----- 程序设计区
:: 切换到操作归档的目录
if exist %docDir% (
	cd %docDir%
	:: 遍历目录，拼接目录参数
	for /D %%v in (*) do (
	set dirs=!dirs! %%v
	)
) else (
	echo %docDir%: 目录不存在!
)

javadoc -d api -public -author -version -docfilessubdirs -splitindex -serialwarn -linksource  -subpackages %docRootPackage%

::javadoc -d api -public -author -version -docfilessubdirs -splitindex -serialwarn -linksource  -subpackages @package.txt


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
