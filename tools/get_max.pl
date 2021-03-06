#!/usr/bin/perl
use DBI;
use DBD::mysql;
use IO::Handle;

#  Taha Al-jumaily
#
# get max rows from each table

$dbh = DBI -> connect ('DBI:mysql:username;host=server.xxx.xxx;port=3306', 'username', 'password') or die "Could not connect to database: $DBI::errstr";

@ln=(4,5);
@chromo=();
for($i=1;$i<23;$i++){ push(@chromo,$i); } push(@chromo,('X','Y'));


foreach $l (@ln[0..$#ln]){
   foreach $chr (@chromo[0..$#chromo]){ 
      $sth = $dbh->prepare("SELECT count(*) AS Rows FROM YFM_LN".$l."_chr$chr");
      $sth->execute();
      while(my $r = $sth->fetchrow_hashref()){ print "LN $l\tChromosom:$chr\t".commify($r->{'Rows'})."\n"; }$sth->finish;  
      }   
   }
   
   
sub commify {
   my $text = reverse $_[0];
   $text =~ s/(\d\d\d)(?=\d)(?!\d*\.)/$1,/g;
   return scalar reverse $text
   }


print "\n";
$dbh->disconnect;
exit;