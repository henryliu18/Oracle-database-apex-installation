#!/usr/bin/bash

#
# Tested CentOS 7
# Database creation, run as root user
#

# Source env
if [ -f `dirname $0`/env ]; then
 . `dirname $0`/env
else
 echo "env file not found in `dirname $0`, run setup to create env file"
 echo "cd `dirname $0`;bash `dirname $0`/setup env"
 exit 1
fi

cd $APEX_HOME/apex/images && zip -r /tmp/i.zip ./* && cd -

echo "Oracle REST Database Service is built successfully, copy 2 files below to Tomcat server
$ORDS_HOME/ords.war >>> cp $ORDS_HOME/ords.war \$TOMCAT_HOME/webapps/
/tmp/i.zip >>> mkdir \$TOMCAT_HOME/webapps/i; cd \$TOMCAT_HOME/webapps/i; unzip /path/i.zip"
