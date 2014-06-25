#!/usr/bin/perl
use DBI;
use DBD::mysql;
use Data::Dumper;
use IO::Handle;

#------------------------------------------------------------------------------
#            Taha Al-jumaily
#   Create wiggle format for :
# http://genome.ucsc.edu/goldenPath/help/wiggle.html
# ------------------------------------------------------------------------
# use: perl scriptname.pl ln_number chromosome_number
# ------------------------------------------------------------------------ 
$dbh = DBI -> connect ('DBI:mysql:username;host=server.xxx.xxx;port=3306', 'username', 'password') or die "Could not connect to database: $DBI::errstr";

$ln = trim($ARGV[0]);
$chr = trim(uc($ARGV[1]));
if(!$ln or $ln eq ""){ print "Enter LN, exiting...\n"; exit; }   
if(!$chr or $chr eq ""){ print "Enter Chromosome, exiting...\n"; exit; }

$limit = '';#"LIMIT 1000";

# Create Gaussian numbers
$bp_pos=73; # Base pair postion
%G=();
foreach(0..$bp_pos){ $G{$_} = (exp(-0.5*($_/20)**2)); } 

  
%a=();
$i=1;
$sth = $dbh->prepare("SELECT startx FROM YFM_LN".$ln."_chr$chr ORDER BY startx $limit");
$sth->execute();
print "\t\tProcessing LN:$ln\tChromosom:$chr\tRows: ".commify($sth->rows)."\n";
while(my $r = $sth->fetchrow_hashref()){
   # progress percentage bar
   #show_progress($i/$sth->rows);
   %cx=();
   $center = $r->{'startx'}+$bp_pos;
   $cx{$center} = 1;
   for($x=$bp_pos;$x>=1;$x--){ 
      $y = ($bp_pos-$x)+1;
      $bppx = $center-$x;
      $bppy = $center+$y;
      $cx{$bppx} += $G{$x};
      $cx{$bppy} += $G{$y};
      #print "$x\t$bppx\t$G{$x} |\t $y\t$bppy\t$G{$y}\n";
      } 
                        # Add Values & Computation
   for($r->{'startx'}..($r->{'startx'}+($bp_pos*2))){ $a{$_} += $cx{$_} }
   $i++;  
   }$sth->finish;

$elements=scalar(keys %a);
$i=1;

print "\t\tCreating WIG file.\t Total Lines: ".commify($elements)."\n";
$dirx = "/home/talju0/wiggles/LN$ln"."/"."chr$chr";
$fbname = "LN".$ln."_chr".$chr;
system("mkdir -p $dirx");
$outputfile = $dirx."/".$fbname.".wig";

# Creating the wiggles
open OUTPUT, ">$outputfile" or die "failed to open file";
print OUTPUT "track	type=wig	name=\"Data Results for chr_$chr\" description=\"LN:$ln Chromosome:$chr\" ";
print OUTPUT "visibility=full color=200,50,79 autoScale=on	graphType=bar\n";
print OUTPUT "variableStep	chrom=chr$chr\n";   
for $k(sort {$a<=>$b} keys %a){
   #show_progress($i/$elements);
   print OUTPUT "$k $a{$k}\n"; 
   $i++;
   } 
close OUTPUT;
system("gzip -f $outputfile");   
   

sub flush{ my $h = select($_[0]); my $a=$|; $|=1; $|=$a; select($h); }
sub show_progress{
   my ($progress) = @_;
   my $percent = int($progress*100);
   $percent = $percent >= 100 ? "done.\n" : $percent.'%';
   print("\r \t $percent");
   flush(STDOUT);
   }
sub commify{
   my $text = reverse $_[0];
   $text =~ s/(\d\d\d)(?=\d)(?!\d*\.)/$1,/g;
   return scalar reverse $text
   }
sub trim($){
   my $string = shift;
   $string =~ s/^\s+//;
   $string =~ s/\s+$//;
   return $string;
   }
   
$dbh->disconnect;   
exit;