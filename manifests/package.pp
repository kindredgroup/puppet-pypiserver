class pypiserver::package {

  package { ['passlib', 'pypiserver']:
    ensure   => present,
    provider => 'pip'
  }

  #if $::pypiserver::manage_auth {
  #  if !defined(Package['httpd-tools']) {
  #    package { 'httpd-tools':
  #      ensure => present
  #    }
  #  }
  #}

}
