#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#include <check.h>

#include "../p0-intro.h"

/* negative integer addition */
START_TEST (A_addabs_both_negative_ints)
{
    ck_assert_int_eq (add_abs(-2,-4), 6);
}
END_TEST

START_TEST (A_sumarray_single_int) 
{
    int num = 5;
    ck_assert_int_eq (sum_array(&num, 1), 5);
}
END_TEST

void hidden_tests (Suite *s)
{
    TCase *tc_hidden = tcase_create ("Hidden");
    tcase_add_test (tc_hidden, A_addabs_both_negative_ints);
    tcase_add_test (tc_hidden, A_sumarray_single_int);
    suite_add_tcase (s, tc_hidden);
}
