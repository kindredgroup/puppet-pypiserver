# pypiserver

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with pypiserver](#setup)
    * [What pypiserver affects](#what-pypiserver-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with pypiserver](#beginning-with-pypiserver)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

Manages pypiserver (https://pypi.python.org/pypi/pypiserver), pypiserver is installed via pip into global site-packages and individual instances of pypiserver can be configured to run on the same server.

## Module Description

pypiserver is a minimal PyPI compatible server. It can be used to serve a set of packages and eggs to easy_install or pip. This module takes care of installing the required software, adding separate user, managing service(s)

The module aims to be minimal with no hard wired dependencies on specific reverse proxy implementations or other nice things you probably would want to use. That composition is better suited within a profile module.

## Setup

### What pypiserver affects

* Default files are handled from /opt/pypi
* Pypiserver installed into site-packages
* Creates user and group pypi

### Setup Requirements

The module requires provider "pip" to be available. Usually this means installing "python-pip" in RHEL-land. 

### Beginning with pypiserver

N/A

## Usage

Use *class pypiserver* to install the software and *define pypiserver::repository* to configure individual repositories.

pypiserver::repository requires class pypiserver and relies on data set its class parameters

## Reference

See Rdoc in init.pp and repository.pp

## Limitations

Tested on RHEL6, repositories uses upstart scripts.

## Development

Pull requests are welcome
