@title start db2 service

@rem start db2 service
@rem begin ===== �������� =====
set s1=DB2-0

set ntsec=DB2NTSECSERVER_DB2COPY1

set mgmt=DB2MGMTSVC_DB2COPY1

set remotecmd=DB2REMOTECMD_DB2COPY1
@rem end of ===== �������� =====

net start %s1%

net start %ntsec%

net start %mgmt%

net start %remotecmd%





