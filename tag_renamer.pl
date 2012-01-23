#!/usr/bin/env perl
use warnings;
use strict;
use utf8;
binmode(STDIN, ":utf8");
binmode(STDOUT, ":utf8");
binmode(STDERR, ":utf8");

use Cwd;
use File::Copy;

# Music::Tag will recognize mp3, ogg, flac, ...
# to get it work cpan -i Music::Tag::MP3 Music::Tag::OGG ...
use Music::Tag;


# first, go to the right dir
foreach my $dir (@ARGV) {
  chdir $dir or die "$!\n";
}

my $dir = cwd();
my @songs ;
my ($title, $track, $artist, $album, $comment, $year, $genre);

my @files = glob("*.{mp3,ogg}");

foreach (@files) {
   my $info = Music::Tag->new($_);
   $info->get_tag();

  $_ =~ /\.(?<extension>[^.]*)$/ ;
  my $extension = $+{extension} ;

   my $track = $info->track();
  # clean track number
  if ($track eq "") {
    $track = "00" ;
  }
  else {
    $track =~ s/(\d+?)\/\d+/$1/ ;
    $track =~ s/^(\d)$/0$1/ if ($track =~ /^(\d)$/);
  }

  $info->close();

  push @songs, {
	       name       => $_ ,
	       title      => $info->title(),
	       track      => $track,
	       artist     => $info->artist(),
	       album      => $info->album(),
	       year       => $info->year(),
	       genre      => $info->genre(),
	       extension  => $extension
	      } ;
}

# get infos about album and print them
my $album_info = $songs[0]{artist} . "/" if $songs[0]{artist} ne "";
$album_info .= $songs[0]{year} . ". " if $songs[0]{year} ne "";
$album_info .= $songs[0]{album} if $songs[0]{album} ne "";

if (defined $album_info) {
  print "$album_info" ;
  if ($songs[0]{genre} ne "") {
    print " (" . $songs[0]{genre} .")\n";
  }
  else {
    print "\n";
  }
}

# check if current name appears to be right
my $need_to_change = 0 ;
for my $song(@songs) {
  my $new_name = "$song->{track}. $song->{title}.$song->{extension}" ;

  if ($song->{name} ne $new_name) {
    $need_to_change = 1;
    printf "\t%s %90s\n", $new_name, "<- $song->{name}";
  }
  else {
    print "\t$new_name\n";
  }
}

# ask if it is needed and ok to rename
if ($need_to_change == 1) {
  print "\nRename files according to this ?\n";
  if (<STDIN> =~ /^y/) {
    for my $song(@songs) {
      my $new_name = "$song->{track}. $song->{title}.$song->{extension}" ;
      move($song->{name}, $new_name);
    }
    print "Done!\n";
  }

  else {
    die "Not doing anything\n";
  }
}

# renaming dir too
my $current_dir = $dir;
$current_dir  =~ s!.+/(.+)$!$1! ;
my $dir_name = $songs[0]{year} . ". " . $songs[0]{album};
if ($current_dir ne $dir_name) {
  print "Rename?\n $current_dir -> $dir_name\n";
  if (<STDIN> =~ /^y/) {
    chdir "../";
    move($current_dir, $dir_name);
    print "Done!\n";
  }
  else {
    die "Not doing anything\n";
  }
}
