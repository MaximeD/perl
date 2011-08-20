#!/usr/bin/env perl

print "This program will calculate the circumference of a circle\n";

print "What is the radius of your circle ? (in cm)\n";
chomp ($radius = <STDIN>) ;

$pi = 3.14 ;
$circum = $radius * 2 * $pi ;

if ($radius < 0) {
    print "\nSorry, a negative number will return a value of 0 !\n" ;
}

else {
    print "\nOkay, the circumference of this circle is :
           \t$circum cm\n";
}
