#!/usr/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
OFF='\033[0m'

clear
echo "Networking"
ifconfig -a|grep 'inet\|flags\|Link'
read -p "Servicable network interface [eth0]: " NIC
NIC=${NIC:-eth0}
ifconfig $NIC
if [ $? -ne 0 ]; then
 echo -e "${RED}$NIC not found, exiting${OFF}"
 exit 1
fi

clear
echo "Software (zip file) location"
read -p "Oracle Database zip file [/tmp/LINUX.X64_180000_db_home.zip]: " ORACLE_SW
ORACLE_SW=${ORACLE_SW:-/tmp/LINUX.X64_180000_db_home.zip}
if [ ! -f $ORACLE_SW ]; then
 echo -e "${RED}$ORACLE_SW not found, exiting${OFF}"
 exit 1
fi

read -p "Apex zip file [/tmp/apex_19.1_en.zip]: " APEX_SW
APEX_SW=${APEX_SW:-/tmp/apex_19.1_en.zip}
if [ ! -f $APEX_SW ]; then
 echo -e "${RED}$APEX_SW not found, exiting${OFF}"
 exit 1
fi

read -p "ORDS zip file [/tmp/ords-19.1.0.092.1545.zip]: " ORDS_SW
ORDS_SW=${ORDS_SW:-/tmp/ords-19.1.0.092.1545.zip}
if [ ! -f $ORDS_SW ]; then
 echo -e "${RED}$ORDS_SW not found, exiting${OFF}"
 exit 1
fi

clear
echo "Security"
read -p "Oracle account [oracle]: " O_USER
O_USER=${O_USER:-oracle}

read -p "Oracle account's password [oracle123]: " O_PASS
O_PASS=${O_PASS:-oracle123}

read -p "(DB) SYS password [SysPassword1]: " SYS_PASS
SYS_PASS=${SYS_PASS:-SysPassword1}

read -p "(DB) SYSTEM password [SysPassword1]: " SYSTEM_PASS
SYSTEM_PASS=${SYSTEM_PASS:-SysPassword1}

read -p "(DB) PDBADMIN password [PdbPassword1]: " PDBADMIN_PASS
PDBADMIN_PASS=${PDBADMIN_PASS:-PdbPassword1}

read -p "(DB) APEX and ORDS password [ApexOrdsPass1]: " APEX_PASS
APEX_PASS=${APEX_PASS:-ApexOrdsPass1}

clear
echo "Installation location"
read -p "\$ORACLE_APP_ROOT (The root directory that will hold oracle database and oraInventory binaries) [/opt/app]: " ORACLE_APP_ROOT
ORACLE_APP_ROOT=${ORACLE_APP_ROOT:-/opt/app}

read -p "\$ORACLE_BASE (oracle database root directory) [\$ORACLE_APP_ROOT/oracle]: " ORACLE_BASE
ORACLE_BASE=${ORACLE_BASE:-\$ORACLE_APP_ROOT/oracle}

read -p "\$ORACLE_HOME (oracle database home directory) [\$ORACLE_BASE/product/18.0.0/dbhome_1]: " ORACLE_HOME
ORACLE_HOME=${ORACLE_HOME:-\$ORACLE_BASE/product/18.0.0/dbhome_1}

read -p "Oracle database files directory [/ora/db001]: " ORACLE_DB
ORACLE_DB=${ORACLE_DB:-/ora/db001}

read -p "Apex software home [\$ORACLE_BASE/apex19]: " APEX_HOME
APEX_HOME=${APEX_HOME:-\$ORACLE_BASE/apex19}

read -p "ORDS software home [/home/oracle/ords]: " ORDS_HOME
ORDS_HOME=${ORDS_HOME:-/home/oracle/ords}

read -p "Location of auto generated scripts during installation [/tmp]: " SCRIPT_DIR
SCRIPT_DIR=${SCRIPT_DIR:-/tmp}

read -p "Location of oratab [/etc/oratab]: " ORATAB
ORATAB=${ORATAB:-/etc/oratab}

clear
echo "Oracle Database"
read -p "\$ORACLE_SID - Database database name or container instance name for apex [cdb1]: " CDB
CDB=${CDB:-cdb1}

read -p "Database container name for apex [pdb1]: " PDB
PDB=${PDB:-pdb1}

read -p "Tablespace name for apex [APEX]: " APEX_TABLESPACE
APEX_TABLESPACE=${APEX_TABLESPACE:-APEX}


echo "NIC=${NIC}
O_USER=${O_USER}
O_PASS=${O_PASS}
SYS_PASS=${SYS_PASS}
SYSTEM_PASS=${SYSTEM_PASS}
PDBADMIN_PASS=${PDBADMIN_PASS}
APEX_PASS=${APEX_PASS}
ORACLE_APP_ROOT=${ORACLE_APP_ROOT}
ORACLE_BASE=${ORACLE_BASE}
ORACLE_HOME=${ORACLE_HOME}
ORACLE_DB=${ORACLE_DB}
ORACLE_SW=${ORACLE_SW}
ORDS_SW=${ORDS_SW}
SCRIPT_DIR=${SCRIPT_DIR}
ORATAB=${ORATAB}
APEX_SW=${APEX_SW}
PDB=${PDB}
CDB=${CDB}
APEX_TABLESPACE=${APEX_TABLESPACE}
APEX_HOME=${APEX_HOME}
ORDS_HOME=${ORDS_HOME}" > `dirname $0`/env

if [ $? -eq 0 ]; then
this_id=`id -u`
OHROOT=`dirname ${ORACLE_APP_ROOT}`
diskfree=`df $OHROOT | awk '/[0-9]%/{print $(NF-2)}'`
if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
elif type lsb_release >/dev/null 2>&1; then
    # linuxbase.org
    OS=$(lsb_release -si)
    VER=$(lsb_release -sr)
elif [ -f /etc/lsb-release ]; then
    # For some versions of Debian/Ubuntu without lsb_release command
    . /etc/lsb-release
    OS=$DISTRIB_ID
    VER=$DISTRIB_RELEASE
elif [ -f /etc/debian_version ]; then
    # Older Debian/Ubuntu/etc.
    OS=Debian
    VER=$(cat /etc/debian_version)
elif [ -f /etc/SuSe-release ]; then
    # Older SuSE/etc.
    ...
elif [ -f /etc/redhat-release ]; then
    # Older Red Hat, CentOS, etc.
    ...
else
    # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
    OS=$(uname -s)
    VER=$(uname -r)
fi

if [ $this_id -ne 0 ]; then
  echo -e "${RED}you are not root${OFF}"
  exit 1
elif [ ! "command -v unzip" ]; then
  echo -e "${RED}unzip not found${OFF}"
  exit 1
elif [ ! "command -v tar" ]; then
  echo -e "${RED}tar not found${OFF}"
  exit 1
elif [ ! "command -v yum" ]; then
  echo -e "${RED}yum not found${OFF}"
  exit 1
elif [ "$OS" = "CentOS Linux" ] && [ ! $VER -eq 8 ] && [ ! $VER -eq 7 ] && [ ! $VER -eq 6 ]; then
  echo -e "${RED}$OS $VER incompatible${OFF}"
  exit 1
elif [ ! -f ${ORACLE_SW} ]; then
  echo -e "${RED}Oracle DB software not found${OFF}"
  exit 1
elif [ ! -f ${APEX_SW} ]; then
  echo -e "${RED}APEX software not found${OFF}"
  exit 1
elif [ ! -f ${ORDS_SW} ]; then
  echo -e "${RED}ORDS software not found${OFF}"
  exit 1
elif ! ping -q -c 1 -W 1 www.google.com >/dev/null; then
  echo -e "${RED}IPv4 is down${OFF}"
  exit 1
elif [ $diskfree -lt 20000000 ]; then
  echo -e "${RED}Storage too small${OFF}"
  exit 1
else
  echo Readiness Check
  echo "OS check..........[$OS-$VER]"
  echo "uid check..........[$this_id]"
  echo "unzip check..........[`command -v unzip>/dev/null 2>&1;echo $?`]"
  echo "tar check..........[`command -v tar>/dev/null 2>&1;echo $?`]"
  echo "yum check..........[`command -v yum>/dev/null 2>&1;echo $?`]"
  echo "Oracle DB software check..........[`ls ${ORACLE_SW}>/dev/null 2>&1;echo $?`]"
  echo "APEX software check..........[`ls ${APEX_SW}>/dev/null 2>&1;echo $?`]"
  echo "ORDS software check..........[`ls ${ORDS_SW}>/dev/null 2>&1;echo $?`]"
  echo "Internet check..........[`ping -q -c 1 -W 1 www.google.com>/dev/null 2>&1;echo $?`]"
  echo "Disk check..........["$OHROOT-$diskfree KB free"]"
  echo "**************************************************************"
  echo "*** env saved in `dirname $0`/env *"
  echo "**************************************************************"
  exit 0
fi

else
 echo "`dirname $0`/env saved failed";
fi

