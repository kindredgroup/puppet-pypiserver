# == Class: pypiserver
#
# Entrypoint for managing the installation of pypiserver
#
# === Parameters
#
# [*ensure*]
#   Ensurable
#
# [*service_ensure*]
#   Used by individual repositories. Builtin service type ensure value
#
# [*service_enable*]
#   Used by individual repositories. Builtin service type enable value
#
# [*service_refresh*]
#   Boolean. Used by individual repositories. Will notify services on config changes
#
# [*manage_user*]
#   Boolean. Will add user definition 
#
# [*manage_auth*]
#   Boolean. Allows authentication in pypiserver
#
# [*repository_path*]
#   String. Base path to repositories
#
# [*user*]
#   String. Username of user to run pypiserver daemons
#
# [*group*]
#   String. Primary group of user
#
# === Examples
#
# include ::pypiserver
#
# === Authors
#
# Johan Lyheden <johan.lyheden@unibet.com>
#
# === Copyright
#
# Copyright 2015 North Development AB
#
class pypiserver (
  $ensure          = 'present',
  $service_ensure  = 'running',
  $service_enable  = true,
  $service_refresh = true,
  $manage_user     = true,
  $manage_auth     = true,
  $repository_path = $::pypiserver::params::repository_path,
  $user            = $::pypiserver::params::user,
  $group            = $::pypiserver::params::group
) inherits pypiserver::params {
  anchor { '::pypiserver::begin': } ->
  class { '::pypiserver::user': } ->
  class { '::pypiserver::package': } ->
  class { '::pypiserver::files': } ->
  anchor { '::pypiserver::end': }
}
