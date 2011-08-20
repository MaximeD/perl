#!/usr/bin/env perl
print "Choose a word to repeat\n" ;
$word = <STDIN> ;

print "How many time shall we repeat it ?\n" ;
$times = <STDIN> ;

print $word x $times ;
