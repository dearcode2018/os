@ rem ----- ��Ϣ -----
@ rem @filename MovieFileCopy.bat
@ rem @version 1.0
@ rem @author qye.zheng
@ rem @description ��Ӱ�ļ�����

@ rem @warning Ϊ�˷�ֹ���Ļ������룬�����ļ���ʱ��Ӧ�ñ���ΪANSI�����ʽ.
@ rem ################################################################################


@ rem ����
@ title �ļ�����
@ rem ########## begin  ##########

@ rem �ر���ʾ���ʹ��������ִ��ǰ����ʾ
@ rem @ echo off
@ echo off
@ rem ��������ʾ @ echo on
::@setlocal enabledelayedexpansion
@ rem ----- ����������

:: �û��������� (ִ�п���֮ǰ����ָ��·��)
:: ��ӰĿ¼����
set movieDirName=�����μ�-MP4


set srcRelativePath=FunshionMedia

set srcDirectory=



:: ֧�� 26����ĸ - 26��������
set drivers=A:,B:,C:,D:,E:,F:,G:,H:,I:,J:,K:,L:,M:,N:,O:,P:,Q:,R:,S:,T:,U:,V:,W:,X:,Y:,Z:

set destDriver=

:: Ŀ��Ŀ¼ ��ֵΪnull����Ϊ��ʶ
set destDirectory=null

set destRelativePath=VIDEO

:: Ŀ��Ŀ¼�ĵ�һ���ļ������� (�ļ��淶�����)
set destFirstFileName=null

set begin=OFF

@ rem ----- ���������

:: ɨ���ȡԴĿ¼
for %%v in (%drivers%) do (
	if exist "%%v\%srcRelativePath%\%movieDirName%" (
		set srcDirectory=%%v\%srcRelativePath%\%movieDirName%
		:: ���Ա��ⵯ�� ������Ч �Ի���
		goto finshScanSrc
	)
)

:finshScanSrc

:: �ж�ԴĿ¼�Ƿ����
if not exist %srcDirectory% (
	echo ԴĿ¼: %srcDirectory% ������!
	goto failureEnd
)

set srcDriver=%srcDirectory:~0,2%

:: ɨ���ȡĿ��Ŀ¼
for %%v in (%drivers%) do (
	if exist "%%v\%destRelativePath%" (
		set destDirectory=%%v\%destRelativePath%
		:: ���Ա��ⵯ�� ������Ч �Ի���
		goto finshScanDest
	)
)
:finshScanDest
:: �ж�Ŀ��Ŀ¼�Ƿ����
if not exist %destDirectory% (
	echo Ŀ�����Ŀ¼: %destRelativePath% ������!
	goto failureEnd
)

set destDriver=%destDirectory:~0,2%

%destDriver%
cd "%destDirectory%"

:: ��ȡ��һ������
for /R %%n in (*) do (
	set destFirstFileName=%%n
	goto getFirstName
)
:getFirstName
:: ͨ�����ַ�ʽ���� ��ָ��������ֵ �滻Ϊ ָ����ֵ
call set destFirstFileName=%%destFirstFileName:%destDirectory%=%%
:: ȥ����ͷ�ķ�б��
set destFirstFileName=%destFirstFileName:~1%

:: �������� - ����ؼ�����

:: ����������ƵĿ¼�У�����û�иò���Ӱ�ģ���������������Ӱ�����ʱ��
:: �ṩ���ļ�������ԴĿ¼���޷��ҵ������ʱ�򣬾�Ӧ�ôӵ�һ���ļ���ʼ���������

::
%srcDriver%
:: ����ԴĿ¼
cd "%srcDirectory%"
setlocal enabledelayedexpansion
:copyFor
for /R %%v in (*) do (
	set filename=%%v
	echo !filename!
	call set filename=%%filename:%srcDirectory%=%%
	:: ȥ����ͷ�ķ�б��
	call set filename=!filename:~1!
	if !filename!==!destFirstFileName! (
		set begin=ON
	)
	if "ON"=="!begin!" (
		if not exist "%destDirectory%"\"!filename!" (
			:: ע�⣬·���к��пո������˫��������������Ҳ��batch��� ��˫���Ű�Χ����������ϰ��
			copy /Y "!filename!" "%destDirectory%"
		)
	)
)

if "OFF"=="%begin%" (
	:: û���ҵ�Ŀ�꣬˵����ԴĿ¼�е��ļ���Ŀ��Ŀ¼�ж�������
	:: �������� begin ����
	set begin=ON
	goto copyFor
) else (
	goto successEnd
)

:: �ɹ�ִ�����Ӧ��Խ�� failureEnd ��
:: goto successEnd

::copy /Y  E:\FunshionMedia\�����μ�-MP4\�����μ�-��28��.mp4 G:\VIDEO



::for /R %%v in (.,*) do (
::	echo %%v
::)


:failureEnd
 pause
 
 :successEnd
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
