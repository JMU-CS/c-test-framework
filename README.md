# Simple test framework

This is a simple testing framework for C, intended to be used in an academic
course. It uses the [Check](https://libcheck.github.io/check/) framework for
unit testing and some custom Bash scripts for integration testing.

## Basics

The project sources are in the `ref` folder. There are two provided projects:

* `pT-blank` - A mostly-empty project with the barebones necessary for a
  project. Copy this folder to start a new project from scratch.

* `p0-intro` - A minimal project with a few required routines and I/O
  specifications. Several unit and integration tests are provided along with a
  [project description](www/p0-intro.html) website.

To build and test both of the reference solutions, run `make test` in the
`ref` folder.

Scripts are provided in the `dist` folder for building project distributions.
These scripts remove solution code (marked with `BEGIN_SOLUTION` and
`END_SOLUTION` comments in the reference code) and package up the project into a
tarball.

## Docker containers

Containers allow you to run this framework on non-supported platforms. See the
[README.md](docker/README.md) for more info.

