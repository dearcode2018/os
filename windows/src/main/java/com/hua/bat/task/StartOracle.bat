@rem ���޸ĵĲ�����Oracle Listener / Instance
@rem ########## begin Windows�� ���� Oracle ������ ##########
@title ����Oracle
@rem variable Oracle Instance
set oracleInstance=OracleServiceORCL
@rem variable Oracle Listener
set oracleListener=OracleOraDb11g_home1TNSListener


@rem ���� Oracle Instance
net start %oracleInstance%

@rem ���� Oracle Listener
net start %oracleListener%

@rem exit
@exit
@rem ########## end of Windows�� ���� Oracle ������##########