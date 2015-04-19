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
open (GENE1, ">gene0orf1_sans_noname.txt") || die "Surry can't lulz $!n";

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
#basically, within this loop, I hope to get data into hash, then use the data in
#the array to print the common names with no syst name attached in gene0orf1
#to output file, take a count, then print all others genes (those with common
#and syst name) to a separate output file to be used when comparing with the 
#duplicate file. 
#so far, printing common names without syst name is working
#printing all others to new output file isnt\
#may have to use the delete function after all

	@line=split(/\t/, $common_yeast_array);
	$commonname = $line[0];
	$sysname = $line[1];
	chomp$commonname;
	chomp$sysname;
	$common_yeast_hash{$commonname}=$sysname;
	
#need to print common names in column 0 that do not have a name in column 1
#into 1 column in no_syst_name.txt
#for $common_yeast_hash
# then removing key value from %common_yeast_hash 
#do it within this loop I guess
		if ($line[1] <= 0)
			{
				print NONAME "$line[0]\n";
				++$count_up_noname;
			}
			else
			{
				#print GENE1 "$line[0]\t$line[1]\n";
				#to print to new input file
				#that didn't work
				#trying delete fxn
				delete $line[0];
				#this part still not working. IDK IDK. 
			}
				
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






