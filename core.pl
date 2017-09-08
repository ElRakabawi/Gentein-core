#!/usr/bin/perl
use Mojolicious::Lite;
#use Term::ANSIColor;

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

#Storing the user DNA sequence
print "Enter you DNA Sequence: \n";
my $entry = <STDIN>;
chomp $entry;
my $dna = uc($entry);
my $len = length($dna);


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
