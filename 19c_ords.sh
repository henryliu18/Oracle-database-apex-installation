#as root
#tomcat build
#TOMCAT_HOME
#TOMCAT_ZIP
#ORDS_HOME
#ORDS_ZIP

# Source ordsenv
if [ -f `dirname $0`/ordsenv ]; then
 . `dirname $0`/ordsenv
else
 echo "ordsenv file not found in `dirname $0`, run setup to create ordsenv file"
 echo "cd `dirname $0`;bash `dirname $0`/setup ordsenv"
 exit 1
fi

unzip /tmp/apache-tomcat-9.0.19.zip 
chmod +x /home/oracle/apache-tomcat-9.0.19/bin/catalina.sh

#start tomcat server
#sh /home/oracle/apache-tomcat-9.0.19/bin/startup.sh
#shutdown tomcat server
#sh /home/oracle/apache-tomcat-9.0.19/bin/shutdown.sh

#ords.war build
echo "db.hostname=192.168.56.102
db.password=ApexIntPassword1
db.port=1521
db.servicename=pdb1
db.username=APEX_PUBLIC_USER
migrate.apex.rest=false
plsql.gateway.add=true
rest.services.apex.add=true
rest.services.ords.add=true
schema.tablespace.default=SYSAUX
schema.tablespace.temp=TEMP
standalone.mode=false
user.apex.listener.password=ApexIntPassword1
user.apex.restpublic.password=ApexIntPassword1
user.public.password=ApexIntPassword1
user.tablespace.default=USERS
user.tablespace.temp=TEMP
sys.user=sys
sys.password=SysPassword1" > params/ords_params.properties

java -jar ords.war configdir /home/oracle/
java -jar ords.war install simple -silent  

#deploy ords webapp to tomcat server
cp /home/oracle/ords/ords.war /home/oracle/apache-tomcat-9.0.19/webapps

#copy Apex images directory to tomcat server
cp -r /opt/app/oracle/apex19/apex/images/ /home/oracle/apache-tomcat-9.0.19/webapps/i/
