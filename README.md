# Oracle-database-installation
<b>Software required</b><br />
CentOS Linux release 7.6.1810 (Core)<br />
<a href="https://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html">Oracle database 18.3</a><br />
<a href="https://www.oracle.com/database/technologies/appdev/apex.html">Oracle APEX 19.1</a><br />


<b>Software location</b><br />
Oracle database 18.3 /tmp/LINUX.X64_180000_db_home.zip<br />
Apex 19c /tmp/apex_19.1_en.zip<br />

<b>Installation (as root)</b><br />
execute 18c_linux_x64.sh<br />
execute 18c_netca.sh<br />
execute 18c_dbca.sh<br />
execute 19c_apex.sh<br />

<b>Apex Login page</b><br />
http://localhost:8080/apex or<br /> 
http://server-ip:8080/apex<br />

<b>Apex admin login</b><br />
Workspace: internal<br />
User: ADMIN<br />
Password: changeme123<br />

<b>Installation location</b><br />
Oracle DB:/opt/app/oracle/product/18.0.0/dbhome_1<br />
Oracle Apex:/opt/app/oracle/apex19/apex<br />

<b>DB Instances</b><br />
CDB1<br />
PDB1<br />

<b>Start service (execute as oracle user)</b><br />
$ORACLE_HOME/bin/dbstart $ORACLE_HOME<br />

<b>Stop service (execute as oracle user)</b><br />
$ORACLE_HOME/bin/dbshut $ORACLE_HOME<br />
