/*
 * CS 261 PA0: Intro project
 *
 * Name: 
 */

#include "p0-intro.h"

int add_abs (int num1, int num2)
{
    // BEGIN_SOLUTION
    return abs(num1) + abs(num2);
    // END_SOLUTION
    // BOILERPLATE: return 0;
}

int factorial (int num)
{
    // BEGIN_SOLUTION
    int fact = 1;
    for (int x = 2; x <= num; x++) {
        fact *= x;
    }
    return fact;
    // END_SOLUTION
    // BOILERPLATE: return 0;
}

int sum_array (int *nums, size_t n)
{
    // BEGIN_SOLUTION

    int sum = nums[0];
    for (int i = 1; i < n; i++) {
        sum += nums[i];
    }
    return sum;

    // END_SOLUTION
    // BOILERPLATE: return -1;
}

