#!/usr/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
OFF='\033[0m'

ifconfig -a|grep 'inet\|flags'
read -p "Servicable network interface [eth0]: " NIC
NIC=${NIC:-eth0}
ifconfig $NIC
if [ $? -ne 0 ]; then
 echo -e "${RED}$NIC not found, exiting${OFF}"
 exit 1
fi

read -p "Oracle software zip file [/tmp/LINUX.X64_180000_db_home.zip]: " ORACLE_SW
ORACLE_SW=${ORACLE_SW:-/tmp/LINUX.X64_180000_db_home.zip}
if [ ! -f $ORACLE_SW ]; then
 echo -e "${RED}$ORACLE_SW not found, exiting${OFF}"
 exit 1
fi

read -p "Location of Apex zip file [/tmp/apex_19.1_en.zip]: " APEX_SW
APEX_SW=${APEX_SW:-/tmp/apex_19.1_en.zip}
if [ ! -f $APEX_SW ]; then
 echo -e "${RED}$APEX_SW not found, exiting${OFF}"
 exit 1
fi

read -p "Oracle account [oracle]: " O_USER
O_USER=${O_USER:-oracle}

read -p "Oracle account's password [oracle123]: " O_PASS
O_PASS=${O_PASS:-oracle123}

read -p "\$ORACLE_APP_ROOT (The root directory that will hold oracle database and oraInventory binaries) [/opt/app]: " ORACLE_APP_ROOT
ORACLE_APP_ROOT=${ORACLE_APP_ROOT:-/opt/app}

read -p "\$ORACLE_BASE (oracle database root directory) [\$ORACLE_APP_ROOT/oracle]: " ORACLE_BASE
ORACLE_BASE=${ORACLE_BASE:-\$ORACLE_APP_ROOT/oracle}

read -p "\$ORACLE_HOME (oracle database home directory) [\$ORACLE_BASE/product/18.0.0/dbhome_1]: " ORACLE_HOME
ORACLE_HOME=${ORACLE_HOME:-\$ORACLE_BASE/product/18.0.0/dbhome_1}

read -p "Oracle database files directory [/ora/db001]: " ORACLE_DB
ORACLE_DB=${ORACLE_DB:-/ora/db001}

read -p "Location of auto generated script for oracle db softwarae installation [/tmp/inst_ora_sw.sh]: " INST_ORACLE_SW_SHELL
INST_ORACLE_SW_SHELL=${INST_ORACLE_SW_SHELL:-/tmp/inst_ora_sw.sh}

read -p "Location of auto generated script for netca [/tmp/run_netca]: " RUN_NETCA
RUN_NETCA=${RUN_NETCA:-/tmp/run_netca}

read -p "Location of auto generated script for dbca [/tmp/run_dbca]: " RUN_DBCA
RUN_DBCA=${RUN_DBCA:-/tmp/run_dbca}

read -p "Location of oratab [/etc/oratab]: " ORATAB
ORATAB=${ORATAB:-/etc/oratab}

read -p "Location of temporary oratab [/tmp/oratab]: " TMPORATAB
TMPORATAB=${TMPORATAB:-/tmp/oratab}

read -p "Location of Apex sql file for installation [/tmp/inst_apex.sql]: " APEX_SQL
APEX_SQL=${APEX_SQL:-/tmp/inst_apex.sql}

read -p "Location of auto generated script for apex installation [/tmp/run_apex]: " RUN_APEX
RUN_APEX=${RUN_APEX:-/tmp/run_apex}

read -p "\$ORACLE_SID - Database database name or container instance name for apex [cdb1]: " CDB
CDB=${CDB:-cdb1}

read -p "Database container name for apex [pdb1]: " PDB
PDB=${PDB:-pdb1}

read -p "Tablespace name for apex [APEX]: " APEX_TABLESPACE
APEX_TABLESPACE=${APEX_TABLESPACE:-APEX}

read -p "Apex software home [\$ORACLE_BASE/apex19]: " APEX_HOME
APEX_HOME=${APEX_HOME:-\$ORACLE_BASE/apex19}

echo "NIC=${NIC}
O_USER=${O_USER}
O_PASS=${O_PASS}
ORACLE_APP_ROOT=${ORACLE_APP_ROOT}
ORACLE_BASE=${ORACLE_BASE}
ORACLE_HOME=${ORACLE_HOME}
ORACLE_DB=${ORACLE_DB}
ORACLE_SW=${ORACLE_SW}
INST_ORACLE_SW_SHELL=${INST_ORACLE_SW_SHELL}
RUN_NETCA=${RUN_NETCA}
RUN_DBCA=${RUN_DBCA}
ORATAB=${ORATAB}
TMPORATAB=${TMPORATAB}
APEX_SW=${APEX_SW}
APEX_SQL=${APEX_SQL}
RUN_APEX=${RUN_APEX}
PDB=${PDB}
CDB=${CDB}
APEX_TABLESPACE=${APEX_TABLESPACE}
APEX_HOME=${APEX_HOME}" > env

if [ $? -eq 0 ]; then
 echo "***************************************************"
 echo "*** env saved in `pwd`/env                        *"
 echo "***************************************************"
else
 echo "env saved failed";
fi

