package Elevate::YUM;

=encoding utf-8

=head1 NAME

Elevate::YUM

Logic wrapping the 'yum' system binary

=cut

use cPstrict;

use Log::Log4perl qw(:easy);

use Simple::Accessor qw{
  cpev
  pkgmgr
};

sub _build_cpev {
    die q[Missing cpev];
}

sub _build_pkgmgr {
    return '/usr/bin/yum';
}

sub erase ( $self, @pkgs ) {
    return unless scalar @pkgs;

    my $pkgmgr = $self->pkgmgr;

    my $pkg_string = join( ' ', @pkgs );

    $self->cpev->ssystem(qq{$pkgmgr -y erase $pkg_string});

    return;
}

sub clean_all ($self) {
    my $pkgmgr = $self->pkgmgr;

    $self->cpev->ssystem( $pkgmgr, 'clean', 'all' );

    return;
}

1;
