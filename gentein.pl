#!/usr/bin/perl
use strict;
use warnings;
use Term::ANSIColor;

my(%genetic_code) = (

#Phenylalanine
'TTT' => 'F',
'TTC' => 'F',

#Leucine
'TTA' => 'L',
'TTG' => 'L',
'CTT' => 'L',
'CTC' => 'L',
'CTA' => 'L',
'CTG' => 'L',

#Isoleucine
'ATT' => 'I',
'ATC' => 'I',
'ATA' => 'I',

#Methionine
'ATG' => 'Met',

#Valine
'GTT' => 'V',
'GTC' => 'V',
'GTA' => 'V',
'GTG' => 'V',

#Serine
'TCT' => 'S',
'TCC' => 'S',
'TCA' => 'S',
'TCG' => 'S',
'AGT' => 'S',
'AGC' => 'S',

#Proline
'CCT' => 'P',
'CCC' => 'P',
'CCA' => 'P',
'CCG' => 'P',

#Threonine
'ACT' => 'T',
'ACC' => 'T',
'ACA' => 'T',
'ACG' => 'T',

#Alanine
'GCT' => 'A',
'GCC' => 'A',
'GCA' => 'A',
'GCG' => 'A',

#Tyrosine
'TAT' => 'Y',
'TAC' => 'Y',

#Histidine
'CAT' => 'H',
'CAC' => 'H',

#Glutamine
'CAA' => 'Q',
'CAG' => 'Q',

#Asparagine
'AAT' => 'N',
'AAC' => 'N',

#Lysine
'AAA' => 'K',
'AAG' => 'K',

#Aspartic acid
'GAT' => 'D',
'GAC' => 'D',

#Glutamic acid
'GAA' => 'E',
'GAG' => 'E',

#Cysteine
'TGT' => 'C',
'TGC' => 'C',

#Tryptophan
'TGG' => 'W',

#Arginine
'CGT' => 'R',
'CGC' => 'R',
'CGA' => 'R',
'CGG' => 'R',
'AGA' => 'R',
'AGG' => 'R',

#Glycine
'GGT' => 'G',
'GGC' => 'G',
'GGA' => 'G',
'GGG' => 'G',

#STOP codons
'TAA' => 'STOP',
'TAG' => 'STOP',
'TGA' => 'STOP',
);

#Psuedorandom generation of DNA upon user choice
my @bases = ("A","T","C","G");
my $GenDNA;

ASKTHEUSER:
print "Do you want to generate a psuedo-random DNA? Enter (Y) for DNA Generation or (N) to import your sequence\n";
my $userChoice = <STDIN>;
chomp $userChoice;
my $baseLen = 1;

if($userChoice eq 'Y' || $userChoice eq 'y'){
  ASKFORSIZE:
  print "Enter size of DNA: ";
  $baseLen = <STDIN>;
  chomp $baseLen;
  if($baseLen <= 9){
    print "Size must be larger than 9\n";
    goto ASKFORSIZE;
  }
  else {
    for(my $i=0; $i<$baseLen; $i++){
      $GenDNA .= $bases[rand @bases];
    }
    print "Your generated DNA has a length of ($baseLen) and is: \n$GenDNA\n";
  }
}
elsif($userChoice eq 'N' || $userChoice eq 'n'){
  goto START;
}
else {
  print "Please enter a right choice! \n";
  goto ASKTHEUSER;
}


START:
#Storing the user DNA/mRNA sequence
my $entry;
if($baseLen > 9){
  $entry = $GenDNA;
}
else {
  print "Enter you DNA Sequence: \n";
  $entry = <STDIN>;
  chomp $entry;
}
my $dna = uc($entry);
my $len = length($dna);


#Detection of mRNA presence and detranslation of it back to DNA
my $mRNA_det = 0;
for(my $i=0; $i<$len; $i++){
  my $nucleic_base = substr($dna, $i, 1);
  if($nucleic_base eq 'U'){
    $mRNA_det = 1;
  }
}

if($mRNA_det == 1){
  print color("GREEN"), "\nThe sequence detected is mRNA .. converting to DNA!\n", color("RESET");
  $dna =~ tr/U/T/;
  print "The new DNA sequence is: $dna\n";
}
else {
  print color("GREEN"), "\nThe sequence detected is DNA!\n", color("RESET");
}

#Initiation of protein sequence
my $protein = '';
my $codon = '';


# 5'3Frame 1 translation
my $Fone;
for(my $i=0; $i<$len - 2; $i+=3){
  $codon = substr($dna, $i, 3);
  $codon = $genetic_code{"$codon"};
  $protein .= ' ' . $codon;
  $Fone = $protein;
}
print color("GREEN"), "\n 5'3' Frame 1\n", color("RESET");
print "$Fone\n";

my @test_arr_one = orf_detect($Fone);
my $itr_len_one = scalar(@test_arr_one);
print color("RED"), "\n Number of ORFs: $itr_len_one\n", color("RESET");
for(my $j=0; $j<$itr_len_one; $j++){
  print "($j) $test_arr_one[$j]\n";
}


# 5'3'Frame 2 translation
my $Ftwo;
$protein = '';
for(my $i=1; $i<$len - 2; $i+=3){
  $codon = substr($dna, $i, 3);
  $codon = $genetic_code{"$codon"};
  $protein .= ' ' . $codon;
  $Ftwo = $protein;
}
print color("GREEN"), "\n 5'3' Frame 2\n", color("RESET");
print "$Ftwo\n";

my @test_arr_two = orf_detect($Ftwo);
my $itr_len_two = scalar(@test_arr_two);
print color("RED"), "\n Number of ORFs: $itr_len_two\n", color("RESET");
for(my $j=0; $j<$itr_len_two; $j++){
  print "($j) $test_arr_two[$j]\n";
}


# 5'3'Frame 3 translation
my $Fthree;
$protein = '';
for(my $i=2; $i<$len - 2; $i+=3){
  $codon = substr($dna, $i, 3);
  $codon = $genetic_code{"$codon"};
  $protein .= ' ' . $codon;
  $Fthree = $protein;
}
print color("GREEN"), "\n 5'3' Frame 3\n", color("RESET");
print "$Fthree\n";

my @test_arr_three = orf_detect($Fthree);
my $itr_len_three = scalar(@test_arr_three);
print color("RED"), "\n Number of ORFs: $itr_len_three\n", color("RESET");
for(my $j=0; $j<$itr_len_three; $j++){
  print "($j) $test_arr_three[$j]\n";
}


# Reverse 3'5'DNA to 5'3' DNA (complement and reverse strand)
my $rev_dna = '';
my $base;
for(my $i=0; $i<$len; $i++){
  $base = substr($dna, $i, 1);
  if($base eq 'A'){
    $rev_dna .= 'T';
  }
  elsif($base eq 'G'){
    $rev_dna .= 'C';
  }
  elsif($base eq 'C'){
    $rev_dna .= 'G';
  }
  elsif($base eq 'T'){
    $rev_dna .= 'A';
  }
}
$rev_dna = reverse($rev_dna);


# 3'5'Frame 1 translation
my $Fone_rev;
$protein = '';
for(my $i=0; $i<$len - 2; $i+=3){
  $codon = substr($rev_dna, $i, 3);
  $codon = $genetic_code{"$codon"};
  $protein .= ' ' . $codon;
  $Fone_rev = $protein;
}
print color("GREEN"), "\n 3'5' Frame 1\n", color("RESET");
print "$Fone_rev\n";

my @test_arr_one_rev = orf_detect($Fone_rev);
my $itr_len_one_rev = scalar(@test_arr_one_rev);
print color("RED"), "\n Number of ORFs: $itr_len_one_rev\n", color("RESET");
for(my $j=0; $j<$itr_len_one_rev; $j++){
  print "($j) $test_arr_one_rev[$j]\n";
}


# 3'5'Frame 2 translation
my $Ftwo_rev;
$protein = '';
for(my $i=1; $i<$len - 2; $i+=3){
  $codon = substr($rev_dna, $i, 3);
  $codon = $genetic_code{"$codon"};
  $protein .= ' ' . $codon;
  $Ftwo_rev = $protein;
}
print color("GREEN"), "\n 3'5' Frame 2\n", color("RESET");
print "$Ftwo_rev\n";

my @test_arr_two_rev = orf_detect($Ftwo_rev);
my $itr_len_two_rev = scalar(@test_arr_two_rev);
print color("RED"), "\n Number of ORFs: $itr_len_two_rev\n", color("RESET");
for(my $j=0; $j<$itr_len_two_rev; $j++){
  print "($j) $test_arr_two_rev[$j]\n";
}

# 3'5'Frame 3 translation
my $Fthree_rev;
$protein = '';
for(my $i=2; $i<$len - 2; $i+=3){
  $codon = substr($rev_dna, $i, 3);
  $codon = $genetic_code{"$codon"};
  $protein .= ' ' . $codon;
  $Fthree_rev = $protein;
}
print color("GREEN"), "\n 3'5' Frame 3\n", color("RESET");
print "$Fthree_rev\n";

my @test_arr_three_rev = orf_detect($Fthree_rev);
my $itr_len_three_rev = scalar(@test_arr_three_rev);
print color("RED"), "\n Number of ORFs: $itr_len_three_rev\n", color("RESET");
for(my $j=0; $j<$itr_len_three_rev; $j++){
  print "($j) $test_arr_three_rev[$j]\n";
}

#Function for detection of ORFs within the amino acid sequence
sub orf_detect {
  my ($entry) = @_;
  my $len = length($entry);
  my @possib_arr;
  my @orfs;

  for(my $i=0; $i<$len; $i++){
    my $nucleic_base = substr($entry, $i, 3);
    if($nucleic_base eq 'Met'){
        my $possib_match = substr($entry, $i, $len-$i);
        push @possib_arr, $possib_match;
      }
  }

  my $arr_len = scalar(@possib_arr);
  for(my $i=0; $i<$arr_len; $i++){
    if($possib_arr[$i] =~ m/((?=Met\*?).*?STOP)/){
      $possib_arr[$i] = $1;
      my $temp_chuck = $possib_arr[$i];
      push @orfs, $temp_chuck;
    }
  }
  return @orfs;
}
