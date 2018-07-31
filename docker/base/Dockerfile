FROM ubuntu:16.04
LABEL name="CS261-Base"
LABEL maintainer="Mike Lam <lam2mo@jmu.edu>"
LABEL description="JMU CS261 Y86 Project Base Image"
LABEL architecture="x86_64"
LABEL version="1.0"

# install necessary software
RUN apt-get update && \
    apt-get install -y make gcc check subunit && \
    apt-get clean

# run shell
WORKDIR /src
CMD ["/bin/bash"]

