#!/usr/bin/perl
use DBI;
use DBD::mysql;
$dbh = DBI -> connect ('DBI:mysql:username;host=server.xxx.xxx;port=3306', 'username', 'password') or die "Could not connect to database: $DBI::errstr";
#------------------------------------------------------------------------------
#            Taha Al-jumaily
# split tables based on chromosomes & build a zero out table
#------------------------------------------------------------------------------

# Building 23 Chromosomes
@chromo=();
for($i=1;$i<23;$i++){ push(@chromo,$i); } push(@chromo,('X','Y'));  
@ln=(4,5);

$incs=1000000;
$max=250*$incs;

# -- reads -- #
foreach $l (@ln[0..$#ln]){

   # ----- Chromosomes ------ #
   foreach $chr (@chromo[0..$#chromo]){
      $t = "YFM_LN".$l."_chr".$chr;
      $dbh->do("DROP TABLE IF EXISTS $t");
      $dbh->do("CREATE TABLE $t (id int(11) unsigned NOT NULL AUTO_INCREMENT, bead_id varchar(50), startx int(25), strand varchar(5), PRIMARY KEY (id), KEY startx (startx))");      

      # selects by ranges since server is slow      
       for($i=0;$i<$max;$i+=$incs){
          $q = "INSERT INTO $t (bead_id, startx, strand) (SELECT bead_id, startx, strand FROM YFM_LN".$l;
          $q.= " WHERE ((chromosome='chr$chr' AND paired_matches=1) && (id between $i AND ".($i+$incs-1).")))";
          
          $dbh->do($q);
          }
      print "$t\n";
      }
   }
    
$dbh->disconnect;
exit;