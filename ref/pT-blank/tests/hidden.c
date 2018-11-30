#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#include <check.h>

#include "../pT-blank.h"

/* negative integer addition */
START_TEST (B_add_both_negative)
{
    ck_assert_int_eq (add(-2,-4), -6);
}
END_TEST

void hidden_tests (Suite *s)
{
    TCase *tc_hidden = tcase_create ("Hidden");
    tcase_add_test (tc_hidden, B_add_both_negative);
    suite_add_tcase (s, tc_hidden);
}

