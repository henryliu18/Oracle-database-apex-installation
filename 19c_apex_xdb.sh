#!/usr/bin/bash

#
# Tested CentOS 7
# Enable XDB http, run as root user
#
# Enable XDB http

# Source env
if [ -f `dirname $0`/env ]; then
 . `dirname $0`/env
else
 echo "env file not found in `dirname $0`, run setup to create env file"
 echo "cd `dirname $0`;bash `dirname $0`/setup env"
 exit 1
fi

echo "ORAENV_ASK=NO
. oraenv
$ORACLE_HOME/bin/sqlplus / as sysdba<<EOF
alter session set container=$PDB;
EXEC DBMS_XDB.sethttpport(8080);
exit;
EOF" > ${SCRIPT_DIR}/run_xdb
chmod a+x ${SCRIPT_DIR}/run_xdb
su - $O_USER -c ${SCRIPT_DIR}/run_xdb
rm -f ${SCRIPT_DIR}/run_xdb
