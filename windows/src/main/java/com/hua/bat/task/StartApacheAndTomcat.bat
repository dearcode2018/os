@rem xx
@title 启动 Apache 2.2 与 Tomcat 7
@rem ########## begin  ##########

@rem 启动 Tomcat01 currentPort = 8001
net start tomcat01

@rem 启动 Tomcat10 currentPort = 8010
net start tomcat10

@rem 启动 apache currentPort = 8088
net start apache2.2

@rem exit
@exit
@rem ########## end of ##########