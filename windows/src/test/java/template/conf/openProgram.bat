@title openProgram
@rem Win 8 系统中,需要通过 [计算机管理-任务计划程序 以管理员身份调用该脚本]

@rem begin ===== 变量定义 =====
@rem Oracle Listener
@set oracleListener=OracleOraDb11g_home1TNSListener
@set oracleService=OracleServiceORCL

@set notepad=C:\"Program Files (x86)"\"Notepad++"\"notepad++.exe"

@set navicat=C:\"Program Files (x86)"\"Navicat for MySQL"\navicat.exe

@ set sqlManagerForMySql=C:\"Program Files (x86)"\EMS\"SQL Manager Lite for MySQL"\MyManager.exe

@ set chrome=C:\"Program Files (x86)"\Google\Chrome\Application\chrome.exe
@rem 解决跨域问题的启动方式
@rem set chrome=C:\"Program Files (x86)"\Google\Chrome\Application\chrome.exe --disable-web-security

@ set qq=C:\"Program Files (x86)"\Tencent\QQ\QQProtect\Bin\QQProtect.exe

@ set fireFox=C:\"Program Files (x86)"\"Mozilla Firefox\firefox.exe

@set myEclipse=D:\"Program Files"\"MyEclipse Professional 2013"\myeclipse.exe

@set redSkimmer=C:\"Program Files (x86)"\supersoft\Rdfsnap\RdfSnap.exe

@set plsqlDeveloper=D:\"Program Files"\"PLSQL Developer"\plsqldev.exe

@set hiJson=C:\Users\Administrator\Desktop\"HiJson 2.1.2_jdk64.exe"

@set outlook=C:\"Program Files"\"Microsoft Office"\Office15\OUTLOOK.EXE


@rem open document (doc/xlsx/ppt)
@set excelDoc=D:\商品质量监管\"工作计划和进度 Latest.xlsx"

@rem set wordDoc=D:\食品安全\"信誉通食品安全全链路监管系统  商家管理-v1.0.docx"

@set wordDoc=D:\食品安全\"信誉通食品安全监管系统中间层服务接口规范.docx"

@set tempPath=D:\03_Doc\"Lua脚本语言中文教程.pdf"

@rem end of ===== 变量定义 =====


@rem 启动所需内存越大越放在最后

@rem open Notepad
start %notepad%

@rem open Navicat
@rem start %navicat%

@rem open Chrome
@rem start %chrome%

@rem open 红蜻蜓抓图精灵
@rem start %redSkimmer%

@rem open hiJson
start %hiJson%


@rem open outlook
@rem start %outlook%

@rem open excelDoc
@rem start %excelDoc%

@rem open wordDoc
@rem start %wordDoc%

@rem 启动Oracle Service
@rem net start %oracleService%

@rem 启动Oracle Listener
@rem net start %oracleListener%

@rem open plsql developer
@rem start %plsqlDeveloper%

@rem open sqlManagerForMySql
start %sqlManagerForMySql%

@rem tempPath
@rem if exist %tempPath% start %tempPath%

@rem open myEclipse
start %myEclipse%

@rem open qq
start %qq%

@rem open fireFox
start %fireFox%

@exit

















