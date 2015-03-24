#!/usr/bin/perl -w

$dna1 = 'AAGGCT';
$dna2 = 'TTTTTTT';
# 
# $dna3 = $dna1.$dna2;
# print "$dna3\n";
# 
# $dna4 = $dna3;
# $dna4 =~ s/TC/YY/g;
# print "$dna4\n";
# 
# $dna5 = $dna3;
# $dna5 =~ tr/ATCG/TAGC/g;
# print "$dna5\n";

@all_dnas = ($dna1, $dna2);
print "@all_dnas\n";
print scalar (@all_dnas);
