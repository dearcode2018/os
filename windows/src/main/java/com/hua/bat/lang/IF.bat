@ rem ----- 信息 -----
@ rem @filename IF.bat
@ rem @version 1.0
@ rem @author qye.zheng
@ rem @description if分支语句

@ rem @warning 为了防止中文环境乱码，保存文件的时候，应该保存为ANSI编码格式.
@ rem ################################################################################


@ rem 标题
@ title 
@ rem ########## begin  ##########

@ rem 关闭显示命令，使所有命令执行前不显示
@ rem @ echo off
echo off
@ rem 打开命令显示 @ echo on
:: 控制流程
:: 1) if - 分支语句
:: if variableName=="参数值" [待执行的命令]  例如 if not ""=="%variableName%"
:: if not variableName=="参数值" [待执行的命令]
:: 判断文件、目录是否存在
:: if [not] exist pathVariable [待执行的命令]
:: if errorlevel 数字 [待执行的命令]

:: lss - 小于， leq - 小于等于，gtr - 大于，geq - 大于等于 (不能直接使用类型 >= 的符号) 

:: 判断变量是否已经存在
if [not] defined variableName () 

:: 结果判断
if errorlevle  数字() else if  ()

:: if 模板
if [not] [defined | exist | errorlevel | ==] (
	:: 
) else if [not] [defined | exist | errorlevel | ==] (
	::
) else if [not] [defined | exist | errorlevel | ==](
	::
) else (
	::
)

:: if 语句示例
set path1=C:\abc

set path2=C:\WINDOWS

if exist %path1% (
	echo %path1% exist!
) else if exist %path2% (
	echo %path2% exist!
) else (
	echo %path1% and %path2% both not exist!
)

set value=abc
if "abc"=="%value%" (
	echo true
) else (
	::
	echo false
)

@ rem ----- 变量声明区


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
