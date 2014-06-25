#!/usr/bin/perl
use DBI;
use DBD::mysql;
use Data::Dumper;
use IO::Handle;

#-------------------------------------------------------------------------
#            Taha Al-jumaily
#
# use: perl scriptname.pl ln_number -/+
# ------------------------------------------------------------------------ 

$dbh = DBI -> connect ('DBI:mysql:username;host=server.xxx.xxx;port=3306', 'username', 'password') or die "Could not connect to database: $DBI::errstr";

$ln = trim($ARGV[0]);
$s = trim($ARGV[1]);
if(!$ln or $ln eq ""){ print "Enter LN, exiting...\n"; exit; }   
if(!$s or $s eq ""){ print "Enter strand, exiting...\n"; exit; }  
$pos = $s eq "+"?"txStart":"txEnd";


# Building 23 Chromosomes
@chromo=();
for($i=1;$i<23;$i++){ push(@chromo,$i); } push(@chromo,('X','Y'));  


$limit = ''; #"LIMIT 100"; ------- # Limits if needed -------#
$bp_pos=73; # Base pair postion
$plusminus = 1000; # Score Arrays
@b=(0..(($plusminus*2)+$bp_pos));
for $bb(0..$#b){ $b[$bb]=0; } # zero-out array

# ----- Chromosomes Calc ------ #
foreach $chr (@chromo[0..$#chromo]){  
   # Load ensGene position into array
   @ensGene=();
      
   $sth=$dbh->prepare("SELECT $pos FROM ensGene_TTSS WHERE (chrom LIKE 'chr$chr' AND strand='$s') ORDER BY $pos $limit");
   $sth->execute();
   while(my $r=$sth->fetchrow_hashref()){ push(@ensGene,($s eq "+"?$r->{$pos}+$bp_pos:$r->{$pos}-$bp_pos)); } $sth->finish;
      
   print "* Processing LN:$ln \tChromosome:$chr \tRows: ".($#ensGene+1)."\n";

   for my $c (0..$#ensGene){     
      $srp="SELECT DISTINCT startx FROM YFM_LN".$ln."_chr$chr ";
      $srp.="WHERE ((startx BETWEEN ".($ensGene[$c]-$plusminus)." AND ".($ensGene[$c]+$plusminus).") && (strand='$s')) "; 
      $srp.="ORDER BY startx";
      $sth=$dbh->prepare($srp);
      $sth->execute();
      if($sth->rows){        
         while(my $r = $sth->fetchrow_hashref()){
            $center = $r->{'startx'}+$bp_pos;
            if($ensGene[$c] >= $center){ $v = $plusminus - abs($center - $ensGene[$c]); }
            else{ $v = $plusminus + abs($center - $ensGene[$c]); }
            $b[$v]++;
            }$sth->finish;           
         }
      }
   }



# ---------------------- writing to file(s) ---------------------- #
$outputfile = "/home/talju0/data/ensGene_CTCF_LN".$ln."_$s.csv";
open OUTPUT, ">$outputfile" or die "failed to open file";
print OUTPUT "Distance From TSS(bp), ensGene_CTCF_LN".$ln."_$s\n"; 
for $bb(0..$#b){ print OUTPUT "$bb,$b[$bb]\n"; }
close OUTPUT;
print "\t\tCreating file. Done\n";
    

# ---------------------- Subroutines ----------------------------- # 
sub trim($){
   my $string = shift;
   $string =~ s/^\s+//;
   $string =~ s/\s+$//;
   return $string;
   }
   
system("echo 'DLX - ensGene_CTCF_LN$ln complete' | mail -s 'DLX-Sbatch Complete LN$ln $s' taha\@uky.edu");   
exit;
