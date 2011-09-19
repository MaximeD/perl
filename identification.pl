#!/usr/bin/env perl

use strict ;
use warnings ;

my $name ;
my $valid_name ;

chomp($valid_name = qx /whoami/) ;

print "Hi, what's your name ?\n" ;
chomp($name = <STDIN>) ;

if ($name =~ /$valid_name*/i) # username (case insensitive) and any char
{
    print "Greetings master !\n" ;
}

else
{
    print "Get away $name, you don't belong here\n";
}
