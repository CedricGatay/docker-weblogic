# LICENSE MIT License 2015
#
# Jeferson de Sá DOCKER FILES For Weblogic instalation
# -----------------------------------------
# This is the Dockerfile for a default installation for both Oracle WebLogic Server 11g (10.3.6) Generic Distribution
# 
# IMPORTANT
# -----------------------------------------
# The resulting image of this Dockerfile DOES NOT contain a WLS Domain.
# For that, you must to create a domain on a new inherited image.
#
# REQUIRED FILES TO BUILD THIS IMAGE
# -----------------------------------------
# (1) Oracle Java SE Development Kit 7 for Linux x64 
# (2) Oracle WebLogic Server 10.3.6 Generic Installer
# 
#
# HOW TO BUILD THIS IMAGE
# -----------------------------------------
# Put all downloaded files in the same directory as this Dockerfile
# Run: 
#      $ sudo docker build -t jefersonbsa/docker-weblogic . 
#
# AUTHOR
# -----------------------------------------
# Jeferson de Sá <jeferson.bsa@gmail.com>
# https://br.linkedin.com/in/jefersonsa
# -----------------------------------------

# Pull base image
FROM jefersonbsa/docker-java-7


MAINTAINER Jeferson de Sa "jeferson.bsa@gmail.com"

# Actual Weblogic 11g 10.3.6 
# Installation and setup procedures
# Create a OFA location to put the weblogic install, create to oracle user so we can set the permissions on the location


RUN groupadd dba      -g 502 && \
    groupadd oinstall -g 501 && \
    useradd -m        -u 501 -g oinstall -G dba -d /home/oracle -s /sbin/nologin -c "Oracle Account" oracle && \
    mkdir -p /u01/app/oracle && \
    chown -R oracle:oinstall /home/oracle && \
    chown -R oracle:oinstall /u01/app/oracle

#Setup 11G
# Install Weblogic 11gR1 10.3.6 Generic
ADD silent.xml          /u01/app/oracle/silent.xml

WORKDIR /u01/app/oracle/11G/
RUN wget https://dl.dropboxusercontent.com/u/10127753/wls1036_generic.jar


# Set permission
RUN chmod +x /u01/app/oracle/wls1036_generic.jar

# Install
RUN [ "java","-Dspace.detection=false", "-Xmx1024m", "-jar", "/u01/app/oracle/wls1036_generic.jar", "-mode=silent", "-silent_xml=/u01/app/oracle/silent.xml" ]
RUN rm /u01/app/oracle/wls1036_generic.jar

#Tunning
# Change the open file limits in /etc/security/limits.conf
RUN sed -i '/.*EOF/d' /etc/security/limits.conf && \
    echo "* soft nofile 16384" >> /etc/security/limits.conf && \ 
    echo "* hard nofile 16384" >> /etc/security/limits.conf && \ 
    echo "# EOF"  >> /etc/security/limits.conf

# Change the kernel parameters that need changing.
RUN echo "net.core.rmem_max=4192608" > /u01/oracle/.sysctl.conf && \
    echo "net.core.wmem_max=4192608" >> /u01/oracle/.sysctl.conf && \ 
    sysctl -e -p /u01/oracle/.sysctl.conf

USER oracle

