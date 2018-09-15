/*
 * CS 261: Intro project driver
 *
 * Name: 
 */

#include "p0-intro.h"

int main (int argc, char **argv)
{
    if (argc == 2 && strcmp(argv[1], "-g") == 0) {
        printf("Goodbye!\n");
    } else {
        printf("Hello, world!\n");
    }
    return EXIT_SUCCESS;
}

