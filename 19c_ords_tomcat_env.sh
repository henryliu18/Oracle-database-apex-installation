#!/usr/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
OFF='\033[0m'

read -p "Tomcat zip file [/tmp/apache-tomcat-9.0.19.zip]: " TOMCAT_ZIP
TOMCAT_ZIP=${TOMCAT_ZIP:-/tmp/apache-tomcat-9.0.19.zip}
if [ ! -f $TOMCAT_ZIP ]; then
 echo -e "${RED}$TOMCAT_ZIP not found, exiting${OFF}"
 exit 1
fi

read -p "ORDS zip file [/tmp/ords-19.1.0.092.1545.zip]: " ORDS_ZIP
ORDS_ZIP=${ORDS_ZIP:-/tmp/ords-19.1.0.092.1545.zip}
if [ ! -f $ORDS_ZIP ]; then
 echo -e "${RED}$ORDS_ZIP not found, exiting${OFF}"
 exit 1
fi

read -p "Tomcat home [/home/oracle/apache-tomcat-9.0.19]: " TOMCAT_HOME
TOMCAT_HOME=${TOMCAT_HOME:-/home/oracle/apache-tomcat-9.0.19}

read -p "ORDS home [/home/oracle/ords]: " ORDS_HOME
ORDS_HOME=${ORDS_HOME:-/home/oracle/ords}

read -p "SYS password [SysPassword1]: " SYS_PASS
SYS_PASS=${SYS_PASS:-SysPassword1}

read -p "APEX and ORDS internal accounts password [ApexIntPassword1]: " APEX_PASS
APEX_PASS=${APEX_PASS:-ApexIntPassword1}

read -p "Database container name for apex [pdb1]: " PDB
PDB=${PDB:-pdb1}

echo "TOMCAT_ZIP=${TOMCAT_ZIP}
ORDS_ZIP=${ORDS_ZIP}
TOMCAT_HOME=${TOMCAT_HOME}
ORDS_HOME=${ORDS_HOME}
SYS_PASS=${SYS_PASS}
APEX_PASS=${APEX_PASS}
PDB=${PDB}" > `dirname $0`/ordsenv

if [ $? -eq 0 ]; then
 echo "**************************************************************"
 echo "*** ordsenv saved in `dirname $0`/ordsenv *"
 echo "**************************************************************"
else
 echo "`dirname $0`/ordsenv saved failed";
fi
