#include "fast_try.h"

VALUE rb_mFastTry;

void
Init_fast_try(void)
{
  rb_mFastTry = rb_define_module("FastTry");
}
