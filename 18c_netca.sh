#!/usr/bin/bash

#
# Tested CentOS 7
# Listener configuration, run as root user
#

O_USER=oracle
RUN_NETCA=/tmp/run_netca

echo "netca /silent /responsefile \$ORACLE_HOME/assistants/netca/netca.rsp" > $RUN_NETCA
chmod a+x $RUN_NETCA
su - $O_USER -c $RUN_NETCA
rm -f $RUN_NETCA
