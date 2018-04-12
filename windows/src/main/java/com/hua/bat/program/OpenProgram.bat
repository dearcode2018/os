
@rem xx
@title 打开程序
@rem ########## begin  ##########

set notepad=D:\"Program Files"\"Notepad++"\"notepad++.exe"

set myEclipse=D:\"Program Files"\MyEclipse2013\myeclipse.exe

set firefox=C:\"Program Files"\"Mozilla Firefox"\firefox.exe

set qq=C:\"Program Files"\TENCENT\QQ\Bin\QQ.exe

set pdf=D:\我的文档\桌面\JavaScript_gjxcsj3(jb51.net).pdf

set videoDir=E:\FunshionMedia\大明按察使未删减版-MP4

set /a notExistNum=0

@rem

@rem

@rem start %%

@rem start %qq%

if exist %firefox% (start %firefox%) else (%notExistNum%+=1 echo %firefox% not exists)

if exist %pdf% (start %pdf%) else (%notExistNum%+=1 echo %pdf% not exists)

if exist %myEclipse% (start %myEclipse%) else (%notExistNum%+=1 echo %myEclipse% not exists)

if exist %videoDir% (start %videoDir%) else (%notExistNum%+=1 echo %videoDir% not exists)

:: if exist %% (start %%)

if %notExistNum%>0 (pause)

@rem start %%

@rem exit
@exit
@rem ########## end of ##########