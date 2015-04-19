#!user/bin/perl 

#I ended up taking out the -w because it was giving me bullshit errors and warnings

#opening input files 

#open the file diamide.txt
open(DIAMIDE, 'diamide.txt') || die "Can't open the diamide file";

# Store the data from the filehandle, which is a temporary housing for data, in a variable
$DIAMIDE = <DIAMIDE>;

#heat

#open the file heat.txt
open(HEAT, "heat.txt") || die "Can't open the heat file";

# Store the data from the filehandle, which is a temporary housing for data, in a variable
$HEAT = <HEAT>;

#hyper

#open the file hyper.txt
open(HYPER, "hyper.txt") || die "Can't open the hyper file";

# Store the data from the filehandle, which is a temporary housing for data, in a variable
$HYPER = <HYPER>;

#open output files
open(UPREG, ">upreg.txt") || die "Error can't open output file: $!n";
open(DOWNREG, ">downreg.txt") || die "Error can't open output file: $!n";


#now putting information into array @array

#open files separately with handles
while (<DIAMIDE>)
{
	chomp $_;
	$line="$_\tDIAMIDE\n";
	push(@array, $line);
}

#open files separately with handles
while (<HEAT>)
{
	chomp $_;
	$line="$_\tHEAT\n";
	push(@array, $line);
}

#open files separately with handles
while (<HYPER>)
{
	chomp $_;
	$line="$_\tHYPER\n";
	push(@array, $line);
}

#now the data is stored in array @allfiles

#Before I do the if/elsif, I need to figure out how to print my looped columns of data 
#to an output file, correct? I can’t figure out how to take the information from 
#the “mini array” and bring to an output file.




#the data contained in an array called @array with element and number
#we need just the information in column 0 the name and column 1 is the number 
#We need numbers that are greater than 2 and less than -2
#note that you need to know what 'really' separates your columns
#the columns of data here are separated by "tabsf" know as \t in perl
#each line will need to be split and the data stored into a new "tiny" array (@info_line
#the syntax is split(/motif to localize the split/, data source)
#then save only the info from column 0 and 1 as separate variables
#also "chomp" each variable to remove unseen new line characters
#print the data in 2 columns to the screen, separated by a tab
foreach $array(@array)
{
	@info_line=split(/\t/, $array);
	$name2=$info_line[0];
	$number2=$info_line[1];
	chomp $number2;
	chomp $name2;
#print "$name2 \t $number2 \n";
#I put that in hashes because it is annoying 
#just take the hash out if you want to see the printout in terminal

#ok. that seems fine. 

#now need to create upreg output file with expr >2
#you have opened the UPREG and DOWNREG files at the top of this program with the other
#input files for simplicity
#using if function
   if($number2 ne "null" && $number2 >= 2)
   {
	     print UPREG "$array";
   }
  elsif ($number2 ne "null" && $number2 <=-2)
  {
		print DOWNREG "$array";
  }

}
#above, I have loops within a loop, because I am using @allfiles for both functions
	
print "\n All genes with expressions equal to or greater than 2 are printed to upreg.txt \n\n";
print "All genes with expressions equal or less than -2 are printed to downreg.txt \n\n";
print "All other genes did not exhibit significant activity \n\n";
