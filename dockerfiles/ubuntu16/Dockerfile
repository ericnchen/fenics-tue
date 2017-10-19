FROM ubuntu:16.04

ENV LC_ALL=C.UTF-8 \
    LANG=C.UTF-8 \
    LANGUAGE=C.UTF-8

COPY entrypoint.sh /opt/
RUN chmod +x /opt/entrypoint.sh

RUN apt-get update && \
    apt-get install -y \
            gcc \
            git \
            patch \
            bzip2 \
            wget && \
    apt-get clean && \
    rm -rf /tmp/*

RUN adduser --disabled-password --gecos "" santiago
USER santiago
WORKDIR /home/santiago

RUN wget -O /tmp/miniconda.sh "https://repo.continuum.io/miniconda/Miniconda3-4.3.21-Linux-x86_64.sh" && \
    bash /tmp/miniconda.sh -b -p "${HOME}/fenics-tue" && \
    "${HOME}/fenics-tue/bin/conda" install -c conda-forge -y \
        gcc==4.8.5 \
        libgcc==4.8.5 \
        conda-build=3.0 && \
    rm -rf /tmp/*

ENTRYPOINT ["/opt/entrypoint.sh"]
