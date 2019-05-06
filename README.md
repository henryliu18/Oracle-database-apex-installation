# Oracle-database-installation
<b>Software required</b><br />
CentOS Linux release 7.6.1810 (Core)<br />
<a href="https://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html">Oracle database 18.3</a><br />
<a href="https://www.oracle.com/database/technologies/appdev/apex.html">Oracle APEX 19.1</a><br />


<b>Software zip files location</b><br />
Oracle database 18.3 is defined in env $ORACLE_SW<br />
Apex 19c is defined in env $APEX_SW<br />

<b>Installation (as root)</b><br />
setup [env|sw|db|apex|all|clean]<br />

<b>Apex Login page</b><br />
http://localhost:8080/apex or<br /> 
http://server-ip:8080/apex<br />

<b>Apex admin login</b><br />
Workspace: internal<br />
User: ADMIN<br />
Password: changeme123<br />

<b>Installation location</b><br />
Oracle database software is defined in env $ORACLE_HOME<br />
Oracle Apex is defined in env $APEX_HOME<br />

<b>DB Instances</b><br />
Defined in env $CDB<br />
Defined in env $PDB<br />

<b>Start service (execute as oracle user)</b><br />
$ORACLE_HOME/bin/dbstart $ORACLE_HOME<br />

<b>Stop service (execute as oracle user)</b><br />
$ORACLE_HOME/bin/dbshut $ORACLE_HOME<br />
