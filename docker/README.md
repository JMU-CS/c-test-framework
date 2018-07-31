# Dockerfiles for CS 261 projects

The files in these subfolders facilitate the compilation and testing of the CS
261 projects in Docker containers, allowing both instructors and students to use
a different operating system than the standard Ubuntu/Mint setup present in the
JMU labs (and on `stu`).

## Base image

Before any of the other docker images can be built or run, you must first build
the base image from the `base` folder. This image contains the core packages (on
top of the basic Ubuntu image) that are needed for the CS 261 projects. It is
very important to give it the `cs261` tag using the `-t` option so that the
other images can be built using it:

    docker build -t cs261 .

## Distribution image

Instructors can use the distribution image to build distribution files for all
projects. First, build the image from the `dist` folder:

    docker build -t cs261-dist .

Then, run the image from the `proj` folder (parent of this folder). You'll need
to mount that folder to `/src` in the container using the `-v` option:

    docker run -v$(pwd):/src cs261-dist

CAUTION: This will make changes to your host filesystem.

## Testing image

The testing image can be used to run the standard project test suite for any of
the course projects. First, build the image from the `test` folder:

    docker build -t cs261-test .

Then, run the image from any project folder. You'll need to mount that folder to
`/src` in the container using the `-v` option:

    docker run -v$(pwd):/src cs261-test

## Debugging image

The testing image can be used to edit, test, and debug any of the course
projects interactively, without having an Ubuntu-based system or virtual
machine. First, build the image from the `debug` folder:

    docker build -t cs261-debug .

Then, run the image from any project folder. You'll need to mount that folder to
`/src` in the container using the `-v` option, and you'll want to run it in
interactive mode with the `-it` options:

    docker run -it -v$(pwd):/src cs261-debug

CAUTION: Any changes you make to the `/src` filesystem in the container will
also happen in your host filesystem.

This image provides `nano` and `vim` for editing and `gdb` for debugging. If you
have other preferred software, you can customize the image by changing the list
of packages on the `apt-get install` line.

