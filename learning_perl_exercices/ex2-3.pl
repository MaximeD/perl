#!/usr/bin/env perl

print "Calcul du périmètre d'un cercle\n";

print "Quel est le rayon du cercle ?\n";
chomp ($radius = <STDIN>) ;

if ($radius < 0) {
    print "Votre rayon est négatif !\n";
}
else {
    print "\nCalcul du périmètre d'un cercle de rayon $radius cm:\n" ;
    $pi = 3.141592654 ;
    $circum = $radius * 2 * $pi ;
    print "Le périmètre de ce cerle est d'environ :
    \t$circum cm\n";
}
