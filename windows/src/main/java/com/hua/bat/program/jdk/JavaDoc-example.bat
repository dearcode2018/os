@ rem ----- ��Ϣ -----
@ rem @filename x.bat
@ rem @version 1.0
@ rem @author qye.zheng
@ rem @description 

@ rem @warning Ϊ�˷�ֹ���Ļ������룬�����ļ���ʱ��Ӧ�ñ���ΪANSI�����ʽ.
@ rem ################################################################################



@ rem ����
@ title 
@ rem ########## begin  ##########

@ rem �ر���ʾ���ʹ��������ִ��ǰ����ʾ
@ rem @ echo off
@ echo off
@ rem ��������ʾ @ echo on

@ rem ----- ����������


@ rem ----- ���������

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
@ rem �����ʾ��Ϣ

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

:: �ڳ����ĩβ�����Ը���ִ�еĽ��(�ɹ���ʧ��) ������ʾ��Ϣ���ɹ�����ֱ��ִ��exit����ʧ��
:: ����ִ��pause��Ȼ�����ͨ������̨�����Ϣ�����ԡ���λ����.
:: �����ڳ���������һ���ɹ���ʧ�ܵı�־-����ֵ���������������ִ������.

@ rem echo
@ rem exit
@ rem ########## end of ##########

@ rem ע��˵��: @ rem ע������  ���� :: ע������
@ rem rem ������ð�� ���� ������дע��
