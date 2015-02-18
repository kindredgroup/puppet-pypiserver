class pypiserver::files {

  file { $::pypiserver::repository_path:
    ensure => directory,
    owner  => $::pypiserver::user,
    group  => $::pypiserver::group,
    mode   => '0755'
  }

}
