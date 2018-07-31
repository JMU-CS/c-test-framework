FROM cs261
LABEL name="CS261-Dist"
LABEL maintainer="Mike Lam <lam2mo@jmu.edu>"
LABEL description="JMU CS261 Y86 Project Distribution Image (instructors only)"
LABEL architecture="x86_64"
LABEL version="1.0"

# run tests
WORKDIR /src/dist
CMD ["bash","rebuild-all.sh"]

# NOTE: this image should be run from the root 'proj' folder, because it needs
# to access both the 'dist' and 'ref' subfolders

