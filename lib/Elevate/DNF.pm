package Elevate::DNF;

=encoding utf-8

=head1 NAME

Elevate::DNF

Logic wrapping the 'dnf' system binary

=cut

use cPstrict;

use Log::Log4perl qw(:easy);

use parent qw{Elevate::YUM};

sub _build_pkgmgr {
    return '/usr/bin/dnf';
}

sub install_epel ($self) {
    my $pkgmgr       = $self->pkgmgr;
    my $epel_rpm_url = 'https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm';

    $self->cpev->ssystem_and_die( $pkgmgr, '-y', 'install', $epel_rpm_url );

    return;
}

sub config_manager_enable ( $self, $repo ) {
    my $pkgmgr = $self->pkgmgr;

    $self->cpev->ssystem( $pkgmgr, 'config-manager', '--enable', $repo );

    return;
}

sub update_allow_raising ( $self, @args ) {
    my $pkgmgr = $self->pkgmgr;

    my @additional_args = scalar @args ? @args : '';

    $self->cpev->ssystem( $pkgmgr, '-y', '--allowerasing', @additional_args, 'update' );

    return;
}

1;
