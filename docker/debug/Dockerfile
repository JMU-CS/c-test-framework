FROM cs261
LABEL name="CS261-Debug"
LABEL maintainer="Mike Lam <lam2mo@jmu.edu>"
LABEL description="JMU CS261 Y86 Project Debug Image"
LABEL architecture="x86_64"
LABEL version="1.0"

# install additional software
RUN apt-get update && \
    apt-get install -y nano vim gdb bsdmainutils && \
    apt-get clean

# copy editor settings
RUN echo "alias nnano='nano -AEOSim -T 4 -r 80'" >> /root/.bashrc
COPY vimrc /root/.vimrc

# start shell
WORKDIR /src
CMD ["/bin/bash"]

