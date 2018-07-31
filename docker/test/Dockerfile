FROM cs261
LABEL name="CS261-Test"
LABEL maintainer="Mike Lam <lam2mo@jmu.edu>"
LABEL description="JMU CS261 Y86 Project Test Image"
LABEL architecture="x86_64"
LABEL version="1.0"

# add a student user account so we're not running tests as root
RUN yes | adduser --disabled-password student

# copy setup script and give it to the user account
WORKDIR /src
COPY setup.sh /home/student/
RUN chgrp student /home/student/setup.sh
RUN chown student /home/student/setup.sh

# add a line to the bashrc for interactive shell sessions
USER student
RUN echo "bash ~/setup.sh /src ~/proj" >/home/student/.bashrc
RUN mkdir /home/student/proj

# run tests
WORKDIR /home/student/proj
CMD ["/bin/bash","-c","~/setup.sh /src ~/proj && make test"]

