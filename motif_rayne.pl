#project 3: pattern matching and retrieval. write a program to find all occurences of targeting signal
# motifs in a simple text file that has the one letter amino acid code for all human chromosome 18 proteins using a 
# regular expression. 1. peroxisome targeting and 2. nuclear import. 

#!/usr/bin/perl -w

#										notes: 

#open input file and assign to variable, put into array, close the file. 
#split by pipe symbol to get just gene name and sequence in array
#can loop over input file to get rid of new line chars (/n) or use
#$___ =~ s/[^\w -]//g; within loop to sub non-alpha numberic chars for nothing. 
#for splitting: @array=split('|', $allfiles);

# 							OPENING FILES, input and output 
# taking a leaf from Pen's book and adding headers for sections^


#output file
open(RESULTS, ">motifresults_rayne.txt") || die "sry cant even lol $!n";
#open gene input file
open(MOTIF, 'hu18aa2.txt') || die "data on vacay sry $!n";


#						LOOPING INTO ARRAY WHILE CHOMPING
# chomp chomp chomp

#push input file into array using while function and handle
#also chomped in past exercise
#not adding tag
#input tag MOTIF, array @motif. 
while (<MOTIF>)
{ 
	chomp ($_);
	push(@motif, $_);
	#print "@motif\t";
	#that printed a lot of text. ok. 
}
#close file. IDK if this is necessary?
close MOTIF;


#							SPLIT MY ARRAY 
#at | symbol.. or * ?
# @motif_array = split (/*/, $motif);
# shift @motif_array;
# print RESULTS @motif_array;
#did not print anything. problem here. 
#just taking that out for now. starting over. 


#					FINDING >,|,*, AND SO ON. 

foreach $motif (@motif)
{
#this needs work
if ($motif =~ /^\>/)
#problem here^^^^^ took out ig
#basically, if >, split at pipe
	{
		#now split pipe; want the name that comes after the pipe
		@mini_row=split(/\|/, $motif);
		$name=$mini_row[1];
		#printing namerow or minirow doesn't work here so
		#problem with line 57
		#print "$name\t";
		#IT PRINTED STUFF
	}
elsif ($motif eq "Sequence unavailable")
	{
		#counter (not the marble kind)
		++$no_seq;
		#clearing 
		$name=();
		print "$no_seq\n";
		#that prints numbers 1-1024. Hmmmmmm. 
	}
else
	{
	#new variable with beginning
		$motif_begin=$_;
	#print the variable 
		$total_proteins= $total_proteins.$motif;
		#print RESULTS "$total_proteins\n\n";
		#problem here; printed a bunch of lines. probably problem with line 75. 
		#update: prints to output file
	}
	#now find an asterisk at end
#	if($total_proteins =~ /\Z\*/) dunno why that didn't work. Z means at end; locating SKL at ends
	if($total_proteins =~ /\*$/)
	{
		#pushing into new array
		push @aminoseq, "$name\t$total_proteins";
		++$count_up_total;
		$name=();
		#problem at line above? not sure what... says operator error. 
		#come back to these. Hah. Missing semicolon. 
		$total_proteins=();
		#print "@aminoseseq \t";
		#there is a problem with @aminoseq
	}
	#have to take out variables name and total proteins
}


##							NOW FIND LE MOTIFS 
# using newly created array @amino seq
#going to split this array.... chomp chomp chomp?

foreach $aminoseq(@aminoseq)
{
	@aminotab=split(/\t/, $aminoseq);
	#does "\t" need to be /\t/ ?
	
	#name will be column 0
	#seq will be column 1
	$amino_name=$aminotab[0];
	$amino_seq=$aminotab[1];
	#need to sub non-alphanumeric chars for nothing
	$amino_name =~ s/[^\w-]//g;
	$amino_seq=~ s/[^\w-]//g;
	
	#protein length 
	$amino_length = length $amino_seq;
	
	
	#now we look for first motif with conditional
	#try PTS2 .....RL.....HL
	 
	#if ($amino_seq =~ /\A.....RL.....HL/) trying something different to troubleshoot
	if ($amino_seq=~ /^.....RL.....HL/ig)
	{
		++$countup_PTS2;
	#saves motif so its the exact motif
		$PTS2_motif = $&;
	
	#location of PTS2
		$locale_PTS2 = length $`;
	
		print "$gene_name \t $locale_PTS2 \t $amino_length \t PTS2 \t $PTS2_motif \n";
		#not printing. bah humbug. 
	}
}

close RESULTS;	




exit;		



