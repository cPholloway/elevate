package Elevate::OS::RHEL;

=encoding utf-8

=head1 NAME

Elevate::OS::RHEL

Rhel base class

=cut

use cPstrict;

use constant disable_mysql_yum_repos => qw{
  Mysql57.repo
  Mysql80.repo

  MariaDB102.repo
  MariaDB103.repo
  MariaDB105.repo
  MariaDB106.repo

  mysql-community.repo
};

use constant vetted_mysql_yum_repo_ids => (
    qr/^mysql-cluster-[0-9.]{3}-community(?:-(?:source|debuginfo))?$/,
    qr/^mysql-connectors-community(?:-(?:source|debuginfo))?$/,
    qr/^mysql-tools-community(?:-(?:source|debuginfo))?$/,
    qr/^mysql-tools-preview(?:-source)?$/,
    qr/^mysql[0-9]{2}-community(?:-(?:source|debuginfo))?$/,
    qr/^MariaDB[0-9]{3}$/,
);

use constant vetted_yum_repo => (
    'base',
    'c7-media',
    qr/^centos-kernel(?:-experimental)?$/,
    'centosplus',
    'cp-dev-tools',
    'cpanel-addons-production-feed',
    'cpanel-plugins',
    'cr',
    'ct-preset',
    'digitalocean-agent',
    'droplet-agent',
    qr/^EA4(?:-c\$releasever)?$/,
    qr/^elasticsearch(?:7\.x)?$/,
    qr/^elevate(?:-source)?$/,
    qr/^epel(?:-testing)?$/,
    'extras',
    'fasttrack',
    'imunify360',
    'imunify360-ea-php-hardened',
    qr/^imunify360-rollout-[0-9]+$/,
    'influxdb',
    'jetapps',
    qr/^jetapps-(?:stable|beta|edge)$/,
    'kernelcare',
    qr/^ul($|_)/,
    'hgdedi',
    'updates',
    'r1soft',
    qr/^panopta(?:\.repo)?$/,
    qr/^fortimonitor(?:\.repo)?$/,
    qr/^wp-toolkit-(?:cpanel|thirdparties)$/,
  ),
  vetted_mysql_yum_repo_ids;

use constant supported_cpanel_mysql_versions => qw{
  8.0
  10.3
  10.4
  10.5
  10.6
};

use constant supported_cpanel_nameserver_types => qw{
  bind
  powerdns
};

use constant default_upgrade_to              => undef;
use constant ea_alias                        => undef;
use constant elevate_rpm_url                 => undef;
use constant is_apt_based                    => 0;
use constant is_supported                    => 1;
use constant leapp_can_handle_imunify        => 0;
use constant leapp_can_handle_kernelcare     => 0;
use constant leapp_data_package              => undef;
use constant leapp_flag                      => undef;
use constant lts_supported                   => 110;
use constant name                            => 'RHEL';
use constant needs_do_release_upgrade        => 0;
use constant needs_epel                      => 1;
use constant needs_leapp                     => 1;
use constant needs_powertools                => 1;
use constant package_manager                 => 'YUM';
use constant pretty_name                     => 'RHEL';
use constant provides_mysql_governor         => 0;
use constant remove_els                      => 0;
use constant should_check_cloudlinux_license => 0;
use constant supports_jetbackup              => 1;
use constant supports_kernelcare             => 1;
use constant supports_postgresql             => 1;
use constant skip_minor_version_check        => 0;
use constant leapp_repo_beta                 => '';       # Unavailable by default.
use constant upgrade_to_pretty_name          => undef;
use constant vetted_apt_lists                => {};

1;
