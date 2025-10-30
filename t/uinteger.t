#!perl
use strict;
use warnings;
use Test::More;

{
  use uinteger;
  is(1.25+1, 2, "lexically on");
  no uinteger;
  is(1.25+1, 2.25, "lexically off");
}
is(1.25+1, 2.25, "still lexically off");

use uinteger;

is(2-3, ~0, "subtract to get a large number");
is(~0 *2, ~1, "multiply (UV)(-1) by 2");
is(~0 + ~0, -2|0, "add two large numbers");

done_testing();
