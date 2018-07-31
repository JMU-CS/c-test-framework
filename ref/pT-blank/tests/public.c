#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#include <check.h>

#include "../pT-blank.h"

/* simple addition */
START_TEST (C_add_simple)
{
    ck_assert_int_eq (add(2,3), 5);
}
END_TEST

void public_tests (Suite *s)
{
    TCase *tc_public = tcase_create ("Public");
    tcase_add_test (tc_public, C_add_simple);
    suite_add_tcase (s, tc_public);
}

