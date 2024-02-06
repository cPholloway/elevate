package Elevate::OS::Base;

=encoding utf-8

=head1 NAME

Elevate::OS::Base

This is a base class currently used by Elevate::OS::*

=cut

use cPstrict;

use Log::Log4perl qw(:easy);

use Simple::Accessor qw{
  ea_alias
  get_default_upgrade_to
  leapp_can_handle_epel
  leapp_can_handle_imunify
  leapp_can_handle_kernelcare
  name
};

# NOTE: AlmaLinux_8 is just an alias for CentOS_8 so it really doesn't matter
#       which of the two is used
sub _build_ea_alias ($self) {
    return 'CentOS_8';
}

sub _build_get_default_upgrade_to ($self) {
    die "subclass must implement get_default_upgrade_to\n";
}

sub _build_leapp_can_handle_epel ($self) {
    return 0;
}

sub _build_leapp_can_handle_imunify ($self) {
    return 0;
}

sub _build_leapp_can_handle_kernelcare ($self) {
    return 0;
}

sub _build_name ($self) {
    die "subclass must implement name\n";
}

1;
