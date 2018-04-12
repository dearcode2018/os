@rem 可修改的参数：Oracle Listener / Instance
@rem ########## begin Windows下 启动 Oracle 服务器 ##########
@title 启动Oracle
@rem variable Oracle Instance
set oracleInstance=OracleServiceORCL
@rem variable Oracle Listener
set oracleListener=OracleOraDb11g_home1TNSListener


@rem 启动 Oracle Instance
net start %oracleInstance%

@rem 启动 Oracle Listener
net start %oracleListener%

@rem exit
@exit
@rem ########## end of Windows下 启动 Oracle 服务器##########