#!/usr/bin/bash

#
# Tested CentOS 7
#
#

NIC=ens33
O_USER=oracle
O_PASS=oracle123
ORACLE_APP_ROOT=/opt/app
ORACLE_BASE=$ORACLE_APP_ROOT/oracle
ORACLE_HOME=$ORACLE_BASE/product/18.0.0/dbhome_1
ORACLE_DB=/ora/db001
ORACLE_SW=/tmp/LINUX.X64_180000_db_home.zip
INST_ORACLE_SW_SHELL=/tmp/inst_ora_sw.sh

#/etc/hosts configuration
echo "`ip -f inet addr show $NIC | grep -Po 'inet \K[\d.]+'` `hostname`" >> /etc/hosts

#Configuring the Kernel Parameter Settings
echo "fs.file-max = 6815744
kernel.sem = 250 32000 100 128
kernel.shmmni = 4096
kernel.shmall = 1073741824
kernel.shmmax = 4398046511104
kernel.panic_on_oops = 1
net.core.rmem_default = 262144
net.core.rmem_max = 4194304
net.core.wmem_default = 262144
net.core.wmem_max = 1048576
net.ipv4.conf.all.rp_filter = 2
net.ipv4.conf.default.rp_filter = 2
fs.aio-max-nr = 1048576
net.ipv4.ip_local_port_range = 9000 65500" >> /etc/sysctl.conf

#Run the following command to change the current kernel parameters.
/sbin/sysctl -p

#Setting Shell Limits for the Oracle User
echo "oracle   soft   nofile    1024
oracle   hard   nofile    65536
oracle   soft   nproc    16384
oracle   hard   nproc    16384
oracle   soft   stack    10240
oracle   hard   stack    32768
oracle   hard   memlock    134217728
oracle   soft   memlock    134217728" > /etc/security/limits.conf

#The following packages are listed as required, including the 32-bit version of some of the packages. Many of the packages should be installed already.
yum install -y bc    
yum install -y binutils
yum install -y compat-libcap1
yum install -y compat-libstdc++-33
yum install -y compat-libstdc++-33.i686
yum install -y elfutils-libelf.i686
yum install -y elfutils-libelf
yum install -y elfutils-libelf-devel.i686
yum install -y elfutils-libelf-devel
yum install -y fontconfig-devel
yum install -y glibc.i686
yum install -y glibc
yum install -y glibc-devel.i686
yum install -y glibc-devel
yum install -y ksh
yum install -y libaio.i686
yum install -y libaio
yum install -y libaio-devel.i686
yum install -y libaio-devel
yum install -y libX11.i686
yum install -y libX11
yum install -y libXau.i686
yum install -y libXau
yum install -y libXi.i686
yum install -y libXi
yum install -y libXtst.i686
yum install -y libXtst
yum install -y libgcc.i686
yum install -y libgcc
yum install -y librdmacm-devel
yum install -y libstdc++.i686
yum install -y libstdc++
yum install -y libstdc++-devel.i686
yum install -y libstdc++-devel
yum install -y libxcb.i686
yum install -y libxcb
yum install -y make
yum install -y nfs-utils
yum install -y net-tools
yum install -y python
yum install -y python-configshell
yum install -y python-rtslib
yum install -y python-six
yum install -y smartmontools
yum install -y sysstat
yum install -y targetcli
yum install -y unixODBC
yum install -y unzip
yum install -y gcc-c++

#Create the new groups and users
groupadd -g 54321 oinstall
groupadd -g 54322 dba
groupadd -g 54323 oper

useradd -u 54321 -g oinstall -G dba,oper oracle

#Specify oracle password
passwd $O_USER <<EOF
$O_PASS
$O_PASS
EOF

#Set secure Linux to permissive
echo "# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#     enforcing - SELinux security policy is enforced.
#     permissive - SELinux prints warnings instead of enforcing.
#     disabled - No SELinux policy is loaded.
#SELINUX=enforcing
SELINUX=permissive
# SELINUXTYPE= can take one of three two values:
#     targeted - Targeted processes are protected,
#     minimum - Modification of targeted policy. Only selected processes are protected.
#     mls - Multi Level Security protection.
SELINUXTYPE=targeted" > /etc/selinux/config

setenforce Permissive

#Stop and disable firewalld
systemctl stop firewalld
systemctl disable firewalld

#Create directories for software and database
mkdir -p $ORACLE_HOME
mkdir -p $ORACLE_DB/data001
mkdir -p $ORACLE_DB/dbfra001
mkdir -p $ORACLE_DB/redo001
mkdir -p $ORACLE_DB/redo002

chown -R $O_USER:oinstall $ORACLE_APP_ROOT $ORACLE_DB
chmod -R 775 $ORACLE_APP_ROOT $ORACLE_DB

#.bash_profile
echo "# Oracle Settings
export TMP=/tmp
export TMPDIR=\$TMP

export ORACLE_HOSTNAME=`hostname`
export ORACLE_UNQNAME=cdb1
export ORACLE_BASE=$ORACLE_BASE
export ORACLE_HOME=$ORACLE_HOME
export ORA_INVENTORY=$ORACLE_APP_ROOT/oraInventory
export ORACLE_SID=cdb1
export PDB_NAME=pdb1
export DATA_DIR=$ORACLE_DB

export PATH=/usr/sbin:/usr/local/bin:\$PATH
export PATH=$ORACLE_HOME/bin:\$PATH

export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib
export CLASSPATH=$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib" >> /home/$O_USER/.bash_profile

# Create a shell script to unzip and runInstaller
echo "cd $ORACLE_HOME
unzip -oq $ORACLE_SW

#runInstaller SILENT
./runInstaller -ignorePrereq -waitforcompletion -silent                        \
    -responseFile ${ORACLE_HOME}/install/response/db_install.rsp               \
    oracle.install.option=INSTALL_DB_SWONLY                                    \
    ORACLE_HOSTNAME=\${ORACLE_HOSTNAME}                                         \
    UNIX_GROUP_NAME=oinstall                                                   \
    INVENTORY_LOCATION=\${ORA_INVENTORY}                                        \
    SELECTED_LANGUAGES=en,en_GB                                                \
    ORACLE_HOME=${ORACLE_HOME}                                                 \
    ORACLE_BASE=${ORACLE_BASE}                                                 \
    oracle.install.db.InstallEdition=EE                                        \
    oracle.install.db.OSDBA_GROUP=dba                                          \
    oracle.install.db.OSBACKUPDBA_GROUP=dba                                    \
    oracle.install.db.OSDGDBA_GROUP=dba                                        \
    oracle.install.db.OSKMDBA_GROUP=dba                                        \
    oracle.install.db.OSRACDBA_GROUP=dba                                       \
    SECURITY_UPDATES_VIA_MYORACLESUPPORT=false                                 \
    DECLINE_SECURITY_UPDATES=true" > $INST_ORACLE_SW_SHELL

# Adding execute permission to all users
chmod a+x $INST_ORACLE_SW_SHELL
chown oracle:oinstall $ORACLE_SW

# unzip; runInstaller as oracle
su - $O_USER -c $INST_ORACLE_SW_SHELL

# execute last 2 scripts as root
$ORACLE_APP_ROOT/oraInventory/orainstRoot.sh
$ORACLE_HOME/root.sh

