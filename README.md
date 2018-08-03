# Simple test framework

This is a simple testing framework for C99 on Linux, intended to be used in an
academic course. It uses the [Check](https://libcheck.github.io/check/)
framework for unit testing, some custom Bash scripts for integration testing,
and the [Memcheck](http://valgrind.org/docs/manual/mc-manual.html)
Valgrind-based tool for finding memory leaks.

## Getting started

### Prerequisites

You will need to install the Check framework
([instructions](https://libcheck.github.io/check/web/install.html)) in order to
use this framework. If you are running this on a departmental server you will
probably need to contact your sysadmin to install the software. Fortunately, it
is a standard package on most major Linux distributions.

### Installing

Clone this repository in your home directory and begin working. If you wish to
use our grading scripts you will need to set up submission folders in a
particular way; see the appropriate section below for more details.

## Using the framework

### Basics

The project sources are in the `ref` folder. There are two provided projects:

* `pT-blank` - A mostly-empty project with the barebones necessary for a new
  project. Copy this folder to start a new project from scratch.

* `p0-intro` - A minimal project with a few required routines and I/O
  specifications. Several unit and integration tests are provided along with a
  [project description](www/p0-intro.html).

To build and test both of the reference solutions, run `make test` in the
`ref` folder.

To create a new project, simply copy the `pT-blank` folder in its entirety to a
new folder and begin working. You will probably wish to change the filenames
first, and with that you will need to change the includes and Makefiles
appropriately. You should be able to search for "`pT-blank`" to find all of the
necessary locations.

The build system is a simple Makefile with support for multiple modules as well
as pre-compiled objects. The latter is useful when projects build on each other;
you can distribute stripped object files so that students who were unable to
fully complete the first project can still complete the second. Note that
optimization is disabled by default to make debugging easier; this is not a
framework requirement.

All of the testing code for each project is in the `tests` subfolder. The
framework is intended to be self-contained (with only the Check dependency) and
so there is some duplication between projects. See sections below for further
details about how the tests work and for instructions on adding new tests.

### Unit tests

Unit tests are intended to test individual routines (and their dependencies),
and they are written in C using the [Check](https://libcheck.github.io/check/)
framework. Often, the code for these tests tends to resemble the solution, so it
is desirable to distribute these tests without their source. Thus, there are two
main unit testing files: `public.c` and `private.c`. The former is distributed
as-is so that the students can see how the test is written, and the latter is
distributed as a stripped object file so that students can run the tests and see
the results but they do not have access to the source code.

Tests are delimited using the `START_TEST` and `END_TEST` macros provided by
Check. Testing expressions are written using Check assertion routines
([documentation](https://libcheck.github.io/check/doc/doxygen/html/check_8h.html)).
Here is an example from the template project:

```c
START_TEST (C_addabs_simple)
{
    ck_assert_int_eq (add_abs(2,3), 5);
}
END_TEST
```

To add new tests, create a new routine in the appropriate file delimited by the
appropriate macros and give it a unique name (provided as a parameter to the
`START_TEST` macro). You will also need to add a `tcase_add_test` line at the
bottom of the file for your new test.

Aside: we use a test naming scheme where tests are labeled with a prefix
containing the grade corresponding to the test; i.e., students must pass **all**
`D_*` tests to receive a "D" grade, all of those plus all `C_*` tests to receive
a "C" grade, etc. This is not a requirement of the testing framework itself, but
the grading script does use it to automatically assign baseline grades based on
test results.

There is also a `testsuite.c` driver, but it is very generic and does not
generally need to be modified.

### Integration tests

Integration tests are intended to test whole-program behavior and are written
using input/output file pairs. The inputs are stored in the `inputs` folder and
the expected outputs are stored in the `expected` folder. Tests are specified in
the `itests.include` file, which contains one line for each integration test
that specifies the name of the test (the output file must match this) as well as
the command line intended to evoke the corresponding output. The actual testing
is handled by the `integration.sh` Bash script, which should not need to be
modified when creating a new project except to change the executable name at the
top.

To add a new integration test: 1) put any necessary input (not all integration
tests require an input file; e.g., if all parameters are provided on the command
line) in the `inputs` folder, 2) put the required output in a text file in the
`expected' folder, and 3) add a corresponding line to `itests.include`.

Note that there is no "code" for integration tests and thus there are no
"private" integration tests. If you wish to have integration tests that you do
not distribute, we recommend maintaining two different copies of your reference
solution and use symlinks for all files except `itests.include` and the
additional test files.

Because memory management is such an important part of coding in a low-level
language, the script also runs each test in Valgrind/Memcheck to check for
memory leaks.  If you do not have Valgrind installed or wish to skip these
tests, you can comment out the offending calls in `integration.sh`.

### Distributions

Scripts are provided in the `dist` folder for building project distributions.
These scripts remove solution code and package up the project into a tarball.
For convenient testing, it also saves a snapshot of both the distribution files
and the full solution.

To mark solution code for removal, surround it with `BEGIN_SOLUTION` and
`END_SOLUTION` one-line comments. If the removal of the code would result in
invalid code (e.g., no return value), you can use a `BOILERPLATE` tag to provide
alternative code for the distribution. Here is an example from the template
project:

```c
int add (int num1, int num2)
{
    // BEGIN_SOLUTION
    return num1 + num2;
    // END_SOLUTION
    // BOILERPLATE: return 0;
}
```

In the distribution, this will be converted to:

```c
int add (int num1, int num2)
{
    return 0;
}
```

To create distribution files for a new project, copy `rebuild-pT.sh` in the
`dist` folder and make any appropriate changes (file names, new files, etc.).
Make sure you use the provided "`cleanup`" function to copy any files that
contain source code. If you are providing prebuilt object files containing
solutions to a previous project, make sure you `strip -S` them after copying
them into the distribution folder.

We recommend double-checking the distribution files **every time** you rebuild
them to ensure you are not accidentally distributing solution code because of
some framework misconfiguration.

### Grading

A sample grading script has been provided in `/grading/grade.sh`. To use this
folder, you will need to collect student submissions using a specific file
structure. There must be a root submissions folder with subfolders for each
student (we use the students' login IDs as subfolder names). Each student
subfolder should then have a subfolder for each project containing the actual
submission files. Each of these subsubfolders must have a unique project
identifier (e.g., '`p0`', '`p1`', etc.).

You must also create a `project.include` file (in the current folder wherever
you wish to run the tests, but we recommend it NOT be in the submissio folder)
containing filename and path information specific to your project. See the [p0
file](grading/p0/project.include) for an example of what this file should look
like. You will need to change all of the files and paths to match your setup:

* `TAG` is the unique project identifier.
* `EXE` is the name of the compiled binary.
* `FILES` is a list of submission files to be copied into the results folder.
* `REFFILES` is a list of reference testing files to be copied into the results
  folder (this is to prevent the student from altering the test files).
* `REF` is an absolute path to the project reference files.
* `SUBMIT` is an absolute path to the root student submission folder, which
  should contain student subfolders and project subsubfolders as described
  above.
* `RESULTS` is an absolute path to a folder where all of the results can be
  copied.

When the script is run, it copies all of the student submissions along with
testing files into subfolders in `RESULTS`. It then builds and runs all tests on
all submissions. The results are printed to standard output, which we usually
redirect to a file for further processing (our post-processing scripts are too
institution-specific to be of use to anyone else and so we are not distributing
them here).

### Docker containers

Containers allow you to run this framework on non-supported platforms. See the
[README.md](docker/README.md) for more info.

## Contributing

If you wish to contribute, please first discuss the change you wish to make via
issue, email, or any other method with the owners of this repository. We may
decide to incorporate your contributions in our project or we may suggest that
you maintain them as a fork.

## Authors

The primary developer (and current maintainer) of this project is [Mike
Lam](https://github.com/lam2mo), and the code was based on an older framework
written by Michael Kirkpatrick. Both authors are faculty at [James Madison
University](https://github.com/JMU-CS).

## License

This project is licensed under the MIT License - see the
[LICENSE.txt](LICENSE.txt) file for details.

