#!/usr/bin/perl
use DBI;
use DBD::mysql;
use bignum;
use POSIX;
#------------------------------------------------------------------------------
#            Taha Al-jumaily
#
#------------------------------------------------------------------------------


my $dbh = DBI -> connect ('DBI:mysql:DatabaseName','UserName','PassWord') or die "Could not connect to database: $DBI::errstr";
$table = 'X_read_scores';

$bp_pos=60;
#@C=('2L','2LHet','2R','2RHet','3L','3LHet','3R','3RHet','4','U','Uextra','X','XHet','YHet');
# '2L','2R','3L','3R','X',           
@C=('2RHet','3LHet','3RHet','4','U','Uextra');


# Create Gaussian numbers
print "\n* Creating Gaussian Values Hash...\n";
%G=();
foreach(0..$bp_pos){ $G{$_} = (exp(-0.5*($_/20)**2)); }

foreach(@C){
   print " of $_ chromosome complete";

   $sth = $dbh->prepare("SELECT COUNT(*) AS Rows FROM drosophila_computed_results WHERE chromosome='$_'");
   $sth->execute();
   while($ref = $sth->fetchrow_hashref()){ $prgs = $ref->{'Rows'}; }$sth->finish();
   $prgsi = floor($prgs * 0.01);
   
   $sth = $dbh->prepare("SELECT chr_length,chr_center FROM drosophila_computed_results WHERE chromosome='$_' ");
   $sth->execute();
   $i=1;
   while(my $r = $sth->fetchrow_hashref()){
      # progress percentage bar
      if($i % $prgsi == 0){ show_progress($i/$prgs); }  
      
      $center = $r->{'chr_center'};
      $length = $r->{'chr_length'};
      %cx=();
      #print "$length\t$center\n";
      
      if($length % 2 == 0){ # Even lengths
         $d = 2;
         # Two centers are 1s
         $cx{$center} = 1;
         $cx{$center+1} = 1;
         foreach $mid ($center,$center+1){
            for($x=$bp_pos;$x>=1;$x--){
               $y = ($bp_pos-$x)+1;
               $bppx = $mid-$x;
               $bppy = $mid+$y;
               $cx{$bppx} += $G{$x};
               $cx{$bppy} += $G{$y};
               #print "$x\t$bppx\t$G{$x}\t$y\t$bppy\t$G{$y}\n";
               }
            }
         }
      else{ # Odd lengths
         $cx{$center} = 1;
         $d = 1;
         for($x=$bp_pos;$x>=1;$x--){ 
            $y = ($bp_pos-$x)+1;
            $bppx = $center-$x;
            $bppy = $center+$y;
            $cx{$bppx} += $G{$x};
            $cx{$bppy} += $G{$y};
            } 
         }
      
      # Process calculated scores
      $j = 1;
      $k = scalar(keys %cx);
      foreach $key (sort keys(%cx)){
         if($j==1 || $j==$k){ $center_gauss = $cx{$key}; } 
         else{ $center_gauss = $cx{$key}/$d; }
         
         # updating database with score numbers
         $col=$_."_chr";
         $sthx = $dbh->prepare("SELECT $col FROM $table WHERE id=$key\n");
         $sthx->execute();
         while(my $v = $sthx->fetchrow_hashref()){ $colx = $v->{$col} + $center_gauss; } $sthx->finish;
         $dbh->do("UPDATE $table SET $col=$colx WHERE id=$key");
         $j++;
         }
               
      $i++;
      }$sth->finish;
   print "\n";
   }
   
sub flush{ my $h = select($_[0]); my $a=$|; $|=1; $|=$a; select($h); }
sub show_progress {
   my ($progress) = @_;
   my $percent = int($progress*100);
   $percent = $percent >= 100 ? 'done.' : $percent.'%';
   print("\r processing: $percent");
   flush(STDOUT);
   }
      
$dbh->disconnect;
exit;