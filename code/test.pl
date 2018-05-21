use strict;
use Data::Dumper;
open (FILE, $ARGV[0]) or die ("cannot open file");
my @data = <FILE>;
close (FILE);


my %level_db = ();
my $counter = 0;

my $n=0;
foreach my $line (@data){
  chomp($line);
  my $currlevel = find_level($line);
#  print "$currlevel\t$line\n";
}

my %hash = ();
my %hashparent = ();
my %all = ();
my %level = ();
my $length = @data;
for (my $i=0; $i <$length; $i++){
  chomp ($data[$i]);
  chomp ($data[$i+1]);
  my $curr = $data[$i];
  my $next = $data[$i+1];
  my $currlevel = find_level($curr);
  if ($currlevel==1){
    $level{1}=$i;
  }
  else {
     my $plevel = $currlevel -1;
     $hash{$level{$plevel}} .= "$i ";
     $hashparent{$i} = $level{$plevel};
     $level{$currlevel} = $i;
  }

}


my @keys = keys (%hash);
foreach my $key (@keys){
  my $val = $hash{$key};
  my @val = split (" ", $val);
  foreach my $line (@val){
    my $dat=$data[$key];
    my $l = $data[$line];


    $dat=~s/\s*$//;
    $dat=~s/^\s*//;

    $l=~s/\s*$//;
    $l=~s/^\s*//;

    $dat=~s/#//g;
    $l=~s/#//g;

    $dat=~s/ /./g;
    $l=~s/ /./g;
    print "$dat\t7\t$l\t100\n";

  }

}






sub find_level{
   my ($line) = @_;
   $line=~s/\S.*//;
   $line=~s/\s/./g;
   my $length = length ($line);
   if (!$level_db{$length}){
     $counter++;
     $level_db{$length}=$counter;
   }
   return  $level_db{$length};
}
