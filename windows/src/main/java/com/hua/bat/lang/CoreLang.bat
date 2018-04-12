@ rem ----- 信息 -----
@ rem @filename CoreLang.bat
@ rem @version 1.0
@ rem @description 核心
@ rem @author qye.zheng

@ rem @warning 为了防止中文环境乱码，保存文件的时候，应该保存为ANSI编码格式.
@ rem ################################################################################


@ rem 标题
@ title CoreLang
@ rem ########## begin  ##########

@ rem 关闭显示命令，使所有命令执行前不显示
@ rem @ echo off
echo off
@ rem 打开命令显示 @ echo on

:: choice /c ync /m "确认请按 Y，否请按 N，或者取消请按 C。" 
:: （注意，用if errorlevel判断返回值时，要按返回值从高到低排列）: 
:: if errorlevel 3 go cancel
:: if errorlevel 2 go no
:: if errorlevel 1 go yes

:: 输出用户选择的值 (1/2/3)
:: echo %errorlevel%

:: :yes
:: echo yes
:: :no
:: echo no
:cancel
:: echo cancel
@ rem ----- 变量声明区


@ rem ----- 程序设计区

@ rem pause

@ rem

@ rem
@ rem 输出提示信息

:: 控制流程
:: 1) if - 分支语句
:: if variableName=="参数值" [待执行的命令]  例如 if not ""=="%variableName%"
:: if not variableName=="参数值" [待执行的命令]
:: 判断文件、目录是否存在
:: if [not] exist pathVariable [待执行的命令]
:: if errorlevel 数字 [待执行的命令]
:: 2) 





:: 3) 循环语句
:: for %%variableName in (set集合) do 命令 [参数]
:: for %%v in (1 2 3 4 5 6 7) do 命令
:: 注意 %%后的循环变量的命名只能是单个字母
:: 开关/L的循环 数值从 start 开始，步进是step，最后一个值不能超过end
:: for /L %%variable in (start, step, end) do 命令

:: 开关 /F的循环，可以对字符串进行操作，也能够对命令的返回值进行操作
:: set 可以是"string"、'command'、file-set
:: options是（eol=c、skip=n、delims=xxx、tokens=x,y,m-n、usebackq）中的一个或多个的组合
:: for /F ["options"] %%variable in (set)

:: 4)
:: 5)
:: 6)
:: 7)
:: 8)
:: 9)
:: 10)

:: for %%n in (1 2 3 4 5 6 7) do echo %%n

for /L %%i in (1, 2, 8) do echo %%i

::: echo %random%

:: 在程序的末尾，可以根据执行的结果(成功或失败) 给出提示信息，成功可以直接执行exit，而失败
:: 可以执行pause，然后可以通过控制台输出信息来调试、定位问题.
:: 可以在程序中设置一个成功或失败的标志-布尔值，来决定最后程序的执行流程.



:: 相当于 return / ref
goto :eof


@ rem echo
pause
@ rem exit
@ rem ########## end of ##########

@ rem 注释说明: @ rem 注释内容  或者 :: 注释内容
@ rem rem 或一个/两个冒号 后面 都可以写注释
