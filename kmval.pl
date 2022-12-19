#!/usr/bin/perl

# script key multiple values
# run script pipe to sed 's/://'

use strict;

my %k_vals;

while (<>) {
	#print;
	my @F = split(/\./); 		#dot
	#print "1. $F[1]\n";
	my @G = split(/\(/, $F[1]); 	#right paren
	#print "1.2. key=$G[0]\n";
	my $key = $G[0];		#key
	$G[1] =~ s/\)//; 		#remove trailing )
	#print "2. $G[1]\n";
	my @H = split(/,/, $G[1]);	#comma
	my $i = 0;			#index
	foreach (@H) {
		my $value;
		if ($_ !~ /^$/) {
			#print "3 value = $_\n";
			$value = $_;
			$k_vals{$key}[$i] = $value;
			$i++;
		}
	}
}


#foreach my $k (keys (%k_vals)) {
	#print "9. $k\n";
	##print "9.1 values = @{ $k_vals{$k} } \n";
	#foreach (@{ $k_vals{$k} }) {			#array
		#print "9.2 $_\n";
	#}
#}

foreach my $k (keys (%k_vals)) {
	#print "9. $k\n";
	#print "9.1 values = @{ $k_vals{$k} } \n";
	my @F = @{ $k_vals{$k} } ;
	my $len = $#F;
	if ($len == 0) {
		foreach (@{ $k_vals{$k} }) {			#array
			print "$k,$_\n";
		}
	}
	else {
		foreach (@{ $k_vals{$k} }) {			#array
			print "$k:[$len],$_\n";
			$len--;
		}
	}
}

exit();

###

# Input file:
# misc.key1(v),
# misc.key2(v1,v2,v3),
# misc.key3(a,b,c),
# misc.key4(x,y,z),


# input:
# misc.key2(v11,v2,v3),
# expected output:
# key2[2],v1
# key2[1],v2
# key2[0],v3 
