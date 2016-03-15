FROM rhel7:latest
MAINTAINER ATSD Developers <dev-atsd@axibase.com>

#configure system
LABEL Vendor Axibase
LABEL Version ATSD
LABEL Release ATSD
LABEL Name rhel7/atsd

#RUN locale-gen en_US.UTF-8
#create directory for ssh daemon required by openssh-server
RUN mkdir -p /var/run/sshd

#configure users
RUN groupadd axibase &&\
    adduser -g axibase -c "Axibase Time-Series Database" axibase

#Install necessary software
RUN yum install -y java-1.7.0-openjdk-devel openssh-server cronie sysstat sed passwd iproute net-tools curl awk openssh-clients which hostname
RUN curl -O https://axibase.com/public/`curl -s https://axibase.com/public/atsd_ce_rpm_latest.htm | grep -o URL.*\" | awk -F '[="]' '{print $2}'` &&\
    yum localinstall -y atsd*.rpm

#set hbase distributed mode false
RUN sed -i '/.*hbase.cluster.distributed.*/{n;s/.*/   <value>false<\/value>/}' /opt/atsd/hbase/conf/hbase-site.xml

EXPOSE 22 1099 1883 8081 8084 8088 8443 8883
VOLUME ["/opt/atsd"]

ENTRYPOINT ["/bin/bash","/opt/atsd/bin/start_container.sh"]
