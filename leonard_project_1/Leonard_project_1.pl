#!/usr/bin/perl -w

#open the cavseqfile on the command line
open(CAVSEQFILE, "$ARGV[0]") || die "Can't open protein sequence file:$!\n\n";
#store CAVSEQFILE in a variable
$cav_seq = <CAVSEQFILE>;
close CAVSEQFILE;

#print cav_seq to screen
	print "Here is the caveolin sequence:\n";
	print "$cav_seq\n\n";
 
# perl's length() function retrns length of perl string in chars
#gives total number of chars in string
$length_cav = length($cav_seq);
	print "The number of nucleotides in the caveolin sequence is:\n";
	print "$length_cav\n\n";

#getting yfp data
$yfp_seqfilename = 'yfp_seq.txt';
open(YFPSEQFILE, $yfp_seqfilename);
$yfp_seq = <YFPSEQFILE>;
close YFPSEQFILE;

#length of yfp
$length_yfp = length($yfp_seq);
	print "The number of nucleotides in the yfp sequence is:\n";
	print "$length_yfp\n\n";

#getting gfp data
$gfp_seqfilename = 'gfp_seq.txt';
open(GFPSEQFILE, $gfp_seqfilename);
$gfp_seq = <GFPSEQFILE>;
close GFPSEQFILE;

#length of gfp
$length_gfp = length($gfp_seq);
	print "The number of nucleotides in the gfp sequence is:\n";
	print "$length_gfp\n\n";
	
#getting rfp data
$rfp_seqfilename = 'rfp_seq.txt';
open(RFPSEQFILE, $rfp_seqfilename);
$rfp_seq = <RFPSEQFILE>;
close RFPSEQFILE;

#rfp length
$length_rfp = length($rfp_seq);
	print "The number of nucleotides in the rfp sequence is:\n";
	print "$length_rfp\n\n";
	
#combined lengths of cav + yfp
	print "Here is the length of caveolin fused with yfp:\n";
$cav_yfp_nuc = $length_cav + $length_yfp;
	print "$cav_yfp_nuc\n\n";
#combined lengths of cav + gfp
	print "Here is the length of caveolin fused with gfp:\n";
$cav_gfp_nuc = $length_cav + $length_gfp;
	print "$cav_gfp_nuc\n\n";
#combined lengths of cav + rfp
	print "Here is the length of caveolin fused with rfp:\n";
$cav_rfp_nuc = $length_cav + $length_rfp;
	print "$cav_rfp_nuc\n\n";

#print number of amino acids in $length_cav
#divide $length_cav by 3 (no stop codon here)
	print "The number of amino acids in the caveolin sequence is:\n";
$aa_cav = $length_cav /= 3;
	print "$aa_cav\n\n";
#number of aa in yfp, minus stop codon
$aa_yfp = $length_yfp /= 3;
$aa_yfp_ = $aa_yfp - 1;
	print "The number of amino acids in the yfp sequence is:\n";
	print "$aa_yfp_\n\n";
#number of aa in gfp, minus stop codon
$aa_gfp = $length_gfp /= 3;
$aa_gfp_ = $aa_gfp - 1;
	print "The number of amino acids in the gfp sequence is:\n";
	print "$aa_gfp_\n\n";
#aa in rfp, minus stop codon
$aa_rfp = $length_rfp /= 3;
$aa_rfp_ = $aa_rfp - 1;
	print "The number of amino acids in the rfp sequence is:\n";
	print "$aa_rfp_\n\n";

#print cav aa plus yfp aa to get combined number of aa
	print "The number of amino acids in the caveolin and yfp fusion is:\n";
$cav_yfp_aa = $aa_cav + $aa_yfp_;
	print "$cav_yfp_aa\n\n";
#print cav aa plus gfp aa to get combined number of aa
	print "The number of amino acids in the caveolin and gfp fusion is:\n";
$cav_gfp_aa = $aa_cav + $aa_gfp_;
	print "$cav_gfp_aa\n\n";
#print cav aa plus rfp aa to get combined number of aa
	print "The number of amino acids in the caveolin and rfp fusion is:\n";
$cav_rfp_aa = $aa_cav + $aa_rfp_;
	print "$cav_rfp_aa\n\n";

	print "All data is printed. \n\n";

#time to concatenate
#cav and yfp
	print "Here is the fusion of your protein with yfp: \n\n";
$cav_yfp_fusion = $cav_seq . $yfp_seq;
	print "$cav_yfp_fusion\n\n";
#cav and gfp
	print "Here is the fusion of your protein with gfp: \n\n";
$cav_gfp_fusion = $cav_seq . $gfp_seq;
	print "$cav_gfp_fusion\n\n";
#cav and rfp
	print "Here is the fusion of your protein with rfp: \n\n";
$cav_rfp_fusion = $cav_seq . $rfp_seq;
	print "$cav_rfp_fusion\n\n";

#now reverse complement of each fusion variable
#cav and yfp
$revcom_cav_yfp = reverse $cav_yfp_fusion;
$revcom_cav_yfp =~ tr/ACGTacgt/TGCAtgca/;
	print "Here is the reverse complement of the fusion between your protein and yfp: \n\n";
	print "$revcom_cav_yfp\n\n";
#cav and gfp
$revcom_cav_gfp = reverse $cav_gfp_fusion;
$revcom_cav_gfp =~ tr/ACGTacgt/TGCAtgca/;
	print "Here is the reverse complement of the fusion between your protein and gfp: \n\n";
	print "$revcom_cav_gfp\n\n";
#cav and rfp
$revcom_cav_rfp = reverse $cav_rfp_fusion;
$revcom_cav_rfp =~ tr/ACGTacgt/TGCAtgca/;
	print "Here is the reverse complement of the fusion between your protein and rfp: \n\n";
	print "$revcom_cav_rfp\n\n";

#open the results file or exit
#print 6 sequences to Leonard_fusion_output.txt
open(RESULTS, ">Leonard_fusion_output.txt") || die "Error can't open input file: $!n";
	print RESULTS ">cav::yfp_concatenated\n $cav_yfp_fusion\n\n";
	print RESULTS ">cav::gfp_concatenated\n $cav_gfp_fusion\n\n";
	print RESULTS ">cav::rfp_concatenated\n $cav_rfp_fusion\n\n";
	print RESULTS ">cav::yfp_revcom\n $revcom_cav_yfp\n\n";
	print RESULTS ">cav::gfp_revcom\n $revcom_cav_gfp\n\n";
	print RESULTS ">cav::rfp_revcom\n $revcom_cav_rfp\n\n";

	print "All fused sequences and their reverse complements have been displayed and saved to your file. \n\n";
	print "Thank you and have a nice day. \n\n";


exit;








