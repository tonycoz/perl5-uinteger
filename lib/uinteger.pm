package uinteger;
use strict;
use warnings;
use integer (); # for the hints mask

our $VERSION = "0.001";

XSLoader::load(__PACKAGE__);

sub import {
  # turning "use integer" off means we use the default versions of
  # most bitops, which mostly treat values as UVs (unsigned), while
  # use integer treats then as IVs (signed)
  $^H &= ~$integer::hint_bits;
  $^H{uinteger} = 1;
}

sub unimport {
  $^H{uinteger} = 0;
}

1;

=head1 NAME

uinteger - like "use integer", but unsigned

=head1 SYNOPSIS

  use uinteger;
  print 1 - 2; # print a large number

=head1 DESCRIPTION

Rewrites add, subtract and multiply in C<use integer> context to
perform the operation as if the number was an unsigned integer (a Perl
C<UV>).

Negative numbers are treated as their 2's complement representation.

For now really only a proof of concept, this requires a very recent
perl to build since it uses the C<PERL_RC_STACK> stack manipulation
functions, which aren't in F<ppport.h> yet.

=head1 AUTHOR

Tony Cook <tony@develop-help.com>

=cut
