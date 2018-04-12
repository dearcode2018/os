@ rem ----- 信息 -----
@ rem @filename StringTest.bat
@ rem @version 1.0
@ rem @author qye.zheng
@ rem @description 字符串测试

@ rem @warning 为了防止中文环境乱码，保存文件的时候，应该保存为ANSI编码格式.
@ rem ################################################################################


@ rem 标题
@ title 
@ rem ########## begin  ##########

@ rem 关闭显示命令，使所有命令执行前不显示
@ rem @ echo off
echo off
@ rem 打开命令显示 @ echo on

@ rem ----- 变量声明区

set str1=welcome to batch!

:: 字符串变量 和 常量 拼接
set str1=%str1%join

echo %str1%
echo %str1:~1%
echo %str1:~1,3%
echo %str1:~3,1%

echo 当前时间是：%time% 即 %time:~0,2%点%time:~3,2%分%time:~6,2%秒%time:~9,2%厘秒
:: echo 当前时间是：%time% 即 %time:~0,2%点%time:~3,2%分%time:~6,2%秒%time:~9,2%厘秒

set strReplace=abbcab
::执行替换
set strReplace=%strReplace:ab=AB%
echo %strReplace%


:: 扩充字符串
set path=C:\Program Files
:: %~fl
::eho %~fl
::for %%i in (%path%) do (echo %~l)



@ rem ----- 程序设计区

@ rem pause
pause
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
