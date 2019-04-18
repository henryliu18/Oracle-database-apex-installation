
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
ORACLE_HOME=/opt/app/oracle/product/11.2.0.4/db_1
ORACLE_DB=/ora/db001
ORACLE_SW1=/tmp/p13390677_112040_Linux-x86-64_1of7.zip
ORACLE_SW2=/tmp/p13390677_112040_Linux-x86-64_2of7.zip
ORACLE_SW_STG=/tmp/ora11g
INST_ORACLE_SW_SHELL=/tmp/inst_ora_sw.sh

#/etc/hosts configuration
echo "`ip -f inet addr show $NIC | grep -Po 'inet \K[\d.]+'` `hostname`" >> /etc/hosts

#Configuring the Kernel Parameter Settings
echo "fs.aio-max-nr = 1048576
fs.file-max = 6815744
kernel.shmall = 2097152
kernel.shmmax = 536870912
kernel.shmmni = 4096
# semaphores: semmsl, semmns, semopm, semmni
kernel.sem = 250 32000 100 128
net.ipv4.ip_local_port_range = 9000 65500
net.core.rmem_default=262144
net.core.rmem_max=4194304
net.core.wmem_default=262144
net.core.wmem_max=1048586" >> /etc/sysctl.conf

#Run the following command to change the current kernel parameters.
/sbin/sysctl -p

#Setting Shell Limits for the Oracle User
echo "oracle              soft    nproc   2047
oracle              hard    nproc   16384
oracle              soft    nofile  4096
oracle              hard    nofile  65536
oracle              soft    stack   10240" > /etc/security/limits.conf

echo "session    required     pam_limits.so" >> /etc/pam.d/login

#The following packages are listed as required, including the 32-bit version of some of the packages. Many of the packages should be installed already.
yum install binutils -y
yum install compat-libstdc++-33 -y
yum install compat-libstdc++-33.i686 -y
yum install gcc -y
yum install gcc-c++ -y
yum install glibc -y
yum install glibc.i686 -y
yum install glibc-devel -y
yum install glibc-devel.i686 -y
yum install ksh -y
yum install libgcc -y
yum install libgcc.i686 -y
yum install libstdc++ -y
yum install libstdc++.i686 -y
yum install libstdc++-devel -y
yum install libstdc++-devel.i686 -y
yum install libaio -y
yum install libaio.i686 -y
yum install libaio-devel -y
yum install libaio-devel.i686 -y
yum install libXext -y
yum install libXext.i686 -y
yum install libXtst -y
yum install libXtst.i686 -y
yum install libX11 -y
yum install libX11.i686 -y
yum install libXau -y
yum install libXau.i686 -y
yum install libxcb -y
yum install libxcb.i686 -y
yum install libXi -y
yum install libXi.i686 -y
yum install make -y
yum install sysstat -y
yum install unixODBC -y
yum install unixODBC-devel -y
yum install zlib-devel -y
yum install elfutils-libelf-devel -y
yum install -y unzip

#Create the new groups and users
groupadd -g 54321 oinstall
groupadd -g 54322 dba
groupadd -g 54323 oper

useradd -g oinstall -G dba,oper oracle

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
TMP=/tmp; export TMP
TMPDIR=$TMP; export TMPDIR

export ORACLE_HOSTNAME=`hostname`
ORACLE_UNQNAME=ORCL; export ORACLE_UNQNAME
export ORACLE_BASE=$ORACLE_BASE
export ORACLE_HOME=$ORACLE_HOME
ORACLE_SID=ORCL; export ORACLE_SID
ORACLE_TERM=xterm; export ORACLE_TERM
export PATH=/usr/sbin:/usr/local/bin:\$PATH
export PATH=$ORACLE_HOME/bin:\$PATH

LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib; export LD_LIBRARY_PATH
CLASSPATH=$ORACLE_HOME/JRE:$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib; export CLASSPATH" >> /home/$O_USER/.bash_profile

# Create a shell script to unzip and runInstaller
echo "mkdir $ORACLE_SW_STG
cd $ORACLE_SW_STG
unzip $ORACLE_SW1
unzip $ORACLE_SW2

#runInstaller SILENT
$ORACLE_SW_STG/database/runInstaller -silent -debug -force \
FROM_LOCATION=$ORACLE_SW_STG/database/stage/products.xml \
oracle.install.option=INSTALL_DB_SWONLY \
UNIX_GROUP_NAME=oinstall \
INVENTORY_LOCATION=\${ORA_INVENTORY} \
ORACLE_HOME=${ORACLE_HOME} \
ORACLE_HOME_NAME="OraDb11g_Home1" \
ORACLE_BASE=${ORACLE_BASE} \
oracle.install.db.InstallEdition=EE \
oracle.install.db.isCustomInstall=false \
oracle.install.db.DBA_GROUP=dba \
oracle.install.db.OPER_GROUP=dba \
DECLINE_SECURITY_UPDATES=true" > $INST_ORACLE_SW_SHELL

# Adding execute permission to all users
chmod a+x $INST_ORACLE_SW_SHELL
chown oracle:oinstall $ORACLE_SW

# unzip; runInstaller as oracle
su - $O_USER -c $INST_ORACLE_SW_SHELL

# execute last 2 scripts as root
$ORACLE_APP_ROOT/oraInventory/orainstRoot.sh
$ORACLE_HOME/root.sh
