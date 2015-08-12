FROM jefersonbsa/docker-java-7


MAINTAINER Jeferson Sa "jefersonbsa@gmail.com"

# Actual Weblogic 11g 10.3.6 installation and setup procedures
# Create a OFA location to put the weblogic install, create to oracle user so we can set the permissions on the location
RUN groupadd dba      -g 502 && \
    groupadd oinstall -g 501 && \
    useradd -m        -u 501 -g oinstall -G dba -d /home/oracle -s /sbin/nologin -c "Oracle Account" oracle && \
    mkdir -p /u01/app/oracle && \
    chown -R oracle:oinstall /home/oracle && \
    chown -R oracle:oinstall /u01/app/oracle

# Install Weblogic 11gR1 10.3.6 Generic
ADD silent.xml          /u01/app/oracle/silent.xml

WORKDIR /u01/app/oracle/
RUN wget https://dl.dropboxusercontent.com/u/10127753/wls1036_generic.jar


# Set permission

RUN chmod +x /u01/app/oracle/wls1036_generic.jar

# Install
RUN [ "java","-Dspace.detection=false", "-Xmx1024m", "-jar", "/u01/app/oracle/wls1036_generic.jar", "-mode=silent", "-silent_xml=/u01/app/oracle/silent.xml" ]
RUN rm /u01/app/oracle/wls1036_generic.jar

USER oracle

