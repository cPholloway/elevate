package Elevate::Components::Kernel;

=encoding utf-8

=head1 NAME

Elevate::Components::Kernel

Perform some kernel checks.

=cut

use cPstrict;

use Cpanel::Kernel::Status ();

use Log::Log4perl qw(:easy);

use parent qw{Elevate::Components::Base};

sub pre_leapp ($self) {

    return 1 unless $self->should_run_leapp;    # skip when --no-leapp is provided

    my ( $running_version, $boot_version ) = Cpanel::Kernel::Status::reboot_status()->@{ 'running_version', 'boot_version' };

    die( <<~"EOS" ) unless $running_version eq $boot_version;
    The running kernel version ($running_version) does not match that of
    the default boot entry ($boot_version) after a reboot.  This indicates
    that the system does not have control over which kernel and early boot
    environment (initrd) is used upon reboot, which is required to upgrade
    the operating system with this script.

    Since the server was rebooted just prior to this check, your server
    may be configured to boot into a particular kernel directly rather than
    to an instance of the GRUB2 boot loader.  This often happens to
    virtualized servers, but physical servers also can have this problem
    under certain configurations.  Your provider may have a solution to
    allow booting into GRUB2; contact them for further information.

    Once this issue has been resolved, you can continue the elevation
    process by executing:

    /scripts/elevate-cpanel --continue
    EOS

    return;
}

sub post_leapp ($self) {

    $self->run_once('_kernel_check');

    return;
}

sub _kernel_check ($self) {

    my @kernel_rpms = $self->rpm->get_installed_rpms();
    @kernel_rpms = sort grep { m/^kernel-\S+el7/ } @kernel_rpms;

    return unless @kernel_rpms;
    chomp @kernel_rpms;

    my $pretty_distro_name = $self->upgrade_to_pretty_name();

    my $msg = "The following kernels should probably be removed as they will not function on $pretty_distro_name:\n\n";
    foreach my $kernel (@kernel_rpms) {
        $msg .= "    $kernel\n";
    }

    $msg .= "\nYou can remove these by running: /usr/bin/rpm -e " . join( " ", @kernel_rpms ) . "\n";

    Elevate::Notify::add_final_notification($msg);

    return;
}

1;
