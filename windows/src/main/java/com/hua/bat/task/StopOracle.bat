@rem 可修改的参数：Oracle Listener / Instance
@rem ########## begin Windows下 停止 Oracle 服务器 ##########
@title 停止Oracle
@rem variable Oracle Instance
set oracleInstance=OracleServiceORCL
@rem variable Oracle Listener
set oracleListener=OracleOraDb11g_home1TNSListener


@rem 停止 Oracle Listener
net stop %oracleListener%

@rem 停止 Oracle Instance
net stop %oracleInstance%

@rem exit
@exit
@rem ########## end of Windows下 停止 Oracle 服务器 ##########