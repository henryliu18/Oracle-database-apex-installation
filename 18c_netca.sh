#!/usr/bin/bash

#
# Tested CentOS 7
# Listener configuration, run as root user
#

# Source env
if [ -f `dirname $0`/env ]; then
 . `dirname $0`/env
else
 echo "env file not found in `dirname $0`, run cd `dirname $0`;bash `dirname $0`/setup to create env file"
 exit 1
fi

echo "netca /silent /responsefile \$ORACLE_HOME/assistants/netca/netca.rsp" > $RUN_NETCA
chmod a+x $RUN_NETCA
su - $O_USER -c $RUN_NETCA
rm -f $RUN_NETCA
