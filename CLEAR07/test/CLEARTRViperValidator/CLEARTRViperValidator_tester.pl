#!/usr/bin/env perl
# -*- mode: Perl; tab-width: 2; indent-tabs-mode: nil -*- # For Emacs

use strict;
use F4DE_TestCore;

my $validator = shift @ARGV;
error_quit("ERROR: Validator ($validator) empty or not an executable\n")
  if (($validator eq "") || (! -f $validator) || (! -x $validator));
my $mode = shift @ARGV;

print "** Running CLEARTRViperValidator tests:\n";

my $totest = 0;
my $testr = 0;
my $tn = "";
my $td = "";

$tn = "test-1a";
$td = "BN_TR";
$testr += &do_simple_test($tn, $td, "(BN TextRec: Reference files)", "*.gtf", "", "-D BN -w -f 15", "res-$tn.txt");

$tn = "test-1b";
$td = "BN_TR";
$testr += &do_simple_test($tn, $td, "(BN TextRec: System Submissions)", "", "BBN_VByblos_2006_Test_BNews_TREng_08_01.rdf", "-D BN -w -f 15", "res-$tn.txt");

if ($testr == $totest) {
  ok_quit("All test ok\n\n");
} else {
  error_quit("Not all test ok\n\n");
}

die("You should never see this :)");

##########

sub do_simple_test {
  my ($testname, $testdir, $subtype, $rf, $sf, $params, $res) = @_;
  my ($files, $command);

  if ($rf ne "") {
    $files = "../common/$testdir/$rf";
    $command = "$validator -g $files $params";
  }
  elsif ($sf ne "") {
    $files = "../common/$testdir/$sf";
    $command = "$validator $files $params";
  }
  else {
    error_quit("No input files for validator\n\n");
  }

  $totest++;

  return(F4DE_TestCore::run_simpletest($testname, $subtype, $command, $res, $mode));
}

#####

sub ok_quit {
  print @_;
  exit(0);
}

#####

sub error_quit {
  print @_;
  exit(1);
}