#!/usr/bin/perl
use DBI;
use DBD::mysql;
use IO::Handle;
autoflush STDERR,1;

#------------------------------------------------------------------------------
#            Taha Al-jumaily
#
#  importing data from textfile to Database
#
#
#------------------------------------------------------------------------------

system("clear");$i=0;
if ($#ARGV < 0) { print "\n*** Error: Usage - scriptname.pl input_filename.txt \n"; exit; }
print "----------: Script started: ".`date`."Reading file: $input_file_name\n";  


# - - - - - - - - - - - - - - - - - - - - - - Putting Data from text file into database - - - - - - - - - - - - - -
$input_file_name = $ARGV[0];
open (INPUT_FILE, "<$input_file_name") or die ("Failed to open $input_file_name");
$dbh = DBI -> connect ('DBI:mysql:DatabaseName','UserName','PassWord') or die "Could not connect to database: $DBI::errstr";
$dbh->do("TRUNCATE drosophila_ALL_results"); 
$insert = $dbh->prepare("INSERT INTO drosophila_ALL_results (bead_id,tag,chromosome,startx,endx,sequence,strand,length,paired_matches) VALUES (?,?,?,?,?,?,?,?,?)");
while ($lineR = <INPUT_FILE>){
   chomp ($lineR);
   if($lineR !~ m/^(Bead)/i){ 
      my @argx = split(/\t/,$lineR);
      $insert->execute($argx[0],$argx[1],$argx[2],$argx[3],$argx[4],$argx[5],$argx[6],$argx[7],$argx[8]);
      }
   }close (INPUT_FILE);
$insert->finish();

   
$dbh->disconnect;
print "----------: Script ended: ".`date`;
exit;