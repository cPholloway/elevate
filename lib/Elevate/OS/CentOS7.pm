package Elevate::OS::CentOS7;

=encoding utf-8

=head1 NAME

Elevate::OS::CentOS7 - CentOS7 custom values

=cut

use cPstrict;

use Log::Log4perl qw(:easy);

use parent 'Elevate::OS::Base';

sub _build_get_default_upgrade_to ($self) {
    return 'almalinux';
}

sub _build_name ($self) {
    return 'CentOS7';
}

1;
