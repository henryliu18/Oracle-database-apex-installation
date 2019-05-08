# Source env
if [ -f `dirname $0`/env ]; then
 . `dirname $0`/env
else
 echo "env file not found in `dirname $0`, run setup to create env file"
 echo "cd `dirname $0`;bash `dirname $0`/setup env"
 exit 1
fi


#Create the APEX_LISTENER and APEX_REST_PUBLIC_USER users by running the "apex_rest_config.sql" script. (Run this manually after Apex is installed to the database)
echo "ORAENV_ASK=NO
. oraenv

cd $APEX_HOME/apex/
$ORACLE_HOME/bin/sqlplus sys/SysPassword1@$PDB as sysdba @apex_rest_config.sql
exit;" > /tmp/apex_rest_config.sh
chmod a+x /tmp/apex_rest_config.sh

su - $O_USER -c /tmp/apex_rest_config.sh
rm -f /tmp/apex_rest_config.sh
