#!/usr/bin/env perl
 
# Simple interface for TreeTagger
# You will need the original treetagger :
# http://www.ims.uni-stuttgart.de/projekte/corplex/TreeTagger/

# TODO :
# modify every weird stuff for TreeTagger
# like a " following a '

########################
#  Available langages  #
########################
chomp(@lang = qx (ls lib/*.par)) ;

$lang = join(" ",@lang) ;
$lang =~ s/lib\///gi;
$lang =~ s/\.par//gi;

print "Installed languages are : $lang\n" ;
print "Please enter the original language of the text :\n";
chomp($text_lang = <STDIN>) ;
###########################################################



##########
# export #
##########
open (TAGGED, '>pouet.txt');      # original file
open (UNKNOWN, '>unknown.txt');   # every unknown
###########################################################

#################
#  TreeTagging  #
#################
@file = <> ;
@tag = qx (echo '@file' | cmd/tree-tagger-$text_lang) ;
print TAGGED @tag ;

@unknown = grep(/<unknown>/, @tag);

my %unique = @unknown ; # convert to hash to remove duplicates

%unique = sort(%unique);

print UNKNOWN %unique ;

