#!/usr/bin/bash

#
# Tested CentOS 7
# Database creation, run as root user
#

ORATAB=/etc/oratab
TMPORATAB=/tmp/oratab
O_USER=oracle
RUN_SCRIPT=/tmp/run_dbca

echo "dbca -silent -createDatabase \
     -templateName General_Purpose.dbc \
     -gdbname \$ORACLE_SID \
     -sid \$ORACLE_SID \
	-responseFile NO_VALUE \
     -characterSet AL32UTF8 \
     -sysPassword SysPassword1 \
     -systemPassword SysPassword1 \
     -createAsContainerDatabase true \
     -numberOfPDBs 1 \
     -pdbName \$PDB_NAME \
     -pdbAdminPassword PdbPassword1 \
     -databaseType MULTIPURPOSE \
     -automaticMemoryManagement false \
     -totalMemory 1500 \
     -storageType FS \
     -datafileDestination "\$DATA_DIR" \
     -redoLogFileSize 50 \
     -emConfiguration NONE \
     -ignorePreReqs" > $RUN_SCRIPT
chmod a+x $RUN_SCRIPT
su - $O_USER -c $RUN_SCRIPT
rm -f $RUN_SCRIPT

# Change auto start flag from N to Y
sed -e "/$ORACLE_SID/s/^/#/g" $ORATAB > $TMPORATAB
grep "$ORACLE_SID.*:N" $ORATAB | sed s'/..$/:Y/' >> $TMPORATAB
cat $TMPORATAB > $ORATAB
rm -f $TMPORATAB
