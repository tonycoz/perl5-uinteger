package uinteger;
use strict;
use integer ();

our $VERSION = "0.001";

XSLoader::load(__PACKAGE__);

sub import {
  $^H &= ~$integer::hint_bits;
  $^H{uinteger} = 1;
}

sub unimport {
  $^H{uinteger} = 0;
}

1;
