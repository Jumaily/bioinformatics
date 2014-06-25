#!/usr/bin/perl
use IO::Handle;
#------------------------------------------------------------------------------
#            Taha Al-jumaily
#  create batch file with according to arrays list
#------------------------------------------------------------------------------

$directory = "/home/talju0/jobs";
@ln=(4,5);
@ct=("cwg","cg");
@nr=(1,10);
@npeak=("narrow_peak_H3K27ac","narrow_peak_H3K27me3","narrow_peak_H3K36me3","narrow_peak_H3K9me3");
@chromo=();
for($i=1;$i<23;$i++){ push(@chromo,$i); } push(@chromo,('X','Y'));  

  
 foreach $l (@ln[0..$#ln]){
   foreach $n (@npeak[0..$#npeak]){
       
      $file = "process_NP-LN".$l."_".$n.".sh";
      print "Writing file: $file\n";
      open OUTPUT, ">$directory/$file" or die "failed to write to file";
      print OUTPUT "#!/bin/sh\n";
      print OUTPUT "perl /home/talju0/narrowpeak_calculate.pl $l $n\n";
      print OUTPUT "rm $directory/$file";
      close OUTPUT;
          
      system("sbatch --share -p FatComp $directory/$file");
      }
   }

# echo "DLX - sbatch complete" | mail -s "DLX-Sbatch Complete" taha@uky.edu
exit;