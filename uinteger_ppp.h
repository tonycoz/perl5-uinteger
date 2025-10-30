#ifndef UINTEGER_PPP_H
#define UINTEGER_PPP_H

/* functions which should be in ppport.h */

#ifndef rpp_try_AMAGIC_2
#define rpp_try_AMAGIC_2(method, flags) \
  Perl_rpp_try_AMAGIC_2(aTHX_ method, flags)

PERL_STATIC_INLINE bool
Perl_rpp_try_AMAGIC_2(pTHX_ int method, int flags)
{
    return    UNLIKELY(((SvFLAGS(PL_stack_sp[-1])|SvFLAGS(PL_stack_sp[0]))
                     & (SVf_ROK|SVs_GMG)))
           && Perl_try_amagic_bin(aTHX_ method, flags);
}

#endif

#ifndef rpp_replace_2_1_COMMON
#define rpp_replace_2_1_COMMON(sv) Perl_rpp_replace_2_1_COMMON(aTHX_ sv)

PERL_STATIC_INLINE void
Perl_rpp_replace_2_1_COMMON(pTHX_ SV *sv)
{

    assert(sv);
    *--PL_stack_sp = sv;
}

#endif

#ifndef rpp_replace_2_1_NN
#define rpp_replace_2_1_NN(sv) Perl_rpp_replace_2_1_NN(aTHX_ sv)

PERL_STATIC_INLINE void
Perl_rpp_replace_2_1_NN(pTHX_ SV *sv)
{
    //PERL_ARGS_ASSERT_RPP_REPLACE_2_1_NN;

    assert(sv);
#ifdef PERL_RC_STACK
    SvREFCNT_inc_simple_void_NN(sv);
#endif
    rpp_replace_2_1_COMMON(sv);
}

#endif

#endif
