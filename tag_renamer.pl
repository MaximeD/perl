#!/usr/bin/env perl
use warnings;
use strict;

use File::Copy;
use MP3::Tag; # you'll probably to install this one

# first, go to the right dir
foreach my $dir (@ARGV) {
    chdir $dir or die ;
}

# get list of mp3 infos
my @mp3s ;
my ($title, $track, $artist, $album, $comment, $year, $genre);
&tag("get_infos") ;

# print'em
print "$artist/$year. $album ($genre)\n";

for my $mp3(@mp3s) {
    print "\t$mp3->{track}. $mp3->{title}\n";
}

# ask if it is ok to rename
print "\nRename files according to this ?\n";
if (<STDIN> =~ /^y/) {
    &tag("rename") ;
    print "Done!\n";
}

else {
    die "Not doing anything\n";
}

sub tag {
    while (<*.mp3>) {
	my $mp3 = MP3::Tag->new($_);
	($title, $track, $artist, $album, $comment, $year, $genre) = $mp3->autoinfo();

	# clean track number
	$track =~ s/(\d+?)\/\d+/$1/ ;

	if ($_[0] eq "get_infos"){
	    push @mp3s, {  title   => $title,
			   track   => $track,
			   artist  => $artist,
			   album   => $album,
			   year    => $year,
			   genre   => $genre
	    } ;
	}

	if ($_[0] eq "rename"){
	    # I like tags to be like the following : "track. name"
	    my $new_name = $track . ". " . $title . ".mp3";

	    # Rename the files
	    move($_, $new_name);
	    
	    # now remove comments
	    $mp3->close();
	}
    }
}
