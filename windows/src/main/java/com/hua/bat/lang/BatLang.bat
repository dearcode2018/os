@ rem ----- 信息 -----
@ rem @filename BatLang.bat
@ rem @version 1.0
@ rem @description 
@ rem @author qye.zheng

@ rem @warning 为了防止中文环境乱码，保存文件的时候，应该保存为ANSI编码格式.
@ rem ################################################################################


@ rem 标题
@ title Batch 语言
@ rem ########## begin  ##########

@ rem 关闭显示命令，使所有命令执行前不显示
@ rem @ echo off
@ echo off
@ rem 打开命令显示 @ echo on

:: batch 批处理简述
:: 批处理脚本，是一堆DOS命令按照一定的顺序排列而形成的集合

:: 常用语法
:: 1) rem 注释 或者使用 双冒号(::)
:: 两者区别 
:: A. echo off 关闭回显时，rem 和 :: 后的内容都不会显示 
:: B. echo on 打开回显时，rem后的内容不会显示，:: 仍然不会显示

:: @ 符号: 让后面的命令不显示出来 (屏蔽回显)

:: 2) 暂停 pause
:: 3) 控制台输出 echo
:: 4) 改变流程 goto
:: goto 和 标签(label 标号)
:: 5) 声明变量 set variableName=variableValue  调用变量 %variableName%
:: 6) call 从一个批处理程序中调用另外一个批处理程序，而不会导致调用者终止
:: 调用语法: call filePath [batch-parameters]
:: 7) 传参
:: %[1-9] 表示传入的参数，%0 表示批处理命令本身，参数以空格分隔写在批处理命令后面
:: 8) 标号(label)定义，使用单个冒号加名称，可以定义一个标号，标号所在的行不被执行；标号和goto联用可实现中途的跳转
:: 9) choice
:: choice 使用此命令可以让用户输入一个字符用于选择，从而根据用户的选择返回不同的errorlevel，配合if errorlevel，根据用户
:: 的选择来运行不同的命令
:: 10) %~dp0 表示当前目录(destination path目的路径)
:: 11) 变量没有声明直接使用，值相当于空/空字符串
:: 12) 常用符号
:: / 参数开关引导符
:: % 变量引导符
:: *? 文件通配符
:: | 命令管道符
:: 文件重定向符 < > >>

:: 13) 块 用括号包围起来形成一个整体块

:: 14) 运算符
:: /a 命令行开关 指定右边的字符串被评估为数字表达式(arithmetic expression)
:: = *= /=  += -= %= &= ^= <<= >>=  |= 
:: <> ! ~ -
:: + - * /
:: & | ^(异或)


:: 转义字符 ^ ，用来将特殊字符将为普通字符，
:: 特殊字符: >  < | &
:: 转义 ^> ^< ^| ^&

:: 逻辑命令符
:: 1) & 连接多个命令，顺序执行这些命令，不管命令当中是否有失败
:: 2) && 前面的命令执行成功，后面的命令才会继续执行
:: 3) || 前面的命令执行失败时，后面的命令才会执行 (后面的命令相当于候补)

:: & echo 或许成功 或许失败
:: && echo 成功
:: ||  echo 失败

echo %~dp0

set path=D:\Workspace
if exist %path% (
echo %path% exist 
)
if not exist %path% echo %path% not exist
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


for %%f in (*.bat *.txt) do echo %%f






@ rem ----- 变量声明区


@ rem ----- 程序设计区

@ rem pause

@ rem

@ rem
@ rem 输出提示信息

:: 在程序的末尾，可以根据执行的结果(成功或失败) 给出提示信息，成功可以直接执行exit，而失败
:: 可以执行pause，然后可以通过控制台输出信息来调试、定位问题.
:: 可以在程序中设置一个成功或失败的标志-布尔值，来决定最后程序的执行流程.

@ rem echo
pause
@ rem exit
@ rem ########## end of ##########

@ rem 注释说明: @ rem 注释内容  或者 :: 注释内容 或者 : 注释内容
@ rem rem 或一个/两个冒号 后面 都可以写注释
