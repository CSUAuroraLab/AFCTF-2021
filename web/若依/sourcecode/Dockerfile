FROM aallam/tomcat-mysql

RUN set -ex \
    && rm -rf /opt/tomcat/webapps/* \
    && chmod a+x /opt/tomcat/bin/*.sh

COPY ./ry-source /home/ry-source 
COPY ./sql /home/sql
COPY ./init.sh /home/init.sh
RUN chmod +x /home/init.sh

EXPOSE 8090
