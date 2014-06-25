#!/usr/bin/perl
use DBI;
use DBD::mysql;
use bignum;
use POSIX;
#------------------------------------------------------------------------------
#            Taha Al-jumaily
#------------------------------------------------------------------------------


my $dbh = DBI -> connect ('DBI:mysql:DatabaseName','UserName','PassWord') or die "Could not connect to database: $DBI::errstr";

#@C=('2L','2LHet','2R','2RHet','3L','3LHet','3R','3RHet','4','U','Uextra','X','XHet','YHet');   
@C=('2L','2R','3L','3R','X');

foreach(@C){
   $chr = $_."_chr";
   $sth = $dbh->prepare("SELECT COUNT(*) AS Rows FROM X_read_scores WHERE $chr>0");
   $sth->execute();
   while($ref = $sth->fetchrow_hashref()){ $prgs = $ref->{'Rows'}; }$sth->finish();
   
   print "Reading: $_ ($prgs possible entries)\n";
   
   $sth = $dbh->prepare("SELECT id,$chr FROM X_read_scores WHERE $chr>0 ORDER BY id ASC");
   $sth->execute();
   $j=1; @chromo=(); @id=();
   while(my $r = $sth->fetchrow_hashref()){
      # progress percentage bar
      show_progress($j/$prgs);
      
      $id[$i] = $r->{'id'};
      $chromo[$i] = $r->{$chr};
      if(($i > 0) && ($chromo[$i]<$chromo[$i-1] && $chromo[$i-1]>=$chromo[$i-2]) ){ 
         $dbh->do("INSERT INTO drosophila_computed_scores (chromosome,chr_center,score) VALUES ('$_',$id[$i-1],$chromo[$i-1])");
         $i = 0;
         @chromo=();
         @id=();
         }
      
      else{ $i++; }                      
      
      $j++;
      }$sth->finish;
   print "\n";
   }
   
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