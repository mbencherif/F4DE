#!/usr/bin/env perl
# -*- mode: Perl; tab-width: 2; indent-tabs-mode: nil -*- # For Emacs
#
# $Id$
#

use strict;
use MMisc;

my $err = 0;

##########
print "** Checking for Perl Required Packages:\n";
my $ms = 1;

$ms = &_chkpkg("DBI", "DBD::SQLite");
if ($ms > 0) {
  print "  ** ERROR: Not all packages found, you will not be able to run the program (and some F4DE package will most likely fail this step), install the missing packages and re-run the checks\n\n";
  $err++;
} else {
  print "  Found all packages\n\n";
}

##########
print "** Checking for F4DE Perl Required Packages:\n";
my $ms = 1;

$ms = &_chkpkg("MtSQLite");
if ($ms > 0) {
  print "  ** ERROR: Not all packages found, you will not be able to run the program\n\n";
  $err++;
} else {
  print "  Found all packages\n\n";
}

####################
MMisc::error_quit("\nSome issues, fix before attempting to run make check again\n") if ($err);

MMisc::ok_quit("\n** Pre-requisite testing done\n\n");

####################

sub _chkpkg {
  my @tocheck = @_;

  my $ms = scalar @tocheck;
  foreach my $i (@tocheck) {
    print "- $i : ";
    my $v = MMisc::check_package($i);
    my $t = $v ? "ok" : "**missing**";
    print "$t\n";
    $ms -= $v;
  }

  return($ms);
}
