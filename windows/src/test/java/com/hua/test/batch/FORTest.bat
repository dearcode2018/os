@ rem ----- 信息 -----
@ rem @filename FORTest.bat
@ rem @version 1.0
@ rem @author qye.zheng
@ rem @description for循环测试

@ rem @warning 为了防止中文环境乱码，保存文件的时候，应该保存为ANSI编码格式.
@ rem ################################################################################


@ rem 标题
@ title 
@ rem ########## begin  ##########

@ rem 关闭显示命令，使所有命令执行前不显示
@ rem @ echo off
echo off
@ rem 打开命令显示 @ echo on

::for /F ["options"] %%s in (set) do (循环体)
:: set 为 "string" / 'command' / file-set
:: options 是 eol=c、skip=n、delims=xxx、tokens=x,y,m-n、usebackq）中的一个或多个的组合
:: 使用最多的options 是 skip / tokens / delims

:: set str="1,23,3,4,10"
:: for /F
:: for /F "tokens=1-3 delims=," %%a in (%str%) do (echo %%a %%b %%c)

:: 输出当前目录下的文件
::for /F "tokens=3* delims= " %%a in ('dir') do (
	::if not "<DIR>"=="%%a" if not "字节"=="%%b" if not "可用字节"=="%%c" echo %%b
::) 


:: /D / R
:: for /D %%d in (.) do (
:: 	echo %%d
:: )
@ echo on
:: 字母迭代 A -- E (不支持 字母 方式的递增)
:: for /L %%d in (A,1,E) do (
:: 	echo %%d
:: )

:: 支持 15个磁盘驱动器
set drivers=A,B,C,D,E,F,G,H,I,J,K,L,M,N,O
set drivers=C:
set targetPath=
for %%d in (%drivers%) do (
	if exist %%d\Oracle (
		%%d
		cd %%d\Oracle
		:: 进入之后，遍历其下的所有子目录
		for /D %%v in (*) do (
			cd %%v
			dir .
		)
	)
)

@ rem ----- 变量声明区


@ rem ----- 程序设计区
@ pause
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
