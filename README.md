# `gajdaw-rails` Puppet Module

#### Table of Contents

1. [Overview](#overview)
2. [Setup](#setup)
3. [Usage](#usage)
4. [Limitations](#limitations)
5. [Development](#development)
6. [How do I test the module?](#how-do-i-test-the-module)

## Overview

This module installs Ruby on Rails.

## Setup

To install the module run:

    sudo puppet install module gajdaw-rails

## Usage

You can use the module running the following command:

    sudo puppet apply -e 'include rails'

You can also use the class in manifest:

    include rails

For example manifests refer to `examples/` directory.

Note. Before applying `rails` class your system needs to be
updated. You can do it using `gajdaw-ubuntu` class:

    class { 'ubuntu': }
    class { 'rails':
         require => Class['ubuntu']
    }

## Limitations

The module was tested on:

* Ubuntu
  - 14.04 (trusty) (Vagrant box: ubuntu/trusty32)
  - 12.04 (precise) (Vagrant box: ubuntu/precise32)

## Development

For development instructions visit
[Puppet Modules Factory](https://github.com/puppet-by-examples/puppet-modules-factory)
