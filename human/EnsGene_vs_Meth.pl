#!/usr/bin/perl
use DBI;
use DBD::mysql;
use Data::Dumper;
use IO::Handle;

#------------------------------------------------------------------------------
#            Taha Al-jumaily
#
# use: perl scriptname.pl <
# ------------------------------------------------------------------------ 
$dbh = DBI -> connect ('DBI:mysql:username;host=server.xxx.xxx;port=3306', 'username', 'password') or die "Could not connect to database: $DBI::errstr";

$delta = trim($ARGV[0]);
$ln = 5;

# Building 23 Chromosomes
@chromo=();
for($i=1;$i<23;$i++){ push(@chromo,$i); } push(@chromo,('X','Y'));  

$limit = '';# "LIMIT 10";  #------- # Limits if needed -------#
$bp_pos=73; # Base pair postion
$plusminus = 300; # Score Arrays
my @b=();
@b=(0..(($plusminus*2)+$bp_pos));
for $bb(0..($#b+$bp_pos)){ $b[$bb]=0; } # zero-out array

$xvar = $delta."-Methyl-EnsGene";
print "\n \t\t $xvar (+/- $plusminus ) \n";


# ----- Chromosomes Calc ------ #
foreach $chr (@chromo[0..$#chromo]){  
   @eAlpha=();
   @eGene=();
   
   
   $ir = "SELECT txStart FROM ensGene_TTSS WHERE chrom LIKE 'chr$chr' ORDER BY txStart $limit";
   $sth=$dbh->prepare($ir);
   $sth->execute();
   while(my $r=$sth->fetchrow_hashref()){ push(@eAlpha,($r->{"txStart"}+$bp_pos)); } $sth->finish;

   for my $c (0..$#eAlpha){
      $beta = ($eAlpha[$c]-$plusminus)<0?0:($eAlpha[$c]-$plusminus);
      $ir = "SELECT chromStart FROM DNA_Methylation_MCF7 ";
      $ir .= "WHERE ((chromStart BETWEEN $beta AND ".($eAlpha[$c]+$plusminus).") && (chrom LIKE 'chr$chr' AND value $delta 0.5)) ";
      $ir .= "ORDER BY chromStart $limit";      
      $sth = $dbh->prepare($ir);
      $sth->execute();
      while(my $r = $sth->fetchrow_hashref()){ push(@eGene,($r->{"chromStart"}+$bp_pos)); } $sth->finish;         
      }
      
   print "\n $xvar : +/- $plusminus\t".($#eGene+1).": Total hits\n";   

   for my $c (0..$#eGene){
      $beta = ($eGene[$c]-$plusminus)<0?0:($eGene[$c]-$plusminus);
      $srp="SELECT startx FROM YFM_LN".$ln."_chr$chr ";
      $srp.="WHERE (startx BETWEEN $beta AND ".($eGene[$c]+$plusminus).") ";
      $srp.="ORDER BY startx $limit";
      $sth=$dbh->prepare($srp);
      $sth->execute();
      if($sth->rows){        
         while(my $r = $sth->fetchrow_hashref()){
            $center = $r->{'startx'}+$bp_pos;
            
            if($eGene[$c] >= $center){ $v = $plusminus - abs($center - $eGene[$c]); }
            else{ $v = $plusminus + abs($center - $eGene[$c]); }
            
            $b[$v]++;
            }$sth->finish;           
         }
      }
   }


# ---------------------- writing to file(s) ---------------------- #
$outputfile = "/home/talju0/data/Versus_Data/V2/".$xvar."_LN".$ln.".csv";
open OUTPUT, ">$outputfile" or die "failed to open file";
print OUTPUT "Distance From Center,LN$ln $xvar\n"; 
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
   
exit;