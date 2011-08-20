#! /usr/bin/env perl

chomp(@lines = <STDIN>) ;
@lines = reverse @lines ;

print "\n\tReverse order :\n";
foreach $lines (@lines) {
    print "$lines\n" ;
}
