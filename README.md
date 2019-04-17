# Oracle-database-installation
CentOS Linux release 7.6.1810 (Core)
Oracle database 18.3
Oracle APEX 19.1


Apex URL
http://your-centos-server:8080/apex

Installation location
Oracle DB:/opt/app/oracle/product/18.0.0/dbhome_1
Oracle Apex:/opt/app/oracle/apex19/apex

DB Instances
CDB1
PDB1

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
