#!/usr/bin/perl
use DBI;
use DBD::mysql;
use Data::Dumper;
use IO::Handle;
#------------------------------------------------------------------------------
#            Taha Al-jumaily
#
# ------------------------------------------------------------------------
# use: perl scriptname.pl ln_number context nreads
# ------------------------------------------------------------------------ 
$dbh = DBI -> connect ('DBI:mysql:username;host=server.xxx.xxx;port=3306', 'username', 'password') or die "Could not connect to database: $DBI::errstr";

$ln = trim($ARGV[0]);
$ctx = trim(lc($ARGV[1]));
$sd = trim($ARGV[2]);
$nr = trim($ARGV[3]);
if(!$ln or $ln eq ""){ print "Enter LN, exiting...\n"; exit; }   
if(!$ctx or $ctx eq ""){ print "Enter context, exiting...\n"; exit; }
if(!$sd or $sd eq ""){ print "Enter StrandDiff, exiting...\n"; exit; }
if(!$nr or $nr eq ""){ print "Enter NR, exiting...\n"; exit; }

# Building 23 Chromosomes
@chromo=();
for($i=1;$i<23;$i++){ push(@chromo,$i); } push(@chromo,('X','Y'));  

$limit = '';#"LIMIT 10"; #------- # Limits if needed -------#
$bp_pos=73; # Base pair postion
$plusminus = 1000; # Score Arrays
my @b=();
@b=(0..(($plusminus*2)+$bp_pos));
for $bb(0..($#b+$bp_pos)){ $b[$bb]=0; } # zero-out array

# ----- Chromosomes Calc ------ #
foreach $chr (@chromo[0..$#chromo]){  
   # Load ensGene position into array
   @ensGene=();

   $ir="SELECT DISTINCT chromStart FROM mdamb231_MR$nr WHERE ((chrom LIKE 'chr$chr' AND context LIKE '$ctx') && (strandDiff=$sd)) ORDER BY chromStart $limit";
   $sth=$dbh->prepare($ir);
   $sth->execute();
   while(my $r=$sth->fetchrow_hashref()){ push(@ensGene,($r->{"chromStart"}+$bp_pos)); } $sth->finish;
   
   #print "* Processing LN: $ln\tContext: $ctx\t#Reads: $nr\tChromosome: $chr\tRows: ".($#ensGene+1)."\n";   
   
   for my $c (0..$#ensGene){     
      $srp="SELECT DISTINCT startx FROM YFM_LN".$ln."_chr$chr ";
      $srp.="WHERE ((startx BETWEEN ".($ensGene[$c]-$plusminus)." AND ".($ensGene[$c]+$plusminus).") ) ";
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
$outputfile = "/home/talju0/data/mdamb_data"."/"."mdamb231_MR$nr"."_LN".$ln."_".$ctx."_strandDiff_".$sd.".csv";
open OUTPUT, ">$outputfile" or die "failed to open file";
print OUTPUT "Distance From TSS(bp), mdamb231_MR$nr - LN$ln context:$ctx strandDiff:$sd\n"; 
for $bb(0..$#b){ print OUTPUT "$bb,$b[$bb]\n"; }
close OUTPUT;
print "\t\tCreating file: "."mdamb231_MR$nr - LN$ln context:$ctx strandDiff:$sd\n";
    

# ---------------------- Subroutines ----------------------------- # 
sub trim($){
   my $string = shift;
   $string =~ s/^\s+//;
   $string =~ s/\s+$//;
   return $string;
   }
   
exit;