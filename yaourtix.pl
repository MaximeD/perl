#! /usr/bin/env perl
use strict ;
use warnings ;

# get the input of eix
my @eix = `eix -c $ARGV[0]`;
pop @eix ; # last line is the number of match, we don't really care

# transform every result in a hash
my $number = 1 ;
for my $ebuild(@eix) {
    $ebuild =~ /
		 \[(?<status>.)\]      # status
		 \s(?<cat>.+?-.+)\/    # category
		 (?<package>.+?)\s     # package
#		 (:?.*)+               # layman
		 \((?<version>.+?)\):  # version
		 \s(?<desc>.*)         # description
	       /x ;

    $ebuild = {
	       number      => "\e[1;34m$number)\e[0m",
	       package     => "$+{package}",
	       cat         => $+{cat},
	       version     => "$+{version}\e[0m",
	       status      => "$+{status}\e[0m",
	       description => $+{desc}
	      } ;

    $number++ ;
}

for (my $i = 0 ; $i < scalar(@eix) ; $i++) {
  # version
  if ($eix[$i]{version} =~ /~/) {
    $eix[$i]{version} = "\e[1;33m$eix[$i]{version}";
  }
  elsif ($eix[$i]{version} =~ /M|--/) {
    $eix[$i]{version} = "\e[1;31m$eix[$i]{version}";
  }
  else {
    $eix[$i]{version} = "\e[0;32m$eix[$i]{version}";
  }


  if ($eix[$i]{status} =~ /I/ ) {
    $eix[$i]{status} = "\e[1;90m\e[42m$eix[$i]{status}";
  }
  elsif ($eix[$i]{status} =~ /U/ ) {
    $eix[$i]{status} = "\e[1;90m\e[46m$eix[$i]{status}";
  }
  else {
    $eix[$i]{status} = "\e[0;32m$eix[$i]{status}";
  }

}

for (my $i = 0 ; $i < scalar(@eix) ; $i++) {
  print "$eix[$i]{number} " ;
  print "$eix[$i]{cat}/\e[1;37m$eix[$i]{package}\e[0m " ;
  print "($eix[$i]{version}) " ;
  print "[$eix[$i]{status}]\n" ;
  print "\t$eix[$i]{description}\n";
}

# emerge part
print "\nWhich packages would you like to emerge ?\n" ;
chomp(my $choice = <STDIN>) ;
die if $choice !~ /\d/;

my @emerge_list = split (/[ ,]*/, $choice) ;

my $packages ;
foreach my $number(@emerge_list){
  $number -= 1 ;
  $packages .= " $eix[$number]{cat}/$eix[$number]{package}";
}

system("sudo emerge -av $packages");

