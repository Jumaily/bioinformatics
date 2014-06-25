#!/usr/bin/perl
use DBI;
use DBD::mysql;
use POSIX;
#------------------------------------------------------------------------------
#            Taha Al-jumaily
#
#        calculate based on chromo reads
#
#
#------------------------------------------------------------------------------

$dbh = DBI -> connect ('DBI:mysql:DatabaseName','UserName','PassWord') or die "Could not connect to database: $DBI::errstr";

#chromosome & filename
%chromo = ('2L', 'na_arm2L.dmel.RELEASE5',
          '2LHet', 'na_2LHet.dmel.RELEASE5',	
          '2R', 'na_arm2R.dmel.RELEASE5',
          '2RHet', 'na_2RHet.dmel.RELEASE5',
          '3L', 'na_arm3L.dmel.RELEASE5',
          '3LHet', 'na_3LHet.dmel.RELEASE5',
          '3R', 'na_arm3R.dmel.RELEASE5',
          '3RHet', 'na_3RHet.dmel.RELEASE5',
          '4', 'na_arm4.dmel.RELEASE5',
          'U', 'na_armU.dmel.RELEASE5',
          'Uextra', 'na_armUextra.dmel.RELEASE5',
          'X', 'na_armX.dmel.RELEASE5',
          'XHet', 'na_XHet.dmel.RELEASE5',
          'YHet', 'na_YHet.dmel.RELEASE5');

#------------------------------------ Split based on chromosomes ---------------------------------------------------
 $i=0;
 while (($key, $value) = each(%chromo)){
    $t = "drosophila_2Rresults_".$key;
    $q = "INSERT INTO $t (bead_id, tag, chromosome, startx, endx, sequence, strand, length, paired_matches)
              SELECT bead_id, tag, chromosome, startx, endx, sequence, strand, length, paired_matches
              FROM drosophila_ALL_results WHERE (chromosome='$key') AND (paired_matches=1)";
    
    $dbh->do("TRUNCATE $t"); 
    $dbh->do($q);
    print "".(++$i)."\t inserted $key chromosome into -> $t\n";
    }
 
#------------------------------------ Calculations ------------------------------------------------------------------------
$path = "/Users/taha/Desktop/Dmel_Release5/";
while (($key, $value) = each(%chromo)){
   # put entire file in array
   open (INPUT_FILE, $path.$value) or die ("Failed to open $_");
   @afile = ();
   while ($lineR = <INPUT_FILE>){
      chomp ($lineR);
      if($lineR !~ m/^(>)/i){ 
         @chars = split(//, $lineR);
         foreach(@chars){ push(@afile,$_); }
         }
      } close(INPUT_FILE);
   
   $t = "drosophila_2Rresults_".$key;
   $sth = $dbh->prepare("SELECT bead_id, startx, endx FROM $t ORDER BY id");
   $sth->execute();
   while(my $ref = $sth->fetchrow_hashref()) {
      $bead_id[$i] = $ref->{'bead_id'};
      $start[$i] = $ref->{'startx'};
      $end[$i] = $ref->{'endx'};
   
      if(($i > 0) && ($bead_id[$i-1] eq $ref->{'bead_id'})){ 
         @arr = ($start[$i-1] , $end[$i-1] , $start[$i] , $end[$i]);
         ($min,$max) = (sort { $a <=> $b } @arr)[0,-1];
         
         # Chromosome Length
         $l = $max - $min;  
         
         # Chromosome Center
         $c = ceil( (($l + 1)/2) + $min );   
         
         # Chromosome Sequence
         $seq = "";
         while($min<=$max){ $seq = $seq.@afile[$min++]; }

         print "$key <> $ref->{'bead_id'}\n";
         $dbh->do("UPDATE $t SET start_end_seq='$seq', chr_length='$l ', chr_center='$c' WHERE bead_id='$ref->{'bead_id'}'");
         $i = 0;
         }
      
      else{ $i++; $l=0; $c=0; $s=''; }
      }$sth->finish;    
      
   print "Processed chromosome: ".$key."\t -> table: $t | file:".$value."\n";
   }
   
$dbh->disconnect;
exit;