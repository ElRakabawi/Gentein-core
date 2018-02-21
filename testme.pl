#!/usr/bin/perl
use strict;
use warnings;
use Term::ANSIColor;

print "Enter you test String: \n";
my $entry = <STDIN>;
chomp $entry;
my $len = length($entry);
my @possib_arr = {};

print ("===========\n");
for(my $i=0; $i<$len; $i++){
  my $nucleic_base = substr($entry, $i, 3);
  if($nucleic_base eq 'Met'){
      my $possib_match = substr($entry, $i, $len-$i);
      print "$possib_match\n";
      push @possib_arr, $possib_match;
    }
}
my $arr_len = scalar(@possib_arr);

for(my $i=1; $i<$arr_len; $i++){
  if($possib_arr[$i] =~ m/((?=Met\*?).*?STOP)/){
    $possib_arr[$i] = $1;
    print "after: $i --> $possib_arr[$i]\n";
  }
}
