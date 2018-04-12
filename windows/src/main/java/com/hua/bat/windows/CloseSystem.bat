
@rem xx
@title 关闭系统
@rem ########## begin  ##########

@rem 虚拟机IP地址
set vmIp=192.168.5.10
@rem 虚拟机关闭时间
set v_t=0
@rem 物理机关闭时间
set p_t=130

@rem 关闭虚拟机
shutdown -s -t %v_t% -m \\%vmIp%

@rem 关闭物理机
shutdown -s -t %p_t%

@rem exit
@exit
@rem ########## end of ##########