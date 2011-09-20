#!/usr/bin/env perl

# A converter for LaTeX
# This script will convert raw data
# to an usable *.tex output

# Usage : pass the file you want to convert as an argument,
# and the output will be what you can paste in your tex file.

# v1.0 2011/09/20
# Distributed under the GNU/GPL

my $newline_char = "[\.,!?:;]" ; # characters that will be followed by a newline
my $space_char = "[!?:;]" ; # characters that should be preceeded by a ~

# opens file given as argument
while( my $file = <> )
{
    # Add \\ for a brand new paragraph
    $file =~ s/\A\n/\\\\\n\n/g ;
    # Add a new \n for a simple new paragraph 
    $file =~ s/(\n)/$1\n/g ;
    # Will split on a new line after each special char
    $file =~ s/($newline_char) /$1\n/g ;
    # Add a ~ between word and special char
    $file =~ s/(\w+)($space_char)/$1~$2/g ;
    # Remove the space between word and ~
    $file =~ s/ ($space_char)/~$1/g ;
    # Format dates in a LaTeX style
    $file =~ s/(\d)(\d{3})/$1\\,$2/g ;

  print $file ;
}
