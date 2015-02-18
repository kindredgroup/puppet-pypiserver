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

@test "download requests module and deploy to pypi repo" {
  test -f /opt/pypi/bar/requests-2.5.1-py2.py3-none-any.whl && rm -f /opt/pypi/bar/requests-2.5.1-py2.py3-none-any.whl
  test -f requests-2.5.1-py2.py3-none-any.whl || wget --no-check-certificate https://pypi.python.org/packages/py2.py3/r/requests/requests-2.5.1-py2.py3-none-any.whl#md5=11dc91bc96c5c5e0b566ce8f9c9644ab
  pip install twine
  cat >~/.pypirc<<EOF
[distutils]
index-servers = pypi

[pypi]
username = user1
password = password1
repository = http://localhost:19080
EOF
  twine upload requests-2.5.1-py2.py3-none-any.whl
  test -f /opt/pypi/bar/requests-2.5.1-py2.py3-none-any.whl
}
