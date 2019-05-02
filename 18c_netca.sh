#!/usr/bin/bash

#
# Tested CentOS 7
# Listener configuration, run as root user
#

O_USER=oracle
RUN_SCRIPT=/tmp/run_netca

echo "netca /silent /responsefile \$ORACLE_HOME/assistants/netca/netca.rsp" > $RUN_SCRIPT
chmod a+x $RUN_SCRIPT
su - $O_USER -c $RUN_SCRIPT
rm -f $RUN_SCRIPT
