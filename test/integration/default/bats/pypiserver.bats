#!/usr/bin/env bats

@test "service pypi-foo should be running" {
  status pypi-foo
}

@test "service pypi-bar should be running" {
  status pypi-bar
}

@test "should listen on port 18080" {
  netstat -ltpn|grep :18080
}

@test "should listen on port 19080" {
  netstat -ltpn|grep :19080
}
