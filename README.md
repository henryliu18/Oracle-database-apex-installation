# Oracle-database-installation
CentOS Linux release 7.6.1810 (Core)
Oracle database 18.3
Oracle APEX 19.1


Apex URL<br />
http://your-centos-server:8080/apex<br />

Installation location<br />
Oracle DB:/opt/app/oracle/product/18.0.0/dbhome_1<br />
Oracle Apex:/opt/app/oracle/apex19/apex<br />

DB Instances<br />
CDB1<br />
PDB1<br />

Start service
$ORACLE_HOME/bin/sqlplus / as sysdba << EOF
startup
exit
EOF
$ORACLE_HOME/bin/lsnrctl start

Stop service
$ORACLE_HOME/bin/sqlplus / as sysdba << EOF
shutdown immediate
exit
EOF
$ORACLE_HOME/bin/lsnrctl stop
