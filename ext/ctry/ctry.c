#include "ruby.h"

VALUE
rb_obj_try(int argc, VALUE *argv, VALUE self)
{
  if (argc != 0 && !RTEST(rb_funcall(self, rb_intern("respond_to?"), 1, argv[0]))) {
    return Qnil;
  }

  if (argc == 0 && rb_block_given_p()) {
    VALUE a, b;
    rb_scan_args(argc, argv, "*&", &a, &b);

    if (FIX2INT(rb_funcall(b, rb_intern("arity"), 0)) == 0) {
      return rb_funcall_passing_block(self, rb_intern("instance_eval"), 0, 0);
    } else {
      return rb_yield(self);
    }
  } else {
    return rb_funcall_passing_block(self, rb_intern("public_send"), argc, argv);
  }
}

VALUE
rb_obj_try_bang(int argc, VALUE *argv, VALUE self)
{
  if (argc == 0 && rb_block_given_p()) {
    VALUE a, b;
    rb_scan_args(argc, argv, "*&", &a, &b);

    if (FIX2INT(rb_funcall(b, rb_intern("arity"), 0)) == 0) {
      return rb_funcall_passing_block(self, rb_intern("instance_eval"), 0, 0);
    } else {
      return rb_yield(self);
    }
  } else {
    return rb_funcall_passing_block(self, rb_intern("public_send"), argc, argv);
  }
}

VALUE
nil_try(int argc, VALUE *argv, VALUE self)
{
  return Qnil;
}

void
Init_ctry(void)
{
  rb_define_method(rb_cObject, "try", rb_obj_try, -1);
  rb_define_method(rb_cObject, "try!", rb_obj_try_bang, -1);
  rb_define_method(rb_cNilClass, "try", nil_try, -1);
  rb_define_method(rb_cNilClass, "try!", nil_try, -1);
}
