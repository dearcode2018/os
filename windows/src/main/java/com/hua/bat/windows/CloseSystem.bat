
@rem xx
@title �ر�ϵͳ
@rem ########## begin  ##########

@rem �����IP��ַ
set vmIp=192.168.5.10
@rem ������ر�ʱ��
set v_t=0
@rem ������ر�ʱ��
set p_t=130

@rem �ر������
shutdown -s -t %v_t% -m \\%vmIp%

@rem �ر������
shutdown -s -t %p_t%

@rem exit
@exit
@rem ########## end of ##########