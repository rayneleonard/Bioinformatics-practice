#!/usr/bin/perl 

#open yeast file
open(YEAST, "yeast_function.txt") || die "Error can't open input file: $!n";
#open output file
open(GENES, ">Rayne_unknowngenes.txt") || die "Error can't open output file: $!n";


#push input file into array using while function and handle
#also chomped in past exercise
#not adding tag
while (<YEAST>)
{
#chomp here? 
	chomp ($_);
	push(@yeast, $_);
}
#initiate counts. seems to work either way. 
$count_up_unknown = 0;
$count_up_known = 0;

#now need to split, loop, conditional, and counting
#can all be done within one large loop
#note, need columns 0,3,4,5 from input file 
#[0]= name, [3] biological process [4] molecular fxn [5] cellular component 

foreach $yeast(@yeast)
#splitting and looping 
{
   	@yeast_line=split(/\t/, $yeast);
   	$yeast_name=$yeast_line[0];
   	$bio_process=$yeast_line[3];
   	$mol_fxn=$yeast_line[4];
   	$cell_comp=$yeast_line[5];
    chomp $yeast_name;
    chomp $bio_process;
    chomp $mol_fxn;
    chomp $cell_comp;
#print "$yeast_name \t $bio_process \t $mol_fxn \t $cell_comp \t";
#ok it printed so all good so far. 

#probably need a while or foreach function here to read one line at a time 
#foreach $yeast(@yeast_line)
#took that out because it was redundant.. and that was what my problem was the whole time. figures. 
#	{  unnecessary. !!!!!!!!!!
if (($bio_process eq "biological_process unknown") && ($mol_fxn eq "molecular_function unknown") && ($cell_comp eq "cellular_component unknown"))
   		{
   		print GENES "$yeast_name\n\n";
	     ++$count_up_unknown;
		}     
else 
		{
	     ++$count_up_known;
		}
#	} Unnecessary. !!!!!!!! Can't believe that was the problem. something to watch for in the future. 
}
#printing to screen
print "The number of genes with unknown processes, functions, and components are:\n\n";
print "$count_up_unknown\n\n";
print "The number of genes with known processes, functions, and/or components are:\n\n";
print "$count_up_known\n\n";
print "The names of genes with unknowns have been printed to output file specified.\n";
#finding percentages from total and printing them to screen. 
$total = $count_up_unknown + $count_up_known;
$perc_unkn = ($count_up_unknown/$total)*100; 
$perc_kn = ($count_up_known/$total)*100;
print "The percentage of unknown genes is:\n";
print "$perc_unkn\n\n";
print "The percentage of known genes is:\n";
print "$perc_kn\n\n";
print "Wahoo!!!\n\n";

exit;

