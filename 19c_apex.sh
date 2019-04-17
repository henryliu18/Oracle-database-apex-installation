#!/usr/bin/bash

#
# Tested CentOS 7
# Apex installation, run as oracle user
#

APEX_SW=/tmp/apex_19.1_en.zip
APEX_SQL=/tmp/inst_apex.sql
APEX_CDB=cdb1
APEX_CDB_SYS=sys
APEX_CDB_SYSPW=SysPassword1
APEX_PDB=pdb1

APEX_TABLESPACE=APEX

APEX_HOME=$ORACLE_BASE/apex19
APEX_DB_MEMORY=2316M

APEX_ADMIN=ADMIN
APEX_ADMINPW=changeme123

# Create directories
mkdir $APEX_HOME

# unzip Apex software
cd $APEX_HOME
unzip -oq $APEX_SW
cd apex

# Create a new tablespace to act as the default tablespace for APEX.
echo "ALTER SYSTEM SET MEMORY_TARGET='$APEX_DB_MEMORY' SCOPE=spfile;
STARTUP FORCE
ALTER PLUGGABLE DATABASE $APEX_PDB OPEN READ WRITE;
alter pluggable database $APEX_PDB save state;

alter session set container=$APEX_PDB;
ALTER SYSTEM SET db_create_file_dest = '$DATA_DIR';

CREATE TABLESPACE $APEX_TABLESPACE DATAFILE SIZE 100M AUTOEXTEND ON NEXT 1M;
-- @apexins.sql tablespace_apex tablespace_files tablespace_temp images
@apexins.sql $APEX_TABLESPACE $APEX_TABLESPACE TEMP /i/

BEGIN
    APEX_UTIL.set_security_group_id( 10 );
    
    APEX_UTIL.create_user(
        p_user_name       => '$APEX_ADMIN',
        p_email_address   => 'me@example.com',
        p_web_password    => '$APEX_ADMINPW',
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

alter session set container=$APEX_PDB;
EXEC DBMS_XDB.sethttpport(8080);

exit" > $APEX_SQL

#sqlplus $APEX_CDB_SYS/$APEX_CDB_SYSPW@$APEX_CDB as sysdba @$APEX_SQL
sqlplus / as sysdba @$APEX_SQL


