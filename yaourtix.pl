#! /usr/bin/env perl
use strict ;
use warnings ;

# get the input of eix
my @eix = `eix -c $ARGV[0]`;

my @results;
# transform every result in a hash
my $number = 1 ;
for my $ebuild(@eix) {
  if ($ebuild =~ /
		 \[(?<status>.)\]         # status
		 \s(?<cat>.+?-.+)\/       # category
		 (?<package>.+?)\s        # package
		 (:?\[\d\]\s)?            # layman
		 \(
		 (?<version>.+?)
		 (:?@(\d{2}\/){2}\d{4})?  # if installed, compilation date -> I don't care
		 (:?\s\->\s(?<new>.+?))?  # new version : this could be worthwhile
		 \):                      # version
		 \s(?<desc>.*)            # description
	       /x) {


    # $ebuild = {
    push (@results,  {
	       number      => "\e[1;34m$number)\e[0m",
	       package     => "$+{package}",
	       cat         => $+{cat},
	       version     => "$+{version}\e[0m",
	       status      => "$+{status}\e[0m",
	       description => $+{desc},
	       new         => $+{new}
	      }) ;
  }
  $number++ ;
}

for (my $i = 0 ; $i < scalar(@results) ; $i++) {
  ## colors
  # version
  if ($results[$i]{version} =~ /~/) {
    $results[$i]{version} = "\e[1;33m$results[$i]{version}";
  }
  elsif ($results[$i]{version} =~ /M|--/) {
    $results[$i]{version} = "\e[1;31m$results[$i]{version}";
  }
  else {
    $results[$i]{version} = "\e[0;32m$results[$i]{version}";
  }


  if ($results[$i]{status} =~ /I/ ) {
    $results[$i]{status} = "\e[1;90m\e[42m$results[$i]{status}";
  }
  elsif ($results[$i]{status} =~ /U/ ) {
    $results[$i]{status} = "\e[1;90m\e[46m$results[$i]{status}";
  }
  else {
    $results[$i]{status} = "\e[0;32m$results[$i]{status}";
  }

  ## display
  print "$results[$i]{number} " ;
  print "[$results[$i]{status}]\t" ;
  print "$results[$i]{cat}/\e[1;37m$results[$i]{package}\e[0m " ;
  print "($results[$i]{version}" ;
  if (defined $results[$i]{new}) {
    print " -> \e[1;42m$results[$i]{new}\e[0m)\n" ;
  }
  else {
    print ")\n";
  }
  print "\t$results[$i]{description}\n";
}

# emerge part
print "\nWhich packages would you like to emerge ?\n" ;
chomp(my $choice = <STDIN>) ;
die if $choice !~ /\d/;

my @emerge_list = split (/[ ,]*/, $choice) ;

my $packages ;
foreach my $number(@emerge_list){
  $number -= 1 ;
  $packages .= " $results[$number]{cat}/$results[$number]{package}";
}

system("sudo emerge -av $packages");

