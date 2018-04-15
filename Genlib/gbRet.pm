#!/usr/bin/perl

# Author: Muhammed S. ElRakabawi (elrakabawi.github.io)
# gbRet is a GenBank retrieval module for Gentein Translator
package Genlib::gbRet;

use warnings;
use strict; 
use Bio::DB::GenBank;
use Bio::SeqIO;  
$ENV{PERL_LWP_SSL_VERIFY_HOSTNAME} = 0;
my $gbank = new Bio::DB::GenBank;

sub retrieve(){
	print "Please enter your GenBank Accession number: ";
	my $accNo = <STDIN>;
	my $seq1 = $gbank -> get_Seq_by_acc($accNo);
	my $sequence = $seq1 -> seq;

	for my $feat ($seq1 -> get_SeqFeatures){
	  if ($feat -> primary_tag eq 'CDS'){ # Checking for CDS info
	    print $feat -> get_tag_values('gene'),"\n";
	    
	    use Text::Wrap;
	    $Text::Wrap::columns = 71; #FASTA
	    print wrap('', '', $sequence, "\n");

	    return $sequence;
	  }
	}
}