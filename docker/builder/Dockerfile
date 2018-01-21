# This builder image is based off of CentOS 6 because that is the closest base
# image to the Rocks (6.1.1 Sand Boa) distribution found on the RNG cluster.
FROM centos:6

# Create a user account called "builder" with the same UID as me.
# TODO: This should be eventually generalized at some point.
RUN useradd -m -s /bin/bash -u 1000 builder

# Install the Anaconda Python distribution and conda-build.
RUN curl -so /tmp/Miniconda3-Linux-x86_64.sh https://repo.continuum.io/miniconda/Miniconda3-4.3.31-Linux-x86_64.sh && \
    echo '7fe70b214bee1143e3e3f0467b71453c  /tmp/Miniconda3-Linux-x86_64.sh' > /tmp/Miniconda3-Linux-x86_64.md5sum && \
    md5sum -c /tmp/Miniconda3-Linux-x86_64.md5sum && \
    bash /tmp/Miniconda3-Linux-x86_64.sh -bp /anaconda && \
    /anaconda/bin/conda install -y conda-build && \
    /anaconda/bin/conda update -y --all && \
    /anaconda/bin/conda clean -y --all && \
    rm /tmp/* && \
    chown -R builder /anaconda

# Install additional tools via yum.
RUN yum update && \
    yum install -y \
        perl \
        openssh-clients && \
    yum clean -y all && \
    rm -rf /tmp/*

# Copy over relevant files/scripts and fix permissions.
ADD conda-build.sh   /home/builder/conda-build.sh
RUN chown -R builder /home/builder/conda-build.sh

# Set the builder user and work directory.
USER builder
WORKDIR /home/builder
