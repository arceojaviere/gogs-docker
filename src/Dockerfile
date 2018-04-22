FROM rhel7

# Yum cleans and repolists are in place to be able to disable all repos and to allow the 
# "rhel-7-server-rpms" repo to be registered. Both actions will have no effect otherwise
# for reasons unkonwn
RUN yum clean all \
    && yum-config-manager --disable "*" 2>&1 > /dev/null\
    && yum repolist \
    && yum-config-manager --enable "rhel-7-server-rpms"\
    && yum -y install git\
    && yum clean all \
    && rm -rvf /var/cache/yum

ENV USER="gogs"\
    HOME="/opt/gogs"\
    ROOT_URL="http://docker1.lab:8080/"

WORKDIR /opt/gogs
COPY ["app.ini","run.sh","./"]

#Installing GOGS
RUN cd ..\
    && curl -o linux_amd64.tar.gz -fL https://dl.gogs.io/0.11.29/linux_amd64.tar.gz\
    && tar -zxvf linux_amd64.tar.gz\
    && rm linux_amd64.tar.gz\
    && cd gogs\
    && mkdir -p ./custom/conf /data\
    && ln -s /data ./data\
    && mv app.ini ./custom/conf/\
    && useradd -u 1000 -d /opt/gogs -M gogs\
    && chown -R gogs:gogs /opt/gogs /data\
    && chmod -R g+rwx /opt/gogs /data\
    && chmod a+x run.sh
USER gogs
EXPOSE 8080
ENTRYPOINT ./run.sh
