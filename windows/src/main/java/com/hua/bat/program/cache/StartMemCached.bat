@rem title
@title start memcached Server
@rem ########## begin start memcached Server ##########
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

@rem IP Address (localhost is default)
set ipAddr=127.0.0.1

@rem port number
set port=1234

@rem distribute memory  (unit : M)
set distributeMem=32

@rem startServer
memcached.exe -l %ipAddr% -m %distributeMem% -d start

@rem pause

@rem exit
@exit
@rem ########## end of start memcached Server ##########
