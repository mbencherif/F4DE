#!/usr/bin/env perl

# CSV to CSV
#
# Author:    Martial Michel
#
# This software was developed at the National Institute of Standards and Technology by
# employees and/or contractors of the Federal Government in the course of their official duties.
# Pursuant to Title 17 Section 105 of the United States Code this software is not subject to 
# copyright protection within the United States and is in the public domain.
#
# "CSV to CSV" is an experimental system.
# NIST assumes no responsibility whatsoever for its use by any party.
#
# THIS SOFTWARE IS PROVIDED "AS IS."  With regard to this software, NIST MAKES NO EXPRESS
# OR IMPLIED WARRANTY AS TO ANY MATTER WHATSOEVER, INCLUDING MERCHANTABILITY,
# OR FITNESS FOR A PARTICULAR PURPOSE.

use strict;

# Note: Designed for UNIX style environments (ie use cygwin under Windows).

##########
# Version

# $Id$
my $version     = "0.1b";

if ($version =~ m/b$/) {
  (my $cvs_version = '$Revision$') =~ s/[^\d\.]//g;
  $version = "$version (CVS: $cvs_version)";
}

my $versionid = "CSV to CSV Version: $version";

##########
# Check we have every module (perl wise)

## First insure that we add the proper values to @INC
my ($f4b, @f4bv);
BEGIN {
  $f4b = "F4DE_BASE";
  push @f4bv, (exists $ENV{$f4b}) 
    ? ($ENV{$f4b} . "/lib") 
      : ("../../../common/lib");
}
use lib (@f4bv);

sub eo2pe {
  my @a = @_;
  my $oe = join(" ", @a);
  my $pe = ($oe !~ m%^Can\'t\s+locate%) ? "\n----- Original Error:\n $oe\n-----" : "";
  return($pe);
}

## Then try to load everything
my $have_everything = 1;
my $partofthistool = "It should have been part of this tools' files. Please check your $f4b environment variable.";
my $warn_msg = "";

# Part of this tool
foreach my $pn ("MMisc", "CSVHelper") {
  unless (eval "use $pn; 1") {
    my $pe = &eo2pe($@);
    &_warn_add("\"$pn\" is not available in your Perl installation. ", $partofthistool, $pe);
    $have_everything = 0;
  }
}

# usualy part of the Perl Core
foreach my $pn ("Getopt::Long") {
  unless (eval "use $pn; 1") {
    &_warn_add("\"$pn\" is not available on your Perl installation. ", "Please look it up on CPAN [http://search.cpan.org/]\n");
    $have_everything = 0;
  }
}

# Something missing ? Abort
if (! $have_everything) {
  print "\n$warn_msg\nERROR: Some Perl Modules are missing, aborting\n";
  exit(1);
}

# Use the long mode of Getopt
Getopt::Long::Configure(qw(auto_abbrev no_ignore_case));

########################################
# Options processing

my $usage = "$0 infile.csv outfile.csv\nFix CSV formatting\n";

MMisc::error_quit($usage) 
  if (scalar @ARGV < 2);

my ($in, $out) = @ARGV;

open IFILE, "<$in"
  or MMisc::error_quit("Problem opening input file ($in) : $!");
open OFILE, ">$out"
  or MMisc::error_quit("Problem opening output file ($out) : $!");

my $icsvh = new CSVHelper();
my $ocsvh = new CSVHelper();

my $sh = 1;
while (my $line = <IFILE>) {
  my @inh = $icsvh->csvline2array($line);
  MMisc::error_quit("Problem with input CSV : " . $icsvh->get_errormsg() . "\n[Line $sh : $line]")
      if ($icsvh->error());

  if ($sh == 1) {
    $icsvh->set_number_of_columns(scalar @inh);
    $ocsvh->set_number_of_columns(scalar @inh);
  }
  
  my $otxt = $ocsvh->array2csvline(@inh);
  MMisc::error_quit("Problem with output CSV : " . $ocsvh->get_errormsg() . "\n[Line $sh : $line]")
      if ($ocsvh->error());

  print OFILE "$otxt\n";

  $sh++;
}
close IFILE;
close OFILE;

MMisc::ok_quit("Done (processed $sh lines)\n");
