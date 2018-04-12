@ rem ----- 信息 -----
@ rem @filename Mp5Cleaner.bat
@ rem @version 1.0
@ rem @author qye.zheng
@ rem @description 播放器 - 清理器

@ rem @warning 为了防止中文环境乱码，保存文件的时候，应该保存为ANSI编码格式.
@ rem ################################################################################


@ rem 标题
@ title 播放器 - 清理器
@ rem ########## begin  ##########

:: 隐藏文件不能直接用del删除，需要先取消其隐藏属性.
:: 取消隐藏 attrib -H  (其他属性 R-只读，A-存档，S-系统文件) + 设置属性，-清除属性
:: 删除文件 del 文件名
:: attrib  /D 也处理文件夹
:: attrib /S 处理当前目录及其子目录的匹配文件

@ rem 关闭显示命令，使所有命令执行前不显示
@ rem @ echo off
@ echo off
@ rem 打开命令显示 @ echo on

@ rem ----- 变量声明区

set videoDir=VIDEO

set pictureDir=PICTURES

@ rem ----- 程序设计区

cd %videoDir%
:: 清除隐藏属性
attrib -H *.thb
:: 删除 thb 文件
del *.thb

cd ..

cd %pictureDir%
:: 清除隐藏属性
attrib -H *.thb
:: 删除 thb 文件
del *.thb

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
