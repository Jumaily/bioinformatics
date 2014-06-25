#!/usr/bin/perl
use DBI;
use DBD::mysql;
#------------------------------------------------------------------------------
#            Taha Al-jumaily
#
#------------------------------------------------------------------------------

$dbh = DBI -> connect ('DBI:mysql:DatabaseName','UserName','PassWord') or die "Could not connect to database: $DBI::errstr";

%C = ('2L',0, '2LHet',0, '2R', 0, '2RHet', 0, '3L', 0, '3LHet',0, '3R', 0, '3RHet',0, '4', 0, 'U', 0, 'Uextra',0, 'X', 0, 'XHet', 0, 'YHet',0);
$table_readfrom = "seq_results_counts_133_157";

$dbh->do("TRUNCATE seq_results_scores"); 
while (($key, $value) = each(%C)){
   $sth = $dbh->prepare("SELECT  count(*) AS Rows FROM drosophila_2Rresults_$key");
   $sth->execute();
   while($ref = $sth->fetchrow_hashref()) {  
      $C{$key} = $ref->{'Rows'};
      print "$key -- $ref->{'Rows'} Rows\n";
      }
   $sth->finish();
   }

   
while (($key, $value) = each(%C)){
   %alpha=('AA',0, 'AT',0, 'TA',0, 'TT',0, 'AC',0, 'AG',0, 'TC',0, 'TG',0, 'CC',0, 'CG',0, 'GC',0, 'GG',0, 'CA',0, 'CT',0, 'GA',0, 'GT',0);
   $sth = $dbh->prepare("SELECT  *  FROM $table_readfrom WHERE gene_name='$key'");
   $sth->execute();
   while($ref = $sth->fetchrow_hashref()){
      while (($k, $v) = each(%alpha)){ 
         $alpha{$k}=($ref->{$k}/$value)*(1000000); 
         }
      
      $insert = $dbh->prepare("INSERT INTO seq_results_scores (gene_name, posnum, AA, AT, TA, TT, AC, AG, TC, TG, CC, CG, GC, GG, CA, CT, GA, GT) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
      $insert->execute($ref->{'gene_name'}, $ref->{'posnum'}, $alpha{'AA'}, $alpha{'AT'}, $alpha{'TA'}, $alpha{'TT'}, $alpha{'AC'}, $alpha{'AG'}, $alpha{'TC'}, $alpha{'TG'}, $alpha{'CC'}, $alpha{'CG'}, $alpha{'GC'}, $alpha{'GG'}, $alpha{'CA'}, $alpha{'CT'}, $alpha{'GA'}, $alpha{'GT'});
      } 
   $sth->finish(); 
   }
             
$dbh->disconnect;
exit;