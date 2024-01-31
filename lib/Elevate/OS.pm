package Elevate::OS;

=encoding utf-8

=head1 NAME

Elevate::OS

Abstract interface to the OS to obviate the need for if-this-os-do-this-elsif-elsif-else tech debt

=cut

use cPstrict;

use Log::Log4perl qw(:easy);

use constant SUPPORTED_DISTROS => qw{
  CentOS7
  CloudLinux7
};

use constant PRETTY_SUPPORTED_DISTROS => (
    'CentOS 7',
    'CloudLinux 7',
);

use constant AVAILABLE_UPGRADE_PATHS_FOR_CENTOS_7 => qw{
  alma
  almalinux
  rocky
  rockylinux
};

use constant AVAILABLE_UPGRADE_PATHS_FOR_CLOUDLINUX_7 => qw{
  cloud
  cloudlinux
};

our $OS;

sub factory {
    my $distro              = Cpanel::OS::pretty_distro();
    my $major               = Cpanel::OS::major();
    my $distro_with_version = $distro . $major;

    die "Attempted to get factory for unsupported OS: $distro $major\n" unless grep { $_ eq $distro_with_version } SUPPORTED_DISTROS;

    my $pkg = "Elevate::OS::" . $distro_with_version;
    return $pkg->new;
}

sub instance {
    $OS //= factory();

    return $OS;
}

sub is_supported () {
    return eval { instance(); 1; } ? 1 : 0;
}

sub get_supported_distros () {
    return PRETTY_SUPPORTED_DISTROS;
}

sub check_for_old_centos7 () {
    return instance()->check_for_old_centos7();
}

sub get_default_upgrade_to () {
    return instance()->get_default_upgrade_to();
}

sub get_available_upgrade_paths {
    my $name = instance()->name();

    if ( $name eq 'CentOS7' ) {
        return AVAILABLE_UPGRADE_PATHS_FOR_CENTOS_7;
    }
    elsif ( $name eq 'CloudLinux7' ) {
        return AVAILABLE_UPGRADE_PATHS_FOR_CLOUDLINUX_7;
    }

    return;
}

sub can_upgrade_to ($flavor) {
    my $name = instance()->name();

    if ( $name eq 'CentOS7' ) {
        return grep { $_ eq $flavor } AVAILABLE_UPGRADE_PATHS_FOR_CENTOS_7;
    }
    elsif ( $name eq 'CloudLinux7' ) {
        return grep { $_ eq $flavor } AVAILABLE_UPGRADE_PATHS_FOR_CLOUDLINUX_7;
    }

    return 0;
}

1;
