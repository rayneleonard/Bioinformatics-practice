#!/usr/bin/perl 

#input files
#file with key, to be used with hash: gene0orf1.txt
#file with common names to be changed: duplicate_yeast_genes.txt

#open gene0orf1 file
open(GENE, "gene0orf1.txt") || die "Error can't open gene file: $!n";
#open ohnolog file
open(OHNO, "duplicate_yeast_genes.txt") || die "Error can't open ohnolog file: $!n";

#output files
open (PAIRS, ">ohnolog_pairs.txt") || die "Error can't open output ohnolog file: $!n";
open (NONAME, ">no_systematic_name.txt") || die "Can't open syst name file $!n";
open (ERROR, ">error_genes.txt") || die "Can't open errors file $!n";

#print to screen:
#number of ohnologs, number of yeast genes without a systematic name,
#number of genes that couldn't be found at all 

#declaring hash name
#common name as key and official name as value
%common_yeast_hash = ();

#put duplicate file into array 
@duplicate_array = <OHNO>;
close OHNO;

#also declaring array name for gene0orf1 file
@common_yeast_array = ();
#push ohno file into ohnolog array, then close input file
@common_yeast_array = <GENE>;
close GENE;

#get data into hash
#populate the hash from array 
#use column 0 for key and column 1 for value in gene0orf1 file
foreach $common_yeast_array(@common_yeast_array)
{
	@line=split(/\t/, $common_yeast_array);
	$commonname = $line[0];
	$sysname = $line[1];
	chomp$commonname;
	chomp$sysname;
	$common_yeast_hash{$commonname}=$sysname;
}

#check for key; do the block if key exists, print error if not
# if (exists $common_yeast_hash{'LTA4H'})
# {
# 	print "GENE FOUND. Chromosome:", $common_yeast_hash{'LTA4H'}, "\n";
# }
# else
# {
# 	print "Sorry, huge error. No chromosome number \n";
# }
#ok that seems to be fine. 

#need to remove common names in column 0 that do not have a name in column 1
#for $common_yeast_hash
#removing key value from %common_yeast_hash
foreach 
delete $common_yeast_hash{'null'};






