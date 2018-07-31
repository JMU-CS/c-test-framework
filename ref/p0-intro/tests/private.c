#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#include <check.h>

#include "../p0-intro.h"

/* negative integer addition */
START_TEST (B_addabs_negative_ints)
{
    ck_assert_int_eq (add_abs(2,-4), 6);
}
END_TEST

/* factorial edge cases */
START_TEST (A_factorial_edge_cases)
{
    ck_assert_int_eq (factorial(0), 1);
    ck_assert_int_eq (factorial(10), 3628800);
    ck_assert_int_eq (factorial(-1), 1);
    ck_assert_int_eq (factorial(-42), 1);
}
END_TEST

/* zero sum array */
START_TEST (A_sumarray_zero)
{
    int nums[3];
    nums[0] = 5;
    nums[1] = -2;
    nums[2] = -3;
    ck_assert_int_eq (sum_array(nums, 3), 0);
}
END_TEST

/* empty array */
START_TEST (A_sumarray_empty_array)
{
    int nums[1];
    ck_assert_int_eq (sum_array(nums, 0), 0);
}
END_TEST

/* null array pointer */
START_TEST (A_sumarray_null_pointer)
{
    ck_assert_int_eq (sum_array(NULL, 0), 0);
}
END_TEST

void private_tests (Suite *s)
{
    TCase *tc_private = tcase_create ("Private");
    tcase_add_test (tc_private, B_addabs_negative_ints);
    tcase_add_test (tc_private, A_factorial_edge_cases);
    tcase_add_test (tc_private, A_sumarray_zero);
    tcase_add_test (tc_private, A_sumarray_empty_array);
    tcase_add_test (tc_private, A_sumarray_null_pointer);
    suite_add_tcase (s, tc_private);
}

