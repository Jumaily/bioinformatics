#!/usr/bin/perl
use DBI;
use DBD::mysql;
use IO::Handle;
autoflush STDERR,1;

# ----------------------------------------------
#  Taha Al-jumaily
#  read text file and insert into DB
#
# use: perl scriptname.pl tablename textfile.txt
# ----------------------------------------------

$table = trim($ARGV[0]);
$fasta_file = trim($ARGV[1]);
open(INPUT_FILE, $fasta_file) or die "can't open $fasta_file\n";
if(!$table or $table eq ""){ print "Enter Table Name, exiting...\n"; exit; }   

# Get total Number of Lines
$files_lines = trim(`wc -l < $fasta_file`);

print "\n\n------ Script started: ".`date`."Reading file: $fasta_file (".commify($files_lines)." Lines)\n";  

# - - - - - - - - - - - - - - - - - - - - - - Putting Data from text file into database - - - - - - - - - - - - - -
$dbh = DBI -> connect ('DBI:mysql:username', 'username', 'password') or die "Could not connect to database: $DBI::errstr";
$dbh->do("TRUNCATE $table"); 
$insert = $dbh->prepare("INSERT INTO $table (chrom,chromStart,chromEnd,context,numReads,methRatio,strandDiff) VALUES (?,?,?,?,?,?,?)");

$i=1;
while ($lineR = <INPUT_FILE>){
   show_progress($i/$files_lines);
   chomp ($lineR);
   if($lineR !~ m/^(chrom)/i){ 
      my @argx = split(/\t/,$lineR);
      $insert->execute($argx[0],$argx[1],$argx[2],$argx[3],$argx[4],$argx[5],$argx[6]);
      } $i++;
   }$insert->finish();

close(INPUT_FILE);
$dbh->disconnect;
print "\n------ Script ended: ".`date`."\n\n";

sub trim($){
   my $string = shift;
   $string =~ s/^\s+//;
   $string =~ s/\s+$//;
   return $string;
   }
sub flush{ my $h = select($_[0]); my $a=$|; $|=1; $|=$a; select($h); }
sub show_progress {
   my ($progress) = @_;
   my $percent = int($progress*100);
   $percent = $percent >= 100 ? 'done.' : $percent.'%';
   print("\r \t $percent");
   flush(STDOUT);
   }
sub commify {
   my $text = reverse $_[0];
   $text =~ s/(\d\d\d)(?=\d)(?!\d*\.)/$1,/g;
   return scalar reverse $text
   }
exit;