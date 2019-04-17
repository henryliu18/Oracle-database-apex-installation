# Oracle-database-installation
<b>Software required</b><br />
CentOS Linux release 7.6.1810 (Core)<br />
Oracle database 18.3<br />
Oracle APEX 19.1<br />


Software location<br />
Oracle database 18.3 /tmp/LINUX.X64_180000_db_home.zip<br />
Apex 19c /tmp/apex_19.1_en.zip<br />

Installation<br />
execute 18c_linux_x64.sh as root<br />
execute 18c_netca.sh as oracle<br />
execute 18c_dbca.sh as oracle<br />
execute 19c_apex.sh as oracle<br />

Apex Login page<br />
http://localhost:8080/apex or<br /> 
http://server-ip:8080/apex<br />

Apex admin login<br />
Workspace: internal<br />
User: ADMIN<br />
Password: changeme123<br />

Installation location<br />
Oracle DB:/opt/app/oracle/product/18.0.0/dbhome_1<br />
Oracle Apex:/opt/app/oracle/apex19/apex<br />

DB Instances<br />
CDB1<br />
PDB1<br />

Start service (execute as oracle user)<br />
$ORACLE_HOME/bin/sqlplus / as sysdba << EOF<br />
startup<br />
exit<br />
EOF<br />
$ORACLE_HOME/bin/lsnrctl start<br />

Stop service (execute as oracle user)<br />
$ORACLE_HOME/bin/sqlplus / as sysdba << EOF<br />
shutdown immediate<br />
exit<br />
EOF<br />
$ORACLE_HOME/bin/lsnrctl stop<br />
