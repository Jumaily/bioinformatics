#!/usr/bin/perl
use DBI;
use DBD::mysql;

#------------------------------------------------------------------------------
#            Taha Al-jumaily
# Create a wiggle form text file - 
# http://genome.ucsc.edu/goldenPath/help/wiggle.html
#------------------------------------------------------------------------------

my $dbh = DBI -> connect ('DBI:mysql:DatabaseName','UserName','PassWord') or die "Could not connect to database: $DBI::errstr";
$table1 = 'drosophila_computed_scores_107';

#@C=('2L','2LHet','2R','2RHet','3L','3LHet','3R','3RHet','4','U','Uextra','X','XHet','YHet');
@C=('YHet');
foreach(@C){
   open OUTPUT, ">/Users/taha/Desktop/wigles/$_".".wig" or die "failed to open file";
   print OUTPUT "track	type=wig	name=\"Data Results $_\" description=\"$_ Chromosome\" ";
   print OUTPUT "visibility=full color=200,50,79 autoScale=on	graphType=bar\n";
   print OUTPUT "variableStep	chrom=chr$_\n";


   $sth = $dbh->prepare("SELECT COUNT(*) AS Rows FROM $table1 WHERE chromosome='$_'");
   $sth->execute();
   while($ref = $sth->fetchrow_hashref()){ $prgs = $ref->{'Rows'}; }$sth->finish();
   
   
   print "* Processing $_ chromosome ($prgs)…\n";
   $i=1;
   $chr = $_."_chr";
   
   $sth = $dbh->prepare("SELECT chr_center FROM $table1 WHERE chromosome='$_' ORDER BY chr_center ASC");
   $sth->execute();
   while(my $r = $sth->fetchrow_hashref()){
      show_progress($i/$prgs);
      $chm60 = $r->{'chr_center'}-53;
      $chp60 = $r->{'chr_center'}+53;
      
      $sthx = $dbh->prepare("SELECT id,$chr FROM X_read_scores WHERE id BETWEEN $chm60 AND $chp60 ORDER BY id ASC");
      $sthx->execute();
      while(my $rx = $sthx->fetchrow_hashref()){
         print OUTPUT "$rx->{'id'} $rx->{$chr}\n";
         }$sthx->finish;
   
      $i++;
      }$sth->finish;
      
   print "\n"; 
   close OUTPUT;
   }
   
#--------------------------------------------------------------------------------------------------------------   
sub flush{ my $h = select($_[0]); my $a=$|; $|=1; $|=$a; select($h); }
sub show_progress {
   my ($progress) = @_;
   my $percent = int($progress*100);
   $percent = $percent >= 100 ? "\t100%\tComplete!" : "\t$percent".'%';
   print("\r $percent");
   flush(STDOUT);
   }
   

$dbh->disconnect;
exit;