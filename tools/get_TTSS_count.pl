#!/usr/bin/perl
use DBI;
use DBD::mysql;
use Data::Dumper;
use IO::Handle;

# ------------------------------------------------------------------------
#  Taha Al-jumaily
# get count with specific xxx
# use: perl scriptname.pl ln_number "+" or "-"
# ------------------------------------------------------------------------ 
$dbh = DBI -> connect ('DBI:mysql:username;host=server.xxx.xxx;port=3306', 'username', 'password') or die "Could not connect to database: $DBI::errstr";

%se=('txStart'=>"+",'txEnd'=>"-");

# Building 23 Chromosomes
@chromo=();
for($i=1;$i<23;$i++){ push(@chromo,$i); } push(@chromo,('X','Y'));  

print "strand\t ,chromosome\t ,rows\n";

foreach my $s (keys %se){
   # ----- Chromosomes ------
   foreach $chr (@chromo[0..$#chromo]){
      $sth=$dbh->prepare("SELECT COUNT(DISTINCT $s) AS rows FROM ensGene WHERE (chrom LIKE 'chr$chr' AND strand='$se{$s}') ORDER BY $s");
      $sth->execute();
      while(my $r = $sth->fetchrow_hashref()){ print "$se{$s}\t ,chr$chr\t ,$r->{'rows'}\n"; }$sth->finish;  
      }
   }

   
$dbh->disconnect;   
exit;