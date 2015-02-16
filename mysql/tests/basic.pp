#
# Copyright (C) 2015 Red Hat, Inc.
#
# Author: Martin Magr <mmagr@redhat.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# mariadb-server conflicts with mariadb-galera-server
package { 'mariadb-server':
  ensure => absent,
  before => Class['::mysql::server']
}

class { '::mysql::server':
  package_name     => hiera('puppetlabs-mysql-package_name'),
  root_password    => hiera('puppetlabs-mysql-root_password'),
  override_options => {
    'mysqld' => {
      bind_address           => hiera('puppetlabs-mysql-bind_address'),
      default_storage_engine => hiera('puppetlabs-mysql-default_storage_engine'),
    }
  }
}
