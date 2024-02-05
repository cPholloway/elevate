package Elevate::OS::CloudLinux7;

=encoding utf-8

=head1 NAME

Elevate::OS::CloudLinux7 - CloudLinux7 custom values

=cut

use cPstrict;

use Log::Log4perl qw(:easy);

use parent 'Elevate::OS::Base';

sub _build_get_default_upgrade_to ($self) {
    return 'cloudlinux';
}

sub _build_leapp_can_handle_epel ($self) {
    return 1;
}

sub _build_name ($self) {
    return 'CloudLinux7';
}

1;
