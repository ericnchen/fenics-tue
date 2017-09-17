FROM centos:6

ENV LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8

COPY entrypoint.sh /opt/
RUN chmod +x /opt/entrypoint.sh

RUN yum install -y \
        gcc \
        patch \
        wget && \
    yum clean all && \
    rm -rf /tmp/*

RUN adduser -c "Santiago" santiago
USER santiago
WORKDIR /home/santiago

RUN wget -O /tmp/miniconda.sh "https://repo.continuum.io/miniconda/Miniconda3-4.3.21-Linux-x86_64.sh" && \
    sh /tmp/miniconda.sh -b -p "${HOME}/miniconda3" && \
    "${HOME}/miniconda3/bin/conda" install -c conda-forge -y \
        gcc==4.8.5 \
        libgcc==4.8.5 \
        conda-build=3.0 && \
    rm -rf /tmp/*

ENTRYPOINT ["/opt/entrypoint.sh"]
