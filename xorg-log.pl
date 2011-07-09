#!/usr/bin/env perl
#
########################################################
# Affiche un condensé du log de Xorg		       #
# qui ne présente que les avertissement et les erreurs #
########################################################
use strict;
use warnings;

# ouverture du fichier    
open(my $xorg, '< /var/log/Xorg.0.log') or die "Impossible ouvrir le fichier";

# lecture et affichage
while( <$xorg> )
{
    if ($_ =~ /\(EE/ or /\(WW/
	&& s/^.{13}//)
    { # n'afficher que les lignes contenant (EE ou (WW
	print "$_";
    }
}

