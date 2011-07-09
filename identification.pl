#!/usr/bin/env perl
use warnings;

print "Salut, c'est quoi ton petit nom ?\n" ; $name = <STDIN>;
chomp $name;

if ($name =~ /^max\b/i or $name =~ /^maxime\b/i) # mon accueil
{
    print "Bonjour maître, mes salutations\n";
}

elsif ($name =~ /^[ck]lem/i)                     # spécial klem
{
    print "Va plutôt jouer avec ton hamster $name...\n";
}

else                                             # n'importe quel autre
{
    print "Hé $name pas touche à mon ordi!\ngrrr\n";
}
