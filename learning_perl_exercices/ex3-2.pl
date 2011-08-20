#! /usr/bin/env perl

# Hardcoded
@pers = qw/fred betty barney dino wilma pebbles bamm-bamm/ ;


# Reads input
print "Enter some numbers from 1 to 7, one per line, then press Ctrl-D:\n";
chomp(@numbers = <STDIN>) ;

print "@pers[@numbers] \n" ;

