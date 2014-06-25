#!/usr/bin/perl
use DBI;
use DBD::mysql;
use Data::Dumper;
use IO::Handle;
#------------------------------------------------------------------------------
#            Taha Al-jumaily
#
# *** specific reads
# ------------------------------------------------------------------------
# use: perl scriptname.pl ln_number "+" or "-"
# ------------------------------------------------------------------------ 
$dbh = DBI -> connect ('DBI:mysql:username;host=server.xxx.xxx;port=3306', 'username', 'password') or die "Could not connect to database: $DBI::errstr";

$ln = trim($ARGV[0]);
$s = trim(uc($ARGV[1]));
if(!$ln or $ln eq ""){ print "Enter LN, exiting...\n"; exit; }   
if(!$s or $s eq ""){ print "Enter Strand ('+' or '-'), exiting...\n"; exit; }
$s_pos = $s eq "+"?"txStart":"txEnd";

# Building 23 Chromosomes
@scopes=([16,68770500,68772000],
         [18,25756500,25761000],
         [4,57975500,57978000],
         [2,217559000,217562000],
         [2,217496500,217499000],
         [12,53490500,53492000]);

$limit = ''; #"LIMIT 100"; ------- # Limits if needed -------#
$bp_pos=73; # Base pair postion
$plusminus = 1000; # Score Arrays
@b=(0..(($plusminus*2)+$bp_pos));
for $bb(0..$#b){ $b[$bb]=0; } # zero-out array

foreach (@scopes){
   # Load ensGene position into array
   @ensGene=();
   $slcst = "SELECT DISTINCT $s_pos FROM ensGene WHERE ((chrom LIKE 'chr$scopes[$i][0]' AND strand='$s') && ($s_pos BETWEEN $scopes[$i][1] AND $scopes[$i][2])) ";
   $slcst.= "ORDER BY $s_pos $limit";
   $sth=$dbh->prepare($slcst);
   $sth->execute();
   while(my $r=$sth->fetchrow_hashref()){ push(@ensGene,($s eq "+"?$r->{$s_pos}+$bp_pos:$r->{$s_pos}-$bp_pos)); } $sth->finish;
   
   $arraySize = @ensGene;
   print "ensGene Table: chr$scopes[$i][0]\t[$scopes[$i][1],$scopes[$i][2]]\t$arraySize Rows\n";
   
    for my $c (0..$#ensGene){
       print "\t* $ensGene[$c]";     
       $srp="SELECT DISTINCT startx FROM YFM_LN".$ln."_chr$scopes[$i][0] ";
       $srp.="WHERE ((startx BETWEEN ".($ensGene[$c]-$plusminus)." AND ".($ensGene[$c]+$plusminus).") && (strand='$s')) "; 
       $srp.="ORDER BY startx";
       $sth=$dbh->prepare($srp);
       $sth->execute();
       if($sth->rows){
          print "\tYFM_LN".$ln."_chr$scopes[$i][0] table: ".$sth->rows." rows\n";
          while(my $r = $sth->fetchrow_hashref()){
             $center = $r->{'startx'}+$bp_pos;
             if($ensGene[$c] >= $center){ $v = $plusminus - abs($center - $ensGene[$c]); }
             else{ $v = $plusminus + abs($center - $ensGene[$c]); }
             $b[$v]++;
             }$sth->finish;           
          }
       }
   $i++;
   }

# ---------------------- writing to file(s) ---------------------- #
$outputfile = "/Users/taha/desktop/data"."/"."TransLN".$ln."_".$s.".csv";
open OUTPUT, ">$outputfile" or die "failed to open file";
print OUTPUT "Distance From TSS(bp),Midpoints\n"; 
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