#!/usr/bin/perl
use DBI;
use DBD::mysql;

#------------------------------------------------------------------------------
#            Taha Al-jumaily
#------------------------------------------------------------------------------

my $dbh = DBI -> connect ('DBI:mysql:DatabaseName','UserName','PassWord') or die "Could not connect to database: $DBI::errstr";
$bpdist = 107;
$table1 = 'drosophila_computed_scores';
$table2 = $table1.'_'.$bpdist;

$dbh->do("TRUNCATE $table2");

@C=('2L','2LHet','2R','2RHet','3L','3LHet','3R','3RHet','4','U','Uextra','X','XHet','YHet');   
foreach(@C){
   $sth = $dbh->prepare("SELECT COUNT(*) AS Rows FROM $table1 WHERE chromosome='$_'");
   $sth->execute();
   while($ref = $sth->fetchrow_hashref()){ $prgs = $ref->{'Rows'}; }$sth->finish();
   
   print "* Processing $_ chromosome ($prgs)…\n";
   $i=1; @sc=(); @score=(); %chsc=();
      
   $sth = $dbh->prepare("SELECT chr_center,score FROM $table1 WHERE chromosome='$_' ORDER BY score DESC");
   $sth->execute();
   while(my $r = $sth->fetchrow_hashref()){
      show_progress($i/$prgs);
      
      $ch[$i] = $r->{'chr_center'};
      $score[$i] = $r->{'score'};      

      if(abs($ch[$i]-$ch[$i-1]) > $bpdist){
         $j = $ch[$i]-$bpdist;
         $k = $ch[$i]+$bpdist;
         $a = 1;
         
         while($j<=$k){
            if($chsc{$j}>0){ 
               $a = 0; 
               $j = $k;
               }
            $j++;
            }
         
         if($a){ 
            $chsc{$ch[$i]} = $score[$i];
            $dbh->do("INSERT INTO $table2 (chromosome,chr_center,score) VALUES ('$_',$ch[$i],$score[$i])");
            }
         }
       
      $i++;
      }$sth->finish;
   print "\n"; 
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