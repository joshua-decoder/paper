#!/usr/bin/perl

# Takes a single-threaded run and reports the time at which each translation came out.

my $flip = shift || 0;

my $time = 0;
my $sentno = 0;
my @times;
while (<>) {
  my @tokens = split(' ', $_);

  # Moses
  if (/^Created input-output object/) {
    $tokens[4] =~ s/[\[\]]//g;
    $time += $tokens[4];
  } elsif (/^Translation took/) {
    $time += $tokens[2];
    $sentno++;
    $times[int($time)] = $sentno;
    printf "%d\t%.2f\n", $sentno, $time unless $flip;
  }

  # Joshua
  elsif (/^Model loading/) {
    $time += $tokens[3];
  } elsif (/^translation of sentence/) {
    $time += $tokens[5];
    $sentno++;
    $times[int($time)] = $sentno;
    printf "%d\t%.2f\n", $sentno, $time unless $flip
  }
}

if ($flip) {
  for (my $i = 0; $i < $#times; $i++) {
    if ($times[$i] > 0) {
      printf "$i\t$times[$i]\n";
    }
  }
}
