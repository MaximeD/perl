#!/usr/bin/env perl
use warnings;
use strict;

use File::Copy;
use MP3::Tag; # you'll probably to install this one

# first, go to the right dir
foreach my $dir (@ARGV) {
    chdir $dir or die "$!\n";
}

my @mp3s ;
my ($title, $track, $artist, $album, $comment, $year, $genre);

my @files = glob("*.{mp3,ogg}");

foreach (@files) {
  my $mp3 = MP3::Tag->new($_);
  ($title, $track, $artist, $album, $comment, $year, $genre) = $mp3->autoinfo();
  $_ =~ /\.(?<extension>[^.]*)$/ ;
  my $extension = $+{extension} ;

  # clean track number
  $track =~ s/(\d+?)\/\d+/$1/ ;
  $track =~ s/^(\d)$/0$1/ if ($track =~ /^(\d)$/);

  $mp3->close();

  push @mp3s, {
	       name       => $_ ,
	       title      => $title,
	       track      => $track,
	       artist     => $artist,
	       album      => $album,
	       year       => $year,
	       genre      => $genre,
	       extension  => $extension
	      } ;
}


my $album_info = $artist . "/" . $year . ". " . $album;
$album_info .= " (" . $genre .")" if $genre ne "";
print "$album_info\n";

my $need_to_change = 0 ;
for my $mp3(@mp3s) {
  my $new_name = "$mp3->{track}. $mp3->{title}.$mp3->{extension}" ;

  if ($mp3->{name} ne $new_name) {
    $need_to_change = 1;
    printf "\t%s %90s\n", $new_name, "<- $mp3->{name}";
  }
  else {
    print "\t$new_name\n";
  }
}

# ask if it is needed and ok to rename
if ($need_to_change == 1) {
  print "\nRename files according to this ?\n";
  if (<STDIN> =~ /^y/) {
    for my $mp3(@mp3s) {
      my $new_name = "$mp3->{track}. $mp3->{title}.$mp3->{extension}" ;
      move($mp3->{name}, $new_name);
    }
    print "Done!\n";
  }

  else {
    die "Not doing anything\n";
  }
}
