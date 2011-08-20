#! /usr/bin/env perl

print "Enter various strings, then press CTRL+D\n" ;
chomp(@lines = <STDIN>) ;

print "\nOkay, now we'll sort them alphabetically :\n" ;
@sorted = sort @lines ;
print "@sorted\n" ;

