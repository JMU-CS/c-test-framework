#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#include <check.h>

#include "../pT-blank.h"

/* negative integer addition */
START_TEST (B_add_negative)
{
    ck_assert_int_eq (add(2,-4), -2);
}
END_TEST

void private_tests (Suite *s)
{
    TCase *tc_private = tcase_create ("Private");
    tcase_add_test (tc_private, B_add_negative);
    suite_add_tcase (s, tc_private);
}

