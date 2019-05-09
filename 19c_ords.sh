#!/usr/bin/bash

#
# Tested CentOS 7
# ORDS webapp build, run as root user
#

# Source env
if [ -f `dirname $0`/env ]; then
 . `dirname $0`/env
else
 echo "env file not found in `dirname $0`, run setup to create env file"
 echo "cd `dirname $0`;bash `dirname $0`/setup env"
 exit 1
fi

echo "mkdir -p $ORDS_HOME
cd $ORDS_HOME
unzip $ORDS_SW

echo \"db.hostname=`hostname`
db.password=$APEX_PASS
db.port=1521
db.servicename=$PDB
db.username=APEX_PUBLIC_USER
migrate.apex.rest=false
plsql.gateway.add=true
rest.services.apex.add=true
rest.services.ords.add=true
schema.tablespace.default=SYSAUX
schema.tablespace.temp=TEMP
standalone.mode=false
user.apex.listener.password=$APEX_PASS
user.apex.restpublic.password=$APEX_PASS
user.public.password=$APEX_PASS
user.tablespace.default=USERS
user.tablespace.temp=TEMP
sys.user=sys
sys.password=$SYS_PASS\" > params/ords_params.properties

java -jar ords.war configdir `dirname $ORDS_HOME`/
java -jar ords.war install simple -silent" > $RUN_ORDS

chmod a+x $RUN_ORDS
su - $O_USER -c $RUN_ORDS
rm -f $RUN_ORDS
