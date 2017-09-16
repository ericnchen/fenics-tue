FROM centos:6

RUN yum install -y \
        gcc \
        wget && \
    yum clean all && \
    rm -rf /tmp/*

RUN adduser -c "Test User" testuser

USER testuser
WORKDIR /home/testuser
