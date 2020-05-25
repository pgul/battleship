#! /usr/bin/perl
use warnings;
use strict;

sub main {
    my $field = read_field();

    my $count_hits = 0;
    my $count_neighbors = 0;
    for (my $i=0; $field->[$i]; $i++) {
        for (my $j=0; $j < @{$field->[$i]}; $j++) {
            if ($field->[$i]->[$j]) {
                $count_hits++;
                # Read value out of array bounds is OK for perl
                $count_neighbors++ if $field->[$i+1]->[$j];
                $count_neighbors++ if $field->[$i]->[$j+1];
                # Special case for ships with square 2x2, remove if not possible
                $count_neighbors-- if $field->[$i+1]->[$j] && $field->[$i]->[$j+1] && $field->[$i+1]->[$j+1];
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
        $field->[$i] = [ map { $_ ne ' ' } split(//, $line) ];
        $i++;
    }
    if ($i == 0) {
        die "Input is empty\n";
    }
    return $field;
}

main();
