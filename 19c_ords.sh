#ORDS webapp build

su - oracle
mkdir ords
cd ords
unzip /tmp/ords-19.1.0.092.1545.zip
mkdir conf
java -jar ords.war setup


This Oracle REST Data Services instance has not yet been configured.
Please complete the following prompts

Enter the location to store configuration data:/home/oracle/ords/conf/
Enter the name of the database server [localhost]:192.168.56.101
Enter the database listen port [1521]:1521
Enter 1 to specify the database service name, or 2 to specify the database SID [1]:1
Enter the database service name:pdb1
Enter 1 if you want to verify/install Oracle REST Data Services schema or 2 to skip this step [1]:1
Enter the database password for ORDS_PUBLIC_USER:
Confirm password:
Requires to login with administrator privileges to verify Oracle REST Data Services schema.

Enter the administrator username:sys
Enter the database password for SYS AS SYSDBA:
Confirm password:

Retrieving information.
Enter the default tablespace for ORDS_METADATA [SYSAUX]:
Enter the temporary tablespace for ORDS_METADATA [TEMP]:
Enter the default tablespace for ORDS_PUBLIC_USER [USERS]:
Enter the temporary tablespace for ORDS_PUBLIC_USER [TEMP]:
Enter 1 if you want to use PL/SQL Gateway or 2 to skip this step.
If using Oracle Application Express or migrating from mod_plsql then you must enter 1 [1]:1
Enter the PL/SQL Gateway database user name [APEX_PUBLIC_USER]:
Enter the database password for APEX_PUBLIC_USER:
Confirm password:
Enter 1 to specify passwords for Application Express RESTful Services database users (APEX_LISTENER, APEX_REST_PUBLIC_USER) or 2 to skip this step [1]:1
Enter the database password for APEX_LISTENER:
Confirm password:
Enter the database password for APEX_REST_PUBLIC_USER:
Confirm password:
May 08, 2019 12:36:05 AM
INFO: reloaded pools: []
Installing Oracle REST Data Services version 19.1.0.r0921545
... Log file written to /home/oracle/ords_install_core_2019-05-08_003606_00126.log
... Verified database prerequisites
... Created Oracle REST Data Services proxy user
... Created Oracle REST Data Services schema
... Granted privileges to Oracle REST Data Services
... Created Oracle REST Data Services database objects
... Log file written to /home/oracle/ords_install_datamodel_2019-05-08_003624_00999.log
... Log file written to /home/oracle/ords_install_apex_2019-05-08_003629_00403.log
Completed installation for Oracle REST Data Services version 19.1.0.r0921545. Elapsed time: 00:00:26.720


java -jar ords.war

Verify ORDS schema in Database Configuration apex with connection host: 192.168.56.101 port: 1521 service name: pdb1


Retrieving information.
May 08, 2019 12:39:13 AM oracle.dbtools.rt.config.setup.SchemaSetup install
INFO: Oracle REST Data Services schema version 19.1.0.r0921545 is installed.
Enter 1 if you wish to start in standalone mode or 2 to exit [1]:1
Enter the APEX static resources location:/opt/app/oracle/apex19/apex/images/
Enter 1 if using HTTP or 2 if using HTTPS [1]:1
2019-05-08 00:39:57.713:INFO::main: Logging initialized @49593ms to org.eclipse.jetty.util.log.StdErrLog
May 08, 2019 12:39:57 AM
INFO: HTTP and HTTP/2 cleartext listening on port: 8080
May 08, 2019 12:39:57 AM
INFO: Disabling document root because the specified folder does not exist: /opt/app/oracle/ords/conf/ords/standalone/doc_root
2019-05-08 00:40:00.752:INFO:oejs.Server:main: jetty-9.4.z-SNAPSHOT; built: 2019-02-20T15:50:58.683Z; git: 3285c4dd4bb00caddcded77f8e44e72c61b9ab72; jvm 1.8.0_181-b13
2019-05-08 00:40:00.881:INFO:oejs.session:main: DefaultSessionIdManager workerName=node0
2019-05-08 00:40:00.881:INFO:oejs.session:main: No SessionScavenger set, using defaults
2019-05-08 00:40:00.881:INFO:oejs.session:main: node0 Scavenging every 600000ms
May 08, 2019 12:40:01 AM
INFO: Configuration properties for: |apex||
db.hostname=192.168.56.101
db.password=******
db.port=1521
db.servicename=pdb1
db.username=APEX_PUBLIC_USER
resource.templates.enabled=true
security.requestValidationFunction=wwv_flow_epg_include_modules.authorize
security.validationFunctionType=plsql

May 08, 2019 12:40:01 AM
WARNING: *** jdbc.MaxLimit in configuration |apex|| is using a value of 10, this setting may not be sized adequately for a production environment ***
May 08, 2019 12:40:01 AM
WARNING: *** jdbc.InitialLimit in configuration |apex|| is using a value of 3, this setting may not be sized adequately for a production environment ***
May 08, 2019 12:40:03 AM
INFO: Configuration properties for: |apex|pu|
db.hostname=192.168.56.101
db.password=******
db.port=1521
db.servicename=pdb1
db.username=ORDS_PUBLIC_USER
resource.templates.enabled=true
security.requestValidationFunction=wwv_flow_epg_include_modules.authorize
security.validationFunctionType=plsql

May 08, 2019 12:40:03 AM
WARNING: *** jdbc.MaxLimit in configuration |apex|pu| is using a value of 10, this setting may not be sized adequately for a production environment ***
May 08, 2019 12:40:03 AM
WARNING: *** jdbc.InitialLimit in configuration |apex|pu| is using a value of 3, this setting may not be sized adequately for a production environment ***
May 08, 2019 12:40:03 AM
INFO: Configuration properties for: |apex|al|
db.hostname=192.168.56.101
db.password=******
db.port=1521
db.servicename=pdb1
db.username=APEX_LISTENER
resource.templates.enabled=true
security.requestValidationFunction=wwv_flow_epg_include_modules.authorize
security.validationFunctionType=plsql

May 08, 2019 12:40:03 AM
WARNING: *** jdbc.MaxLimit in configuration |apex|al| is using a value of 10, this setting may not be sized adequately for a production environment ***
May 08, 2019 12:40:03 AM
WARNING: *** jdbc.InitialLimit in configuration |apex|al| is using a value of 3, this setting may not be sized adequately for a production environment ***
May 08, 2019 12:40:04 AM
INFO: Configuration properties for: |apex|rt|
db.hostname=192.168.56.101
db.password=******
db.port=1521
db.servicename=pdb1
db.username=APEX_REST_PUBLIC_USER
resource.templates.enabled=true
security.requestValidationFunction=wwv_flow_epg_include_modules.authorize
security.validationFunctionType=plsql

May 08, 2019 12:40:04 AM
WARNING: *** jdbc.MaxLimit in configuration |apex|rt| is using a value of 10, this setting may not be sized adequately for a production environment ***
May 08, 2019 12:40:04 AM
WARNING: *** jdbc.InitialLimit in configuration |apex|rt| is using a value of 3, this setting may not be sized adequately for a production environment ***
May 08, 2019 12:40:04 AM
INFO: Oracle REST Data Services initialized
Oracle REST Data Services version : 19.1.0.r0921545
Oracle REST Data Services server info: jetty/9.4.z-SNAPSHOT

2019-05-08 00:40:04.930:INFO:oejsh.ContextHandler:main: Started o.e.j.s.ServletContextHandler@757942a1{/ords,null,AVAILABLE}
2019-05-08 00:40:04.931:INFO:oejsh.ContextHandler:main: Started o.e.j.s.h.ContextHandler@37374a5e{/i,null,AVAILABLE}
2019-05-08 00:40:04.947:INFO:oejs.AbstractConnector:main: Started ServerConnector@4387b79e{HTTP/1.1,[http/1.1, h2c]}{0.0.0.0:8080}
2019-05-08 00:40:04.947:INFO:oejs.Server:main: Started @56827ms
