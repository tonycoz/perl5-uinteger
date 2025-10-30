#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

/* Stolen from XS::Parse::Sublike, who stole it from op.c */
#ifndef OpTYPE_set
#  define OpTYPE_set(op, type)         \
    STMT_START {                       \
      op->op_type   = (OPCODE)type;    \
      op->op_ppaddr = PL_ppaddr[type]; \
    } STMT_END
#endif

typedef OP *(*checker_type)(pTHX_ OP *o);
static checker_type next_add_checker;
static checker_type next_subtract_checker;
static checker_type next_multiply_checker;

static bool
in_uinteger(pTHX) {
  SV **entry = hv_fetchs(GvHV(PL_hintgv), "uinteger", 0);
  return entry && SvTRUE(*entry);
}

static OP *
integer_checker(pTHX_ OP *op, checker_type next) {
  if (in_uinteger(aTHX)) {
    OpTYPE_set(op, op->op_type+1);
    // newBINOP skips this if we change the opcode
    if (!op->op_targ)
      op->op_targ = pad_alloc(op->op_type, SVs_PADTMP);
    // missing fold_constants too
  }
  else {
    op = next(aTHX_ op);
  }
  return op;
}

static OP *
add_checker(pTHX_ OP *op) {
  return integer_checker(aTHX_ op, next_add_checker);
}

static OP *
subtract_checker(pTHX_ OP *op) {
  return integer_checker(aTHX_ op, next_add_checker);
}

static OP *
multiply_checker(pTHX_ OP *op) {
  return integer_checker(aTHX_ op, next_multiply_checker);
}

static void
init_ops(pTHX) {
  wrap_op_checker(OP_ADD, add_checker, &next_add_checker);
  wrap_op_checker(OP_SUBTRACT, subtract_checker, &next_subtract_checker);
  wrap_op_checker(OP_MULTIPLY, subtract_checker, &next_subtract_checker);
}

MODULE = uinteger PACKAGE = uinteger

BOOT:
  init_ops(aTHX);
