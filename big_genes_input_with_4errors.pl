#!/usr/bin/perl -w
# Purpose: find the number of genes that are larger than average
                                           
#initialize arrays and counters
@genes =();
$big_gene_count = 0;
$other_gene_count = 0;

#open files and filehandles for incoming and outgoing data
open(GENES, "genes.txt") || die "Can't open genes file: $!\n";
open(BIG_GENES, ">big_genes.txt") || die "Can't open output file: $!\n";

#bring in gene names from ribosomal protein file 
while(<GENES>)
{
     chomp $_;
     push(@genes, $_);
}     

#loop to split the rows into pieces to evaluate, big gene is more than 1000 
#need to save gene name (column 1), start (column 4), stop (column 5)
#when absolute value of stop-start >1000, save gene name and gene size to file
#otherwise gene name and size is saved to a file for small genes
foreach $genes(@genes)
{
     @mini = split (/\t/,$genes);
     $gene_name = $mini[0];
     $start = $mini[3];
     $stop = $mini[4];
     $gene_length = abs($stop-$start);
     if ($gene_length > 1000)
     {
         print BIG_GENES "$gene_name \t $gene_length\n";
         ++$big_gene_count;
     }
     else
     {
         #by definitition, these must be small
         ++$other_gene_count;       
     }
}
#to find the percent of big genes of the total evaluated
$percent_big = ($big_gene_count/($big_gene_count + $other_gene_count))*100;

print "The number of big genes is $big_gene_count, which is $percent_big%.\n";
print "The number of little genes is $other_gene_count. \n";

# Close the files
close GENES;
close BIG_GENES;

exit;
