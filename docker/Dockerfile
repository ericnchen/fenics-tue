# Build:
# docker build -t fenics-tue-builder .

# Start from CentOS 6 because it's the closest base image to Rocks 6.1.1 (Sand Boa) found on RNG and Furnace.
FROM centos:6

# This part downlaods, verifies, installs, and updates the Anaconda/Miniconda Python distribution and build system.
RUN curl -so /tmp/Miniconda3-Linux-x86_64.sh https://repo.continuum.io/miniconda/Miniconda3-4.3.31-Linux-x86_64.sh && \
    echo '7fe70b214bee1143e3e3f0467b71453c  /tmp/Miniconda3-Linux-x86_64.sh' > /tmp/Miniconda3-Linux-x86_64.md5sum && \
    md5sum -c /tmp/Miniconda3-Linux-x86_64.md5sum && \
    bash /tmp/Miniconda3-Linux-x86_64.sh -bp /anaconda && \
    /anaconda/bin/conda install -y conda-build && \
    /anaconda/bin/conda update -y --all && \
    /anaconda/bin/conda clean -y --all && \
    rm /tmp/*

# This part creates a user, builder, which will be the builder account, and switch to it.
RUN useradd -ms /bin/bash builder
USER builder
WORKDIR /home/builder
