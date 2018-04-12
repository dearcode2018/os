@ rem ----- 信息 -----
@ rem @filename FunshionCleaner.bat
@ rem @version 1.0
@ rem @author qye.zheng
@ rem @description 风行电影 - 清理器

@ rem @warning 为了防止中文环境乱码，保存文件的时候，应该保存为ANSI编码格式.
@ rem ################################################################################


@ rem 标题
@ title 风行电影 - 清理器
@ rem ########## begin  ##########

@ rem 关闭显示命令，使所有命令执行前不显示
@ rem @ echo off
@ echo off
@ rem 打开命令显示 @ echo on
@ echo on
@ rem ----- 变量声明区
:: 支持 15个磁盘驱动器
set drivers=A:,B:,C:,D:,E:,F:,G:,H:,I:,J:,K:,L:,M:,N:,O:

set funsionBasePath=C:\"Documents and Settings"\Administrator\funshion\base

:: 安静方式删除树目录
rd /S /Q %funsionBasePath%

:: 测试用参数
::set drivers=D:

:: 风行电影 在各个驱动器的相对路径
set relativePath=FunshionMedia

::set deleteTarget=*.dat

for %%d in (%drivers%) do (
	if exist %%d\%relativePath% (
		:: 路径存在，则进入指定的驱动器
		%%d
		:: 进入所在的目录
		cd %%d\%relativePath%
		:: 进入之后，遍历其下的所有子目录
		for /D %%v in (*) do (
			cd %%v
			:: 将 *.dat 文件列出来
			dir *.dat
			:: 删除 其下所有的 *.dat 文件
			del *.dat
			:: 一定要返回上级目录 才能继续循环遍历目录
			cd ..
		)
	)
)
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
