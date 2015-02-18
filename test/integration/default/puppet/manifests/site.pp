package { 'python-pip': ensure => installed } ->
class { '::pypiserver': }

pypiserver::repository { 'foo':
  port => '18080'
}

pypiserver::repository { 'bar':
  port => '19080',
  pypi_user => {
    "user1" => "password1",
    "user2" => "password2"
  }
}
