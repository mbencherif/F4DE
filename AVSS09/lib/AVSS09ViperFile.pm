package AVSS09ViperFile;

# AVSS09 ViPER File handler

# Original Author(s): Martial Michel
#
# This software was developed at the National Institute of Standards and Technology by
# employees and/or contractors of the Federal Government in the course of their official duties.
# Pursuant to Title 17 Section 105 of the United States Code this software is not subject to 
# copyright protection within the United States and is in the public domain.
#
# "CLEARDTViperFile.pm" is an experimental system.
# NIST assumes no responsibility whatsoever for its use by any party.
#
# THIS SOFTWARE IS PROVIDED "AS IS."  With regard to this software, NIST MAKES NO EXPRESS
# OR IMPLIED WARRANTY AS TO ANY MATTER WHATSOEVER, INCLUDING MERCHANTABILITY,
# OR FITNESS FOR A PARTICULAR PURPOSE.


# $Id$

use strict;

my $version     = "0.1b";

if ($version =~ m/b$/) {
  (my $cvs_version = '$Revision$') =~ s/[^\d\.]//g;
  $version = "$version (CVS: $cvs_version)";
}

my $versionid = "AVSS09iperFile.pm Version: $version";

##########
# Check we have every module (perl wise)

# ViperFramespan.pm (part of this tool)
use ViperFramespan;

# MErrorH.pm
use MErrorH;

# "MMisc.pm"
use MMisc;

# CLEARDTViperFile (part of this tool)
use CLEARDTViperFile;

# CLEARDTHelperFunctions (part of this tool)
use CLEARDTHelperFunctions;

# For internal dispay
use Data::Dumper;

########################################

## Constructor
sub new {
  my $class = shift @_;
  my $tmp = MMisc::iuv(shift @_, undef);

  my $errortxt = "";

  if (! defined $tmp) {
    $tmp = CLEARDTViperFile->new("SV");
    $errortxt .= $tmp->get_errormsg() if ($tmp->error());
  }

  my $errormsg = MErrorH->new("AVSS09ViperFile");
  $errormsg->set_errormsg($errortxt);

  my $self =
    {
     cldt           => $tmp,
     errormsg       => $errormsg,
    };

  bless $self;
  return($self);
}

############################################################

sub _set_errormsg {
  my ($self, $txt) = @_;
  $self->{errormsg}->set_errormsg($txt);
}

##########

sub get_errormsg {
  my ($self) = @_;
  return($self->{errormsg}->errormsg());
}

##########

sub error {
  my ($self) = @_;
  return($self->{errormsg}->error());
}

##########

sub _set_error_and_return {
  my $self = shift @_;
  my $errormsg = shift @_;

  $self->_set_errormsg($errormsg);

  return(@_);
}

############################################################
# A lot of the code relies on simpleCLEARDTViperFile functionalities

sub __cldt_caller {
  my ($self, $func, $rderr, @params) = @_;

  return(@$rderr) if ($self->error());

  my $cldt = $self->{cldt};
  return($self->_set_error_and_return("Undefined CLEARDTViperFile", 0))
    if (! defined $cldt);

  my @ok = &{$func}($cldt, @params);
  return($self->_set_error_and_return($cldt->get_errormsg(), 0))
    if ($cldt->error());

  return(@ok);
}

##########

sub get_required_xsd_files_list {
  my ($self) = @_;
  return($self->__cldt_caller
         (\&CLEARDTViperFile::get_required_xsd_files_list, [-1]));
}

########## 'xmllint'

sub set_xmllint {
  my ($self, $xmllint) = @_;
  return($self->__cldt_caller
         (\&CLEARDTViperFile::set_xmllint, [0], $xmllint));
}

#####

sub _is_xmllint_set {
  my ($self) = @_;
  return($self->__cldt_caller
         (\&CLEARDTViperFile::_is_xmllint_set, [0]));
}

#####

sub get_xmllint {
  my ($self) = @_;
  return($self->__cldt_caller
         (\&CLEARDTViperFile::get_xmllint, [-1]));
}

########## 'xsdpath'

sub set_xsdpath {
  my ($self, $xsdpath) = @_;
  return($self->__cldt_caller
         (\&CLEARDTViperFile::set_xsdpath, [0], $xsdpath));
}

#####

sub _is_xsdpath_set {
  my ($self) = @_;
  return($self->__cldt_caller
         (\&CLEARDTViperFile::_is_xsdpath_set, [0]));
}

#####

sub get_xsdpath {
  my ($self) = @_;
  return($self->__cldt_caller
         (\&CLEARDTViperFile::get_xsdpath, [-1]));
}

########## 'gtf'

sub set_as_gtf {
  my ($self) = @_;
  return($self->__cldt_caller
         (\&CLEARDTViperFile::set_as_gtf, [0]));
}

#####

sub check_if_gtf {
  my ($self) = @_;
  return($self->__cldt_caller
         (\&CLEARDTViperFile::check_if_gtf, [0]));
}

#####

sub check_if_sys {
  my ($self) = @_;
  return($self->__cldt_caller
         (\&CLEARDTViperFile::check_if_sys, [0]));
}

########## 'file'

sub set_file {
  my ($self, $file) = @_;
  return($self->__cldt_caller
         (\&CLEARDTViperFile::set_file, [0], $file));
}

#####

sub get_file {
  my ($self) = @_;
  return($self->__cldt_caller
         (\&CLEARDTViperFile::get_file, [-1]));
}

##########

sub set_frame_tolerance {
  my ($self, $tif) = @_;
  return($self->__cldt_caller
         (\&CLEARDTViperFile::set_frame_tolerance, [0], $tif));
}

#####

sub get_frame_tolerance {
  my ($self) = @_;
  return($self->__cldt_caller
         (\&CLEARDTViperFile::get_frame_tolerance, [0]));
}

########## 'validate'

sub is_validated {
  my ($self) = @_;
  return($self->__cldt_caller
         (\&CLEARDTViperFile::is_validated, [0]));
}

#####

sub validate {
  my ($self) = @_;
  return($self->__cldt_caller
         (\&CLEARDTViperFile::validate, [0]));
}

######################################## Internal queries

sub get_sourcefile_filename {
  my ($self) = @_;
  return($self->__cldt_caller
         (\&CLEARDTViperFile::get_sourcefile_filename, [-1]));
}

#####

sub change_sourcefile_filename {
  my ($self, $nfn) = @_;
  return($self->__cldt_caller
         (\&CLEARDTViperFile::change_sourcefile_filename, [-1], $nfn));
}

########################################

sub _display_all {
  my ($self) = @_;

  return(-1) if ($self->error());

  return(Dumper(\$self));
}

########## Helper Functions

sub load_ViperFile {
  my ($isgtf, $filename, $frameTol, $xmllint, $xsdpath) = @_;

  my ($ok, $cldt, $err) = CLEARDTHelperFunctions::load_ViperFile
    ($isgtf, $filename, "SV", $frameTol, $xmllint, $xsdpath);

  return($ok, undef, $err)
    if ((! $ok) || (! MMisc::is_blank($err)));

  my $it = AVSS09ViperFile->new($cldt);

  return(0, undef, $it->get_errormsg())
    if ($it->error());

  return(1, $it, "");
}

######################################## Actual modification code





############################################################

1;