@rem title
@title stop memcached Server
@rem ########## begin stop memcached Server ##########
@rem call %cd%\common.bat
@rem %~dp0 is varibable of bat file self
@rem cd bat file path
set baseDir=%~dp0
@rem 读取当前文件所在路径的前2个字符
set baseDir=%baseDir:~0,2%
@rem 进入其他盘 (C: 或 D: 2个字符即可)
%baseDir%

@rem 在此盘中执行 cd命令
cd %~dp0
@rem call common
call common.bat

@rem  enter disk driver, cd can not  come true
%diskDriver%
@rem enter memcached  home directory
cd %MEMCACHED_HOME%

@rem stopServer
memcached.exe -d stop

@rem pause

@rem exit
@exit
@rem ########## end of stop memcached Server ##########
