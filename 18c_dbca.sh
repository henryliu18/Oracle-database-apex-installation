#!/usr/bin/bash

#
# Tested CentOS 7
# Database creation, run as root user
#

# Source env
if [ -f `dirname $0`/env ]; then
 . `dirname $0`/env
else
 echo "env file not found in `dirname $0`, run cd `dirname $0`;bash `dirname $0`/setup to create env file"
 exit 1
fi

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
     -datafileDestination "$ORACLE_DB" \
     -redoLogFileSize 50 \
     -emConfiguration NONE \
     -ignorePreReqs" > $RUN_DBCA
chmod a+x $RUN_DBCA
su - $O_USER -c $RUN_DBCA
rm -f $RUN_DBCA

# Change auto start flag from N to Y
sed -e "/$CDB/s/^/#/g" $ORATAB > $TMPORATAB
grep "$CDB.*:N" $ORATAB | sed s'/..$/:Y/' >> $TMPORATAB
cat $TMPORATAB > $ORATAB
rm -f $TMPORATAB
