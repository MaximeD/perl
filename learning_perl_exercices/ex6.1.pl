#!/usr/bin/env perl

use warnings ;
use strict ;

my %name = (
	    fred => 'flintstone',
	    barney => 'rubble',
	    wilma => 'flinstone',
	   ) ;


print "Who's family name do you want to know ?\n" ;
chomp(my $fname = <STDIN>) ;


print "Ok $fname name is $name{$fname}\n" ;
