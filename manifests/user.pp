class pypiserver::user {
  
  if $::pypiserver::manage_user {
    @user { $::pypiserver::user:
      ensure     => $::pypiserver::ensure,
      home       => "/home/${::pypiserver::user}",
      gid        => $::pypiserver::group,
      managehome => true,
      comment    =>  'Pypi user - Managed by Puppet',
      shell      => '/bin/false'
    }
    @group { $::pypiserver::group:
      ensure => $::pypiserver::ensure
    }
  }

  Group <| title == $::pypiserver::group |> ->
  User <| title == $::pypiserver::user |>

}
