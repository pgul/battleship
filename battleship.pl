#! /usr/bin/perl
use warnings;
use strict;

use constant SIZE => 10; # each dimention

sub main {
    my $field = read_field();

    my $count_hits = 0;
    my $count_neighbors = 0;
    for (my $i=0; $i < SIZE; $i++) {
        for (my $j=0; $j < SIZE; $j++) {
            if ($field->[$i]->[$j]) {
                $count_hits++;
                $count_neighbors += $field->[$i+1]->[$j] if $i+1 < SIZE;
                $count_neighbors += $field->[$i]->[$j+1] if $j+1 < SIZE;
                # Special case for ships with square 2x2, remove if not possible
                if ($i+1 < SIZE && $j+1 < SIZE) {
                    $count_neighbors-- if $field->[$i+1]->[$j] && $field->[$i]->[$j+1] && $field->[$i+1]->[$j+1];
                }
            }
        }
    }
    printf "There are %u ships\n", $count_hits - $count_neighbors;
}

sub read_field {
    my $field = [];
    my $i = 0;
    while (my $line = <>) {
        chomp($line);
        length($line) == SIZE
            or die "Length of each line must be " . SIZE . "\n";
        $i < SIZE
            or die "Too many input lines, should be " . SIZE . "\n";
        $field->[$i] = [ map { $_ ne ' ' } split(//, $line) ];
        $i++;
    }
    $i == SIZE
        or die "Not enough input lines, should be " . SIZE . "\n";
    return $field;
}

main();
