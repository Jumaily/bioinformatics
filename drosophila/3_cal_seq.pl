#!/usr/bin/perl
use DBI;
use DBD::mysql;
use POSIX;
use Data::Dumper;
#------------------------------------------------------------------------------
#            Taha Al-jumaily
#
#      read calculations
#
#
#------------------------------------------------------------------------------

$dbh = DBI -> connect ('DBI:mysql:DatabaseName','UserName','PassWord') or die "Could not connect to database: $DBI::errstr";

$L=133; $H=158;
#chromosome & filename
@C = ('2L', '2LHet', '2R', '2RHet', '3L', '3LHet', '3R', '3RHet', '4', 'U', 'Uextra', 'X', 'XHet', 'YHet');

$table="seq_results_counts_".$L."_".($H-1);
$dbh->do("TRUNCATE $table"); 
foreach(@C){
   $t = "drosophila_2Rresults_".$_;
   print "\t\t Reading: $t \n";
   
   # zero out counters & create array
   %g=('AA',0, 'AT',0, 'TA',0, 'TT',0, 'AC',0, 'AG',0, 'TC',0, 'TG',0, 'CC',0, 'CG',0, 'GC',0, 'GG',0, 'CA',0, 'CT',0, 'GA',0, 'GT',0);
   @alpha = ();
   for($i=1;$i<=$H;$i++){ push @alpha, { %g }; } 
         
   $sth = $dbh->prepare("SELECT start_end_seq,COUNT(bead_id) FROM $t WHERE chr_length BETWEEN $L AND ".($H-1)." GROUP BY bead_id HAVING COUNT(bead_id)>=1 ORDER BY id ASC");
   $sth->execute();
   while(my $r = $sth->fetchrow_hashref()) {
      @seq = split('',$r->{'start_end_seq'});
      $ss = @seq;   
      
      # align sequence 
      if($ss<$H){ unshift(@seq,1..( ceil(($H-$ss)/2) )); }
      
      for($i=0; $i<@seq; $i++){
         if($i>0){
            $di=uc(@seq[$i-1].@seq[$i]);
            # make sure numbers are not counted in sequence position & Update array counter
            if ($di !~ m/[^a-zA-Z]/){ $alpha[$i]{$di}++;  }
            }
         }
      }$sth->finish;      
   
   # prepare to insert results
   $insert = $dbh->prepare("INSERT INTO $table (gene_name, posnum, AA, AT, TA, TT, AC, AG, TC, TG, CC, CG, GC, GG, CA, CT, GA, GT) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
   for($i=1;$i<$H;$i++){
      $insert->execute($_, $i, $alpha[$i]{'AA'}, $alpha[$i]{'AT'}, $alpha[$i]{'TA'}, $alpha[$i]{'TT'}, $alpha[$i]{'AC'}, $alpha[$i]{'AG'}, $alpha[$i]{'TC'}, $alpha[$i]{'TG'}, $alpha[$i]{'CC'}, $alpha[$i]{'CG'}, $alpha[$i]{'GC'}, $alpha[$i]{'GG'}, $alpha[$i]{'CA'}, $alpha[$i]{'CT'}, $alpha[$i]{'GA'}, $alpha[$i]{'GT'});
      }
   }

$dbh->disconnect;
exit;