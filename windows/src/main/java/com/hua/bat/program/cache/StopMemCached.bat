@rem title
@title stop memcached Server
@rem ########## begin stop memcached Server ##########
@rem call %cd%\common.bat
@rem %~dp0 is varibable of bat file self
@rem cd bat file path
cd %~dp0
@rem call common
call common.bat

@rem  enter disk driver, cd can not  come true
%diskDriver%
@rem enter memcached  home directory
cd %MEMCACHED_HOME%

@rem stopServer
memcached.exe -d stop

@rem exit
@exit
@rem ########## end of stop memcached Server ##########
