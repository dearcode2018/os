@rem ���޸ĵĲ�����Oracle Listener / Instance
@rem ########## begin Windows�� ֹͣ Oracle ������ ##########
@title ֹͣOracle
@rem variable Oracle Instance
set oracleInstance=OracleServiceORCL
@rem variable Oracle Listener
set oracleListener=OracleOraDb11g_home1TNSListener


@rem ֹͣ Oracle Listener
net stop %oracleListener%

@rem ֹͣ Oracle Instance
net stop %oracleInstance%

@rem exit
@exit
@rem ########## end of Windows�� ֹͣ Oracle ������ ##########