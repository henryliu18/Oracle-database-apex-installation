#!/usr/bin/bash

#
# Tested CentOS 7
# Listener configuration, run as root user
#

# Source env
if [ -f `dirname $0`/env ]; then
 . `dirname $0`/env
else
 echo "env file not found in `dirname $0`, run setup to create env file"
 echo "cd `dirname $0`;bash `dirname $0`/setup env"
 exit 1
fi

echo "netca /silent /responsefile \$ORACLE_HOME/assistants/netca/netca.rsp" > ${SCRIPT_DIR}/run_netca
chmod a+x ${SCRIPT_DIR}/run_netca
su - $O_USER -c ${SCRIPT_DIR}/run_netca
rm -f ${SCRIPT_DIR}/run_netca
