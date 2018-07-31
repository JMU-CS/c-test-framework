#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#include <check.h>

#include "../p0-intro.h"

/* simple addition */
START_TEST (C_addabs_simple)
{
    ck_assert_int_eq (add_abs(2,3), 5);
}
END_TEST

/* simple factorials */
START_TEST (B_factorial_simple)
{
    ck_assert_int_eq (factorial(1), 1);
    ck_assert_int_eq (factorial(2), 2);
    ck_assert_int_eq (factorial(3), 6);
    ck_assert_int_eq (factorial(4), 24);
    ck_assert_int_eq (factorial(5), 120);
    ck_assert_int_eq (factorial(6), 720);
}
END_TEST

/* simple array access */
START_TEST (B_sumarray_simple)
{
    int nums[4];
    nums[0] = 2;
    nums[1] = 8;
    nums[2] = 5;
    nums[3] = 11;
    ck_assert_int_eq (sum_array(nums, 4), 26);
}
END_TEST

void public_tests (Suite *s)
{
    TCase *tc_public = tcase_create ("Public");
    tcase_add_test (tc_public, C_addabs_simple);
    tcase_add_test (tc_public, B_factorial_simple);
    tcase_add_test (tc_public, B_sumarray_simple);
    suite_add_tcase (s, tc_public);
}

