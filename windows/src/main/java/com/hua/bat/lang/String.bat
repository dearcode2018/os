@ rem ----- 信息 -----
@ rem @filename String.bat
@ rem @version 1.0
@ rem @description 字符串
@ rem @author qye.zheng

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
:: 字符串
:: 1) 下标从0开始
:: 2)  为了防止字符串常量中含有字符串，不能被视为整体
:: 因此需要用双引号把字符串常量包围起来，相应地在比较
:: 的时候，也需要把字符串变量用双引号包围起来，例如 "abc"=="%strVar%"
::

set str1=abc
set str2=def
::字符串拼接
set str1=%str1%%str2%
:: 可以拼接字符串常量
set str1=%str1%joinString

::输出字符串值
echo %str1%

:: 字符串截取
set str3=good morning
:: 1) 1个参数 从起始参数到末尾 %strVar:~startIndex%；负数则表示最后n个字符 例如 %strVar:~-5% 截取最后5个字符
:: 2) 2个参数 从起始参数截取指定的长度 %strVar:~startIndex,length% 负数则表示从倒数第几个字符开始截取多少个字符
echo %str3:~1%
echo %str3:~0,3%

:: 截取时间字符串
::echo 当前时间是：%time% 即 %time:~0,2%点%time:~3,2%分%time:~6,2%秒%time:~9,2%厘秒

:: 获取指定位置的字符 index
:: %strVar:~startIndex,1%
:: 获取下标是2的字符
echo %str3:2,1%

:: 字符串替换 (根据字符串相等性 进行替换)
:: 替换示例
set strReplace=abyyab
::执行替换
set strReplace=%strReplace:ab=AB%
::替换后变成 AByyAB
echo %strReplace%

:: 通过这种方式可以 将指定变量的值 替换为 指定的值
call set var=%%var:%replaceVar%=replaceValue%%

:: 扩充字符串
:: 不是所有变量都支持扩充，要满足2个条件
:: 1) 该字符串表示一个文件路径 2) 变量用 %x表示，x 可取a-z A-Z 0-9共62个字符中的任意一






:: 启动此功能，在for循环中字符串才能累积拼接
@setlocal enabledelayedexpansion
@set classpath=.
@for %%c in (a,b,c) do @set classpath=!classpath!;%%c
@set classpath=%classpath%;./bin;
@echo %classpath%





set str4=welcome to earth
set length=0
set string=%str4%

:stringLength
if not ""=="%string%" (
:: 长度值自增1 /a 让值累加
set /a length+=1
:: 截取字符串(从1开始到末尾)
set string=%string:~1%
:: 循环调用
goto stringLength
)

echo %length%


set str5=how do you do
set targetChar=n
:: 拷贝字符串，不影响源字符串
set findChar=%str5%
set index=0

:findCharAt
if ""=="%findChar%" (
:: 没有找到
set index=-1
:: 直接跳到结束位置
goto findChartLast
)
if not "%findChar:~0,1%"=="%targetChar%" (
set findChar=%findChar:~1%
:: 索引值自增
set /a index+=1
goto findCharAt
)
:: 输出结果值
:findChartLast
echo %index%

@ rem ----- 程序设计区



@ rem pause

@ rem

@ rem
@ rem 输出提示信息

:: 字符串
:: 1) 字符串 - 拼接
:: set str1=strValue
:: set str1=%str1%%str2%
:: 2) 字符串 - 截取
:: set str=%srcString:~起始下标(从0开始), 截取长度%， 仅指定一个参数，类似于substring(int startIndex) 效果
:: 3) 字符串长度
:: 使用goto构成一个循环语句，不断截取字符串的长度来计算其长度
:: 
:: 4) 单个字符的索引 findChart(char)
:: 通过goto不断循环 截取第一个字符和目标字符比较，若相等则输出索引的位置，若没找到则返回-1
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
pause
@ rem exit
@ rem ########## end of ##########

@ rem 注释说明: @ rem 注释内容  或者 :: 注释内容
@ rem rem 或两个冒号 后面 都可以写注释
