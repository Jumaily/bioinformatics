#!/usr/bin/perl
use DBI;
use DBD::mysql;
use IO::Handle;

# -----------------------------
#  Taha Al-jumaily
#
# Create blank entries
#
# Use: scriptname.pl table_name
# -----------------------------

system("clear");
my $table=shift;
if(!$table or $table eq ""){ print "Enter Table Name, exiting…\n"; exit; }

$dbh = DBI -> connect ('DBI:mysql:username;host=SERVER.xxx.xxx', 'username', 'password') or die "Could not connect to database: $DBI::errstr";
$dbh->do("TRUNCATE $table"); 

$j = 250000000;
for($i=1;$i<=$j;$i++){ 
   $dbh->do("INSERT INTO $table (1_chr) VALUES (0)");
   show_progress($i/$j);
   }
   
   
sub flush{ my $h = select($_[0]); my $a=$|; $|=1; $|=$a; select($h); }
sub show_progress {
   my ($progress) = @_;
   my $percent = int($progress*100);
   $percent = $percent >= 100 ? "100%\n" : $percent.'%';
   print("\rProcessing Table: $table \t $percent");
   flush(STDOUT);
   }


$dbh->disconnect;
exit;
