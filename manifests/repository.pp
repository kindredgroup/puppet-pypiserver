# == Define: pypiserver::repository
#
# Manages a pypi repository
#
# === Parameters
#
# [*namevar*]
#   Repository name
#
# [*ensure*]
#   Ensurable
#
# [*port*]
#   Listener port
#
# [*pypi_user*]
#   Hash with key (username), value (cleartext-password). If not empty and ::pypiserver::manage_auth is true
#   then a htpasswd file will be constructed with these credentials and pypiserver will be started
#   with password file flag set
#
# [*fallback_url*]
#   pypiserver fallback server url, used for retrieval of any missing packages
#
# === Sample usage:
#
# ::pypiserver::repository { 'corporate-repo':
#   port          => 18080,
#   pypi_user     => {
#     "deploy_user" => "password"
#   },
#   fallback_url  => "http://corporate-pypi-cache/simple"
# }
#
define pypiserver::repository (
  $port,
  $ensure       = 'present',
  $pypi_user    = {},
  $fallback_url = 'http://pypi.python.org/simple'
) {

  require ::pypiserver

  $user = $::pypiserver::user
  $group = $::pypiserver::group
  $salt = $::pypiserver::salt
  $service_name = "pypi-${name}"
  $repository_full_path = "${::pypiserver::repository_path}/${name}"
  $repository_password_file = "${::pypiserver::repository_path}/htpasswd_${name}"
  $logfile = "${::pypiserver::repository_path}/${name}.log"

  if $::pypiserver::manage_auth and !empty($pypi_user) {
    $service_arguments = "pypi-server -p ${port} -r ${repository_full_path} -P ${repository_password_file} --fallback-url ${fallback_url} 2>&1 > ${logfile}"
    file { $repository_password_file:
      ensure  => file,
      owner   => $::pypiserver::user,
      group   => $::pypiserver::group,
      mode    => '0400',
      content => template("${module_name}/htpasswd.erb")
    }
  } else {
    $service_arguments = "pypi-server -p ${port} -r ${repository_full_path} --fallback-url ${fallback_url} 2>&1 > ${logfile}"
  }

  file { $repository_full_path:
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => '0755'
  }

  file { "/etc/init/${service_name}.conf":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/repository-upstart.erb")
  }

  service { $service_name:
    ensure   => $::pypiserver::service_ensure,
    enable   => $::pypiserver::service_enable,
    provider => 'upstart',
    require  => [File[$repository_full_path], File["/etc/init/${service_name}.conf"]],
  }

  if $::pypiserver::service_refresh {
    Service[$service_name] {
      subscribe => File["/etc/init/${service_name}.conf"]
    }
  }

}
