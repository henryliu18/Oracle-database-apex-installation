#!/usr/bin/bash

#
# Tested CentOS 7
#
#

# Source env
if [ -f `dirname $0`/env ]; then
 . `dirname $0`/env
else
 echo "env file not found in `dirname $0`, run setup to create env file"
 echo "cd `dirname $0`;bash `dirname $0`/setup env"
 exit 1
fi

su - $O_USER -c "\$ORACLE_HOME/bin/dbshut \$ORACLE_HOME"

rm -rf $ORACLE_DB
rm -rf $ORACLE_APP_ROOT
rm -rf /opt/ORCLfmap
rm -rf /tmp/InstallActions*
rm -rf /tmp/hsperfdata*
rm -f /etc/oraInst.loc
rm -f /etc/oratab
rm -f /usr/local/bin/coraenv
rm -f /usr/local/bin/dbhome
rm -f /usr/local/bin/oraenv

userdel -r $O_USER

groupdel oinstall
groupdel dba
groupdel oper

rm -f /tmp/inst_ora_sw.sh
rm -f /tmp/inst_apex.sql

echo "127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6" > /etc/hosts

>/etc/security/limits.conf

echo "# sysctl settings are defined through files in
# /usr/lib/sysctl.d/, /run/sysctl.d/, and /etc/sysctl.d/.
#
# Vendors settings live in /usr/lib/sysctl.d/.
# To override a whole file, create a new file with the same in
# /etc/sysctl.d/ and put new settings there. To override
# only specific settings, add a file with a lexically later
# name in /etc/sysctl.d/ and put new settings there.
#
# For more information, see sysctl.conf(5) and sysctl.d(5)." > /etc/sysctl.conf

sysctl -p

echo "# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#     enforcing - SELinux security policy is enforced.
#     permissive - SELinux prints warnings instead of enforcing.
#     disabled - No SELinux policy is loaded.
SELINUX=enforcing
# SELINUXTYPE= can take one of three two values:
#     targeted - Targeted processes are protected,
#     minimum - Modification of targeted policy. Only selected processes are protected.
#     mls - Multi Level Security protection.
SELINUXTYPE=targeted" > /etc/selinux/config
