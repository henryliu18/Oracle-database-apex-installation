#!/usr/bin/bash

#
# Tested CentOS 7
# Apex installation, run as root user
#
# What does this script do
#
# make sure pdb is read-write
# make sure pdb state is saved
# create APEX tablespace
# install APEX 19.1 - apexins.sql
# change APEX admin password
# configure embedded PL/SQL Gateway - apex_epg_config.sql
# unlock and change password of user ANONYMOUS
# unlock and change password of user APEX_PUBLIC_USER by pass
# create ACL to allow traffic out - DBMS_NETWORK_ACL_ADMIN.APPEND_HOST_ACE
# append PDB entry in tnsnames.ora
# configure Oracle REST Data Services - apex_rest_config.sql

# Source env
if [ -f `dirname $0`/env ]; then
 . `dirname $0`/env
else
 echo "env file not found in `dirname $0`, run setup to create env file"
 echo "cd `dirname $0`;bash `dirname $0`/setup env"
 exit 1
fi

# Create a new tablespace to act as the default tablespace for APEX.
echo "--ALTER SYSTEM SET MEMORY_TARGET='$APEX_DB_MEMORY' SCOPE=spfile;
--STARTUP FORCE
ALTER PLUGGABLE DATABASE $PDB OPEN READ WRITE;
alter pluggable database $PDB save state;
alter session set container=$PDB;
ALTER SYSTEM SET db_create_file_dest = '$ORACLE_DB';
CREATE TABLESPACE $APEX_TABLESPACE DATAFILE SIZE 100M AUTOEXTEND ON NEXT 1M;
-- @apexins.sql tablespace_apex tablespace_files tablespace_temp images
@apexins.sql $APEX_TABLESPACE $APEX_TABLESPACE TEMP /i/
BEGIN
    APEX_UTIL.set_security_group_id( 10 );
    
    APEX_UTIL.create_user(
        p_user_name       => 'ADMIN',
        p_email_address   => 'me@example.com',
        p_web_password    => 'changeme123',
        p_developer_privs => 'ADMIN' );
        
    APEX_UTIL.set_security_group_id( null );
    COMMIT;
END;
/
--can not silent
--@apex_rest_config.sql ApexPassword1 ApexPassword2
@apex_epg_config.sql $APEX_HOME
conn / as sysdba
DECLARE
  l_passwd VARCHAR2(40);
BEGIN
  l_passwd := DBMS_RANDOM.string('a',10) || DBMS_RANDOM.string('x',10) || '1#';
  -- Remove CONTAINER=ALL for non-CDB environments.
  EXECUTE IMMEDIATE 'ALTER USER anonymous IDENTIFIED BY ' || l_passwd || ' ACCOUNT UNLOCK CONTAINER=ALL';
END;
/
alter session set container=$PDB;
ALTER USER APEX_PUBLIC_USER ACCOUNT UNLOCK;
ALTER USER APEX_PUBLIC_USER IDENTIFIED BY pass;

BEGIN
DBMS_NETWORK_ACL_ADMIN.APPEND_HOST_ACE(
host => '*',
ace => xs\$ace_type(privilege_list => xs\$name_list('connect'),
principal_name => 'APEX_190100',
principal_type => xs_acl.ptype_db));
END;
/

BEGIN
DBMS_NETWORK_ACL_ADMIN.APPEND_HOST_ACE(
host => 'localhost',
ace => xs\$ace_type(privilege_list => xs\$name_list('connect'),
principal_name => 'APEX_190100',
principal_type => xs_acl.ptype_db));
END;
/
exit" > $APEX_SQL

# tnsnames.ora
echo "$PDB =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = `hostname`)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = $PDB)
    )
  )" >> $ORACLE_HOME/network/admin/tnsnames.ora

echo "ORAENV_ASK=NO
. oraenv

# Create directories
mkdir $APEX_HOME

# unzip Apex software
cd $APEX_HOME
unzip -oq $APEX_SW
cd apex
$ORACLE_HOME/bin/sqlplus / as sysdba @$APEX_SQL
$ORACLE_HOME/bin/sqlplus sys/SysPassword1@$PDB as sysdba<<EOF
@apex_rest_config.sql pass pass
exit;
EOF" > $RUN_APEX
chmod a+x $RUN_APEX
su - $O_USER -c $RUN_APEX
rm -f $RUN_APEX
rm -f $APEX_SQL
