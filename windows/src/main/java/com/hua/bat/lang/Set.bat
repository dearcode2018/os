@ rem ----- 信息 -----
@ rem @filename Set.bat
@ rem @version 1.0
@ rem @author qye.zheng
@ rem @description set 命令

@ rem @warning 为了防止中文环境乱码，保存文件的时候，应该保存为ANSI编码格式.
@ rem ################################################################################


@ rem 标题
@ title 
@ rem ########## begin  ##########

@ rem 关闭显示命令，使所有命令执行前不显示
@ rem @ echo off
@ echo off
@ rem 打开命令显示 @ echo on

@ rem ----- 变量声明区

:: set
:: 1) set 显示批处理当前已定义的变量和值
:: 2) set x 显示所有以 x 开头的变量和值
:: 3) 设置变量 set varName=value
:: 4) 使用变量 %varName%
:: 5) 删除变量 set varName=


:: 示例 显示所有的(环境/批处理)变量
set

:: 示例 显示所有以p开头的(环境/批处理)变量
set p

:: 设置值
set var1=abc

:: 使用变量
:: %var1%

:: 删除变量，若该变量存在着删除，不存在则无意义
set var1=
echo %var1%

:: set /a 表示 声明的变量为数值类型
set /a number=12

:: set 表示声明的变量接收一段输入 (以回车结束)
set /p input

@ rem ----- 程序设计区

 pause
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

批处理 在if语句块中使用set的替换功能失败的解决办法

set语句的替换功能如下，可以将时间中的空格换成0 ：
SET T=%time:~0,2% 
SET H=%T: =0% 
echo %H% 
但是在if语句中，SET H=%T: =0% 会发生错误，
if 1==1 (
		SET T=%time:~0,2%
		SET H=%T: =0%
		echo %H%
)

:: 解决方法
set t=%time:~0,2%
需要延迟扩展，就是说这是复合语句中的变量，它之后仍使用之前值，（也就是没赋值）可以在使用if 之前加命令setlocal enabledelayedexpansion
,然后在调用时用一对!! 代一对%%q取量值，见set/?

:: 解决方法2
还可以用另一方法延迟变量扩展：

        SET T=%time:~0,2%
		call SET H=%%T: =0%%
		call echo %%H%%

:: 在程序的末尾，可以根据执行的结果(成功或失败) 给出提示信息，成功可以直接执行exit，而失败
:: 可以执行pause，然后可以通过控制台输出信息来调试、定位问题.
:: 可以在程序中设置一个成功或失败的标志-布尔值，来决定最后程序的执行流程.

@ rem echo
@ rem exit
@ rem ########## end of ##########

@ rem 注释说明: @ rem 注释内容  或者 :: 注释内容
@ rem rem 或两个冒号 后面 都可以写注释
