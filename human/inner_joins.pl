#!/usr/bin/perl
use DBI;
use DBD::mysql;
use Data::Dumper;
use IO::Handle;

#------------------------------------------------------------------------------
#            Taha Al-jumaily
#
# use: perl scriptname.pl ln_number 
# ------------------------------------------------------------------------ 
$dbh = DBI -> connect ('DBI:mysql:username;host=server.xxx.xxx;port=3306', 'username', 'password') or die "Could not connect to database: $DBI::errstr";

$ln = trim($ARGV[0]);
if(!$ln or $ln eq ""){ print "Enter LN, exiting...\n"; exit; }   

@context=("cwg","cg");
#@strand=("+","-");
@strandDiff=(-1,0);
@tables=("mdamb231_MR1","mdamb231_MR10");
for($i=1;$i<23;$i++){ push(@chromo,$i); } push(@chromo,('X','Y'));  

# ---------------------- writing to file(s) ---------------------- #
$outputfile = "/Users/taha/desktop/data"."/mdamb231"."_vs_LN".$ln.".csv";
open OUTPUT, ">$outputfile" or die "failed to open file";

foreach $t (@tables[0..$#tables]){
   foreach $c (@context[0..$#context]){
#      foreach $s (@strand[0..$#strand]){
         foreach $s (@strandDiff[0..$#strandDiff]){
            print OUTPUT "Chromosome,Same Hit Rows,Out Of, Table: $t: stranddiff:$s | context:$c\n"; #, Context: $c, numReads:$n, strandDiff:$s
            $combo = "AND (T1.context LIKE '$c' AND T1.strandDiff=$s)"; 
            #$pos = $s eq "+"?"txStart":"txEnd"; 
            foreach $chr (@chromo[0..$#chromo]){  
               $ir="SELECT ";
                  $ir.=" (SELECT COUNT(*) FROM $t AS T1 INNER JOIN YFM_LN".$ln."_chr".$chr." AS T2 ON (T1.chromStart=T2.startx)";
                  $ir.=" WHERE (T1.chrom LIKE 'chr$chr') $combo ) AS SameHits ";
                  $ir.=",";
                  $ir.=" (SELECT COUNT(*) FROM $t WHERE (chrom LIKE 'chr$chr' && ($t.context LIKE '$c' AND $t.strandDiff=$s))) AS OutOfT1";
               
               #print "\n\n$ir\n\n";exit;  
               
               $sth=$dbh->prepare($ir);
               $sth->execute();
               while(my $r=$sth->fetchrow_hashref()){ 
                  print OUTPUT "$chr,$r->{'SameHits'},$r->{'OutOfT1'}\n";
                  }$sth->finish;
               }
            print OUTPUT "\n";   
            }
         }
#      }
   }

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