#!/usr/bin/perl -w

#open output files
open(UPREG, ">upreg.txt") || die "Error can't open output file: $!n";
open(DOWNREG, ">downreg.txt") || die "Error can't open output file: $!n";

#creating program using loops and conditionals
#retrieve gene expression values 

#import gene expression values from 3 files and store each line from each file into an array
#want one array for the 3 files

#read lines from the files, store into array @allfiles
#open files separately with handles
#getting hyper5 data
$hyper5filename = 'hyper5.txt';
open(H5, $hyper5filename);


#getting heatshock data
$heatshockfilename = 'heatshock05.txt';
open(HK, $heatshockfilename);


#getting diamide data
$diamidefilename = 'diamide5min.txt';
open(DI, $diamidefilename);


#open files separately with handles
while (<H5>)
{
	chomp $_;
	$line="$_\tH5\n";
	push(@allfiles, $line);
}
#can use count function here; after next push, subtract that from this. 
#page 53 in book
#using scalar to count lines in input files. More complicated code is at end of document. 
$H5count=scalar @allfiles;

#open files separately with handles
while (<HK>)
{
	chomp $_;
	$line="$_\tHK\n";
	push(@allfiles, $line);
}
$HKprecount=scalar @allfiles;
$HKcount=$HKprecount-$H5count;

#open files separately with handles
while (<DI>)
{
	chomp $_;
	$line="$_\tDI\n";
	push(@allfiles, $line);
}
$DIprecount=scalar @allfiles;
$DIcount = $DIprecount - $HKprecount;

#now the data is stored in array @allfiles

#that needs work on the printing, but I think the array is ok. 

#now loop over each line in @allfiles to create mini array
#want output file for >2 upreg (add the gene name, the expression value, and treatment type) 
# and <2 downreg add gene name, exp value, treatment type 

#the data is contained in an array called @allfiles with 1 gene’s info per row 
# column 0 gene name column 1 expression
# the columns of data here are separated by “tabs,” known as \t in perl
#each line will need to be split and the data stored into a new “tiny” array (@allfiles_tiny)
#the syntax is split(/motif to localize the split/, data source)
#then save only the info from column 0 and 5 as separate variables
#print the data in 2 columns to the screen, separated by a tab
foreach $allfiles(@allfiles)
{
   	@info_line=split(/\t/, $allfiles);
   	$gene_name=$info_line[0];
   	$expr=$info_line[1];
   	$tag=$info_line[2];
    chomp $expr;
    chomp $tag;
    chomp $gene_name;

# to print the columns to the screen, do print "$expr \t $tag \n";

#ok. that seems fine. 

#now need to create upreg output file with expr >2

#using if function
   if($expr ne "null" && $expr >= 2)
   {
	     if($tag = "DI") 
	     {
	     ++$count_up_DI;
	     }
	     elsif ($tag = "HK")
	     {
	     ++$count_up_HK;
	     }
	     elsif ($tag = "H5")
	     {
	     ++$count_up_H5;
	     }
	     print UPREG "$allfiles";
   }
  elsif ($expr ne "null" && $expr <=-2)
  {
		print DOWNREG "$allfiles";
		if ($tag = "DI")
		{
		++$count_down_DI;
		}
		elsif ($tag = "HK")
		{
		++$count_down_HK;
		}
		elsif ($tag = "H5")
		{
		++$count_down_H5;
		} 
  }

}
#above, I have a loop within a loop, because I am using @allfiles for both functions
	
print "\n All genes with expressions equal to or greater than 2 are printed to upreg.txt \n\n";
print "All genes with expressions equal or less than -2 are printed to downreg.txt \n\n";
print "All other genes did not exhibit significant activity \n\n";

# #count #genes in input files
# #found this on perlmonk. I think this is actually counting number of lines in the file
# #count number genes in H5
# $lines = 0;
#            open(H5, $hyper5filename) or die "Can't open `$filename': $!";
#            while (sysread H5, $buffer, 4096) {
#                $lines += ($buffer =~ tr/\n//);
#            }
#            close H5;
#            print "the number of genes in the Hyper 5 file is:\n";
#            print "$lines\n\n";
# #count number genes in DI by counting lines
# $lines1 = 0;
#            open(DI, $diamidefilename) or die "Can't open `$filename': $!";
#            while (sysread DI, $buffer, 4096) {
#                $lines1 += ($buffer =~ tr/\n//);
#            }
#            close DI;
#            print "The number of genes in the Diamide file is:\n";
#            print "$lines1\n\n";
# #count number genes in HK by counting lines
# $lines2 = 0;
#            open(HK, $heatshockfilename) or die "Can't open `$filename': $!";
#            while (sysread HK, $buffer, 4096) {
#                $lines2 += ($buffer =~ tr/\n//);
#            }
#            close HK;
#            print "The number of genes in the Heatshock file is:\n";
#            print "$lines2\n\n";
#            
# #now count number of genes in each output file, upreg and downreg. 
# #first, upreg file
# $lines3 = 0;
#            open(UPREG, 'upreg.txt') or die "Can't open `$filename': $!";
#            while (sysread UPREG, $buffer, 4096) {
#                $lines3 += ($buffer =~ tr/\n//);
#            }
#            close UPREG;
#            print "The number of genes in the upregulated genes file is:\n";
#            print "$lines3\n\n";
# #now downreg file
# $lines4 = 0;
#            open(DOWNREG, 'downreg.txt') or die "Can't open `$filename': $!";
#            while (sysread DOWNREG, $buffer, 4096) {
#                $lines4 += ($buffer =~ tr/\n//);
#            }
#            close DOWNREG;
#            print "The number of genes in the downregulated genes file is:\n";
#            print "$lines4\n\n";
# #print the number of genes that did not show significant expression either way
# $lines5 = $lines + $lines1 + $lines2 - $lines3 - $lines4;
# $lines6 = $lines + $lines1 + $lines2;
# print "the number of genes analyzed total were:\n\n";
# print "$lines6\n\n";
# print "the number of genes that did not show significant upregulation or downregulation is:\n\n";
# print "$lines5\n\n";

print "The number of genes in the DI input file were:\n";
print "$DIcount\n";
print "The number of genes in the HK input file were:\n";
print "$HKcount\n";
print "The number of genes in the H5 input file were:\n";
print "$H5count\n";


#still need to count the number of upreg and downreg genes for each treatment type. 
#that was done within the @allfiles loop above. 
print "The number of DI in the downregulated file is:\n";
print "$count_down_DI\n";
print "The number of H5 in the downregulated file is:\n";
print "$count_down_H5\n";
print "The number of HK in the downregulated file is:\n";
print "$count_down_HK\n";
print "The number of DI in the upregulated file is:\n";
print "$count_up_DI\n";
print "The number of H5 in the upregulated file is:\n";
print "$count_up_H5\n";
print "The number of HK in the upregulated file is:\n";
print "$count_up_HK\n";




