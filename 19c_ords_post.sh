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

echo "Oracle REST Database Service is built successfully, cove 2 files below to Tomcat server under \$TOMCAT_HOME/webapps
$ORDS_HOME/ords.war
$APEX_HOME/apex/images has been zipped to $ORDS_HOME/i.zip
you need to unzip i.zip to Tomcat server under \$TOMCAT_HOME/webapps/i"
