#ORDS webapp build<br />
su - oracle<br />
mkdir ords<br />
cd ords<br />
unzip /tmp/ords-19.1.0.092.1545.zip<br />
java -jar ords.war setup<br />
<br />
<br />
This Oracle REST Data Services instance has not yet been configured.<br />
Please complete the following prompts<br />
<br />
Enter the location to store configuration data:/home/oracle/<br />
Enter the name of the database server [localhost]:192.168.56.101<br />
Enter the database listen port [1521]:1521<br />
Enter 1 to specify the database service name, or 2 to specify the database SID [1]:1<br />
Enter the database service name:pdb1<br />
Enter 1 if you want to verify/install Oracle REST Data Services schema or 2 to skip this step [1]:1<br />
Enter the database password for ORDS_PUBLIC_USER:<br />
Confirm password:<br />
Requires to login with administrator privileges to verify Oracle REST Data Services schema.<br />
<br />
Enter the administrator username:sys<br />
Enter the database password for SYS AS SYSDBA:<br />
Confirm password:<br />
<br />
Retrieving information.<br />
Enter the default tablespace for ORDS_METADATA [SYSAUX]:<br />
Enter the temporary tablespace for ORDS_METADATA [TEMP]:<br />
Enter the default tablespace for ORDS_PUBLIC_USER [USERS]:<br />
Enter the temporary tablespace for ORDS_PUBLIC_USER [TEMP]:<br />
Enter 1 if you want to use PL/SQL Gateway or 2 to skip this step.<br />
If using Oracle Application Express or migrating from mod_plsql then you must enter 1 [1]:1<br />
Enter the PL/SQL Gateway database user name [APEX_PUBLIC_USER]:<br />
Enter the database password for APEX_PUBLIC_USER:<br />
Confirm password:<br />
Enter 1 to specify passwords for Application Express RESTful Services database users (APEX_LISTENER, APEX_REST_PUBLIC_USER) or 2 to skip this step [1]:1<br />
Enter the database password for APEX_LISTENER:<br />
Confirm password:<br />
Enter the database password for APEX_REST_PUBLIC_USER:<br />
Confirm password:<br />
May 08, 2019 12:36:05 AM<br />
INFO: reloaded pools: []<br />
Installing Oracle REST Data Services version 19.1.0.r0921545<br />
... Log file written to /home/oracle/ords_install_core_2019-05-08_003606_00126.log<br />
... Verified database prerequisites<br />
... Created Oracle REST Data Services proxy user<br />
... Created Oracle REST Data Services schema<br />
... Granted privileges to Oracle REST Data Services<br />
... Created Oracle REST Data Services database objects<br />
... Log file written to /home/oracle/ords_install_datamodel_2019-05-08_003624_00999.log<br />
... Log file written to /home/oracle/ords_install_apex_2019-05-08_003629_00403.log<br />
Completed installation for Oracle REST Data Services version 19.1.0.r0921545. Elapsed time: 00:00:26.720<br />
<br />
<br />
java -jar ords.war<br />
<br />
Verify ORDS schema in Database Configuration apex with connection host: 192.168.56.101 port: 1521 service name: pdb1<br />
<br />
<br />
Retrieving information.<br />
May 08, 2019 12:39:13 AM oracle.dbtools.rt.config.setup.SchemaSetup install<br />
INFO: Oracle REST Data Services schema version 19.1.0.r0921545 is installed.<br />
Enter 1 if you wish to start in standalone mode or 2 to exit [1]:1<br />
Enter the APEX static resources location:/opt/app/oracle/apex19/apex/images/<br />
Enter 1 if using HTTP or 2 if using HTTPS [1]:1
2019-05-08 00:39:57.713:INFO::main: Logging initialized @49593ms to org.eclipse.jetty.util.log.StdErrLog<br />
May 08, 2019 12:39:57 AM<br />
INFO: HTTP and HTTP/2 cleartext listening on port: 8080<br />
May 08, 2019 12:39:57 AM<br />
INFO: Disabling document root because the specified folder does not exist: /opt/app/oracle/ords/conf/ords/standalone/doc_root<br />
2019-05-08 00:40:00.752:INFO:oejs.Server:main: jetty-9.4.z-SNAPSHOT; built: 2019-02-20T15:50:58.683Z; git: 3285c4dd4bb00caddcded77f8e44e72c61b9ab72; jvm 1.8.0_181-b13<br />
2019-05-08 00:40:00.881:INFO:oejs.session:main: DefaultSessionIdManager workerName=node0<br />
2019-05-08 00:40:00.881:INFO:oejs.session:main: No SessionScavenger set, using defaults<br />
2019-05-08 00:40:00.881:INFO:oejs.session:main: node0 Scavenging every 600000ms<br />
May 08, 2019 12:40:01 AM<br />
INFO: Configuration properties for: |apex||<br />
db.hostname=192.168.56.101<br />
db.password=******<br />
db.port=1521<br />
db.servicename=pdb1<br />
db.username=APEX_PUBLIC_USER<br />
resource.templates.enabled=true<br />
security.requestValidationFunction=wwv_flow_epg_include_modules.authorize<br />
security.validationFunctionType=plsql<br />
<br />
May 08, 2019 12:40:01 AM<br />
WARNING: *** jdbc.MaxLimit in configuration |apex|| is using a value of 10, this setting may not be sized adequately for a production environment *** <br />
May 08, 2019 12:40:01 AM<br />
WARNING: *** jdbc.InitialLimit in configuration |apex|| is using a value of 3, this setting may not be sized adequately for a production environment *** <br />
May 08, 2019 12:40:03 AM<br />
INFO: Configuration properties for: |apex|pu|<br />
db.hostname=192.168.56.101<br />
db.password=******<br />
db.port=1521<br />
db.servicename=pdb1<br />
db.username=ORDS_PUBLIC_USER<br />
resource.templates.enabled=true<br />
security.requestValidationFunction=wwv_flow_epg_include_modules.authorize<br />
security.validationFunctionType=plsql<br />
<br />
May 08, 2019 12:40:03 AM<br />
WARNING: *** jdbc.MaxLimit in configuration |apex|pu| is using a value of 10, this setting may not be sized adequately for a production environment *** <br />
May 08, 2019 12:40:03 AM<br />
WARNING: *** jdbc.InitialLimit in configuration |apex|pu| is using a value of 3, this setting may not be sized adequately for a production environment *** <br />
May 08, 2019 12:40:03 AM<br />
INFO: Configuration properties for: |apex|al|<br />
db.hostname=192.168.56.101<br />
db.password=******<br />
db.port=1521<br />
db.servicename=pdb1<br />
db.username=APEX_LISTENER<br />
resource.templates.enabled=true<br />
security.requestValidationFunction=wwv_flow_epg_include_modules.authorize<br />
security.validationFunctionType=plsql<br />
<br />
May 08, 2019 12:40:03 AM<br />
WARNING: *** jdbc.MaxLimit in configuration |apex|al| is using a value of 10, this setting may not be sized adequately for a production environment *** <br />
May 08, 2019 12:40:03 AM<br />
WARNING: *** jdbc.InitialLimit in configuration |apex|al| is using a value of 3, this setting may not be sized adequately for a production environment *** <br />
May 08, 2019 12:40:04 AM<br />
INFO: Configuration properties for: |apex|rt|<br />
db.hostname=192.168.56.101<br />
db.password=******<br />
db.port=1521<br />
db.servicename=pdb1<br />
db.username=APEX_REST_PUBLIC_USER<br />
resource.templates.enabled=true<br />
security.requestValidationFunction=wwv_flow_epg_include_modules.authorize<br />
security.validationFunctionType=plsql<br />
<br />
May 08, 2019 12:40:04 AM<br />
WARNING: *** jdbc.MaxLimit in configuration |apex|rt| is using a value of 10, this setting may not be sized adequately for a production environment *** <br />
May 08, 2019 12:40:04 AM<br />
WARNING: *** jdbc.InitialLimit in configuration |apex|rt| is using a value of 3, this setting may not be sized adequately for a production environment *** <br />
May 08, 2019 12:40:04 AM<br />
INFO: Oracle REST Data Services initialized<br />
Oracle REST Data Services version : 19.1.0.r0921545<br />
Oracle REST Data Services server info: jetty/9.4.z-SNAPSHOT<br />
<br />
2019-05-08 00:40:04.930:INFO:oejsh.ContextHandler:main: Started o.e.j.s.ServletContextHandler@757942a1{/ords,null,AVAILABLE}<br />
2019-05-08 00:40:04.931:INFO:oejsh.ContextHandler:main: Started o.e.j.s.h.ContextHandler@37374a5e{/i,null,AVAILABLE}<br />
2019-05-08 00:40:04.947:INFO:oejs.AbstractConnector:main: Started ServerConnector@4387b79e{HTTP/1.1,[http/1.1, h2c]}{0.0.0.0:8080}<br />
2019-05-08 00:40:04.947:INFO:oejs.Server:main: Started @56827ms<br />
<br />

<img class="tomcat-logo pull-left noPrint" alt="Tomcat Home" src="http://tomcat.apache.org/res/images/tomcat.png"><br />
#build tomcat server<br />
unzip /tmp/apache-tomcat-9.0.19.zip <br />
cd apache-tomcat-9.0.19/bin<br />
chmod +x catalina.sh<br />
<br />
#deploy ords webapp to tomcat server<br />
cp /home/oracle/ords/ords.war /home/oracle/apache-tomcat-9.0.19/webapps<br />
<br />
#copy Apex images directory to tomcat server<br />
cp -r /opt/app/oracle/apex19/apex/images/ /home/oracle/apache-tomcat-9.0.19/webapps/i/<br />
<br />
#start tomcat server<br />
sh startup.sh<br />
#shutdown tomcat server<br />
sh shutdown.sh<br />
