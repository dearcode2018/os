@ rem ----- 信息 -----
@ rem @filename FOR.bat
@ rem @version 1.0
@ rem @author qye.zheng
@ rem @description for循环

@ rem @warning 为了防止中文环境乱码，保存文件的时候，应该保存为ANSI编码格式.
@ rem ################################################################################


@ rem 标题
@ title 
@ rem ########## begin  ##########

@ rem 关闭显示命令，使所有命令执行前不显示
@ rem @ echo off
@ echo off
@ rem 打开命令显示 @ echo on

:: 循环语句
:: 循环变量只能是单个字母
:: 1) 无开关
for %%v in (set) do (循环体)
:: 示例
for %%i in (a, 1, c, 4) do (echo %%i)

:: 2) 开关 /L
:: 可以根据set里面的设置进行循环，从而实现对循环次数的控制
:: 当 end < start 时，step需设置为负数；不能超过end值
for /L %%t in (start,step,end) do (循环体)

:: 示例 (从1开始，以5为步进，结束值是20，最后一次步进不能超过结束值)
for /L %%t in(1,5,20) do (循环体)
:: 步进为负数
for /L %%t in(20,-5,1) do (循环体)

:: 开关 /L 的循环一般用来实现次数控制的业务

:: 3) 开关 /F
:: 开关/F可以对字符串、命令的返回值进行操作，还可以访问磁盘上的ASCII文件，例如txt文档等.
for /F ["options"] %%s in (set) do (循环体)
:: set 为 "string" / 'command' / file-set
:: options 是 eol=c、skip=n、delims=xxx、tokens=x,y,m-n、usebackq）中的一个或多个的组合
:: 使用最多的options 是 skip / tokens / delims
:: 使用tokens=3 循环变量从a 开始, %%a  %%b  %%c

:: 输出当前目录下的文件 (从第三列开始到最后 tokens=3*)
for /F "tokens=3* delims= " %%a in ('dir') do (
	if not "<DIR>"=="%%a" if not "字节"=="%%b" if not "可用字节"=="%%c" echo %%b
	
	:: 输出具体的信息就知道 a/b/c 个代表什么
	echo %%a
	echo %%b
	echo %%c
	
) 
:: dir 输出的完整信息 ，没有经过for循环筛选
2014-11-15  10:37             		4,740 funshion.ini
2012-01-16  19:08                 	0 FunshionServic
2011-10-01  14:55    <DIR>        My Documents
2014-11-14  23:20       				18,350,080 NTUSER.DAT
2014-11-15  10:38            			24,576 ntuser.dat.LOG
2014-02-06  14:37                		 0 ntuserdirect_d
2014-01-27  19:11            			25,665 ntuserdirect_M
2013-04-18  22:18    <DIR>          Oracle
2013-02-13  16:42                 	0 path
2014-03-28  23:02    <DIR>          PMT
2013-10-06  13:13               			16 point.sql
2014-08-31  14:13           				540,293 servlet.jar
2011-09-02  12:42    <DIR>          WINDOWS
2014-07-15  20:04                 		0 _backup
2014-03-18  20:18    <DIR>         「开始」菜单
2013-07-20  13:05    <DIR>          我的文档
2014-10-31  19:10    <DIR>          桌面
22 个文件    101,155,868              字节
19 个目录 26,354,360,320       可用字节

:: 4) 开关 /R (recursive 递归列出所有目录)
:: 与查找文件或目录有关

:: 5) 开关 /D (只列出当前一级目录)
:: 与查找文件或目录有关 (* 表示当前目录下的所有一级目录)
for /D %%v in (*) do (
	echo %%v
)
:: for %%variableName in (set集合) do 命令 [参数]
:: for %%v in (1 2 3 4 5 6 7) do 命令
:: 注意 %%后的循环变量的命名只能是单个字母
:: 开关/L的循环 数值从 start 开始，步进是step，最后一个值不能超过end
:: for /L %%variable in (start, step, end) do 命令

:: 开关 /F的循环，可以对字符串进行操作，也能够对命令的返回值进行操作
:: set 可以是"string"、'command'、file-set
:: options是（eol=c、skip=n、delims=xxx、tokens=x,y,m-n、usebackq）中的一个或多个的组合
:: for /F ["options"] %%variable in (set)


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
