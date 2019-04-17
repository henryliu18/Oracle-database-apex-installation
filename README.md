# Oracle-database-installation
CentOS Linux release 7.6.1810 (Core)<br />
Oracle database 18.3<br />
Oracle APEX 19.1<br />


Apex URL<br />
http://your-centos-server:8080/apex<br />

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

Start service<br />
$ORACLE_HOME/bin/sqlplus / as sysdba << EOF<br />
startup<br />
exit<br />
EOF<br />
$ORACLE_HOME/bin/lsnrctl start<br />

Stop service<br />
$ORACLE_HOME/bin/sqlplus / as sysdba << EOF<br />
shutdown immediate<br />
exit<br />
EOF<br />
$ORACLE_HOME/bin/lsnrctl stop<br />
