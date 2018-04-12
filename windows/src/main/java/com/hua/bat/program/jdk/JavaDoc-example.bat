@ rem ----- 信息 -----
@ rem @filename x.bat
@ rem @version 1.0
@ rem @author qye.zheng
@ rem @description 

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


@ rem ----- 程序设计区

javadoc -author -version -docfilessubdirs -splitindex -serialwarn -linksource -sourcepath  %dirs%


javadoc -public -author -version -docfilessubdirs -splitindex -serialwarn -linksource -sourcepath com -subpackages com.google.gson.util.CalendarUnit.java

javadoc -d api -public -author -version -docfilessubdirs -splitindex -serialwarn -linksource -sourcepath com -subpackages com.google.gson.util sourcefiles com/google/gson/util/*.java


javadoc -d api -public -author -version -docfilessubdirs -splitindex -serialwarn -linksource -sourcepath com -subpackages com.google.gson.util sourcefiles com/google/gson/util/*

javadoc -d api -public -author -version -docfilessubdirs -splitindex -serialwarn -linksource -sourcepath com -subpackages com.google.gson sourcefiles com/google/gson/*.*

javadoc -d api -public -author -version -docfilessubdirs -splitindex -serialwarn -linksource  -subpackages com.google.gson sourcefiles com/google/gson/*.*


javadoc -d api -public -author -version -docfilessubdirs -splitindex -serialwarn -linksource  -subpackages com.google.gson com.google.gson.util sourcefiles       com/google/gson/util/*.* com/google/gson/*.* 

javadoc -d api -public -author -version -docfilessubdirs -splitindex -serialwarn -linksource  -subpackages com.google.gson.abc com.google.gson com.google.gson.util sourcefiles       com/google/gson/util/*.* com/google/gson/*.* com/google/gson/abc/*.*




javadoc -d api -public -author -version -docfilessubdirs -splitindex -serialwarn -linksource  -subpackages @package.txt sourcefiles @sourcesFile.txt

javadoc -d api -public -author -version -docfilessubdirs -splitindex -serialwarn -linksource  -subpackages @package.txt


javadoc -d api -public -author -version -docfilessubdirs -splitindex -serialwarn -linksource com.google.gson.util

javadoc -d api -public -author -version -docfilessubdirs -splitindex -serialwarn -linksource -sourcepath com -subpackages com.google.gson.util sourcefiles com











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

:: 在程序的末尾，可以根据执行的结果(成功或失败) 给出提示信息，成功可以直接执行exit，而失败
:: 可以执行pause，然后可以通过控制台输出信息来调试、定位问题.
:: 可以在程序中设置一个成功或失败的标志-布尔值，来决定最后程序的执行流程.

@ rem echo
@ rem exit
@ rem ########## end of ##########

@ rem 注释说明: @ rem 注释内容  或者 :: 注释内容
@ rem rem 或两个冒号 后面 都可以写注释
