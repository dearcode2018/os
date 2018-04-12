@ rem ----- 信息 -----
@ rem @filename MovieFileCopy.bat
@ rem @version 1.0
@ rem @author qye.zheng
@ rem @description 电影文件拷贝

@ rem @warning 为了防止中文环境乱码，保存文件的时候，应该保存为ANSI编码格式.
@ rem ################################################################################


@ rem 标题
@ title 文件拷贝
@ rem ########## begin  ##########

@ rem 关闭显示命令，使所有命令执行前不显示
@ rem @ echo off
@ echo off
@ rem 打开命令显示 @ echo on
::@setlocal enabledelayedexpansion
@ rem ----- 变量声明区

:: 用户变量设置 (执行拷贝之前，先指定路径)
:: 电影目录名称
set movieDirName=新西游记-MP4


set srcRelativePath=FunshionMedia

set srcDirectory=



:: 支持 26个字母 - 26个驱动器
set drivers=A:,B:,C:,D:,E:,F:,G:,H:,I:,J:,K:,L:,M:,N:,O:,P:,Q:,R:,S:,T:,U:,V:,W:,X:,Y:,Z:

set destDriver=

:: 目的目录 赋值为null，作为标识
set destDirectory=null

set destRelativePath=VIDEO

:: 目的目录的第一个文件的名称 (文件规范排序的)
set destFirstFileName=null

set begin=OFF

@ rem ----- 程序设计区

:: 扫描获取源目录
for %%v in (%drivers%) do (
	if exist "%%v\%srcRelativePath%\%movieDirName%" (
		set srcDirectory=%%v\%srcRelativePath%\%movieDirName%
		:: 可以避免弹出 驱动无效 对话框
		goto finshScanSrc
	)
)

:finshScanSrc

:: 判断源目录是否存在
if not exist %srcDirectory% (
	echo 源目录: %srcDirectory% 不存在!
	goto failureEnd
)

set srcDriver=%srcDirectory:~0,2%

:: 扫描获取目的目录
for %%v in (%drivers%) do (
	if exist "%%v\%destRelativePath%" (
		set destDirectory=%%v\%destRelativePath%
		:: 可以避免弹出 驱动无效 对话框
		goto finshScanDest
	)
)
:finshScanDest
:: 判断目的目录是否存在
if not exist %destDirectory% (
	echo 目的相对目录: %destRelativePath% 不存在!
	goto failureEnd
)

set destDriver=%destDirectory:~0,2%

%destDriver%
cd "%destDirectory%"

:: 获取第一个名称
for /R %%n in (*) do (
	set destFirstFileName=%%n
	goto getFirstName
)
:getFirstName
:: 通过这种方式可以 将指定变量的值 替换为 指定的值
call set destFirstFileName=%%destFirstFileName:%destDirectory%=%%
:: 去除开头的反斜杠
set destFirstFileName=%destFirstFileName:~1%

:: 参数正常 - 程序关键部分

:: 播放器的视频目录中，可能没有该部电影的，但是有其他部电影，这个时候
:: 提供的文件名，在源目录中无法找到，这个时候，就应该从第一个文件开始，逐个拷贝

::
%srcDriver%
:: 进入源目录
cd "%srcDirectory%"
setlocal enabledelayedexpansion
:copyFor
for /R %%v in (*) do (
	set filename=%%v
	echo !filename!
	call set filename=%%filename:%srcDirectory%=%%
	:: 去除开头的反斜杠
	call set filename=!filename:~1!
	if !filename!==!destFirstFileName! (
		set begin=ON
	)
	if "ON"=="!begin!" (
		if not exist "%destDirectory%"\"!filename!" (
			:: 注意，路径中含有空格必须用双引号括起来，这也是batch编程 用双引号包围起来的良好习惯
			copy /Y "!filename!" "%destDirectory%"
		)
	)
)

if "OFF"=="%begin%" (
	:: 没有找到目标，说明，源目录中的文件在目标目录中都不存在
	:: 主动设置 begin 变量
	set begin=ON
	goto copyFor
) else (
	goto successEnd
)

:: 成功执行完后，应该越过 failureEnd 块
:: goto successEnd

::copy /Y  E:\FunshionMedia\新西游记-MP4\新西游记-第28集.mp4 G:\VIDEO



::for /R %%v in (.,*) do (
::	echo %%v
::)


:failureEnd
 pause
 
 :successEnd
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
