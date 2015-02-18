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

# DB preparation
$db_host = hiera('puppet-cinder-db_host')
$db_user = hiera('puppet-cinder-db_user')
$db_password = hiera('puppet-cinder-db_password')

remote_database { 'cinder':
  ensure      => 'present',
  db_host     => $db_host,
  db_user     => $db_user,
  db_password => $db_password,
  provider    => 'mysql',
} ->
remote_database_grant { "${db_user}@%%/cinder":
  privileges  => 'all',
  db_host     => $db_host,
  db_user     => $db_user,
  db_password => $db_password,
  provider    => 'mysql',
}

class { '::cinder':
  database_connection => "mysql://${db_user}:${db_password}@${db_host}/cinder",
}

class { '::cinder::api':
  keystone_password  => hiera('puppet-cinder-keystone_password'),
  keystone_auth_host => hiera('puppet-cinder-keystone_auth_host'),
}

class { '::cinder::scheduler': }

class { '::cinder::volume': }

class { '::cinder::client': }

class { 'cinder::backends':
  enabled_backends => ['lvm'],
}

cinder::backend::iscsi { 'lvm':
  iscsi_ip_address => hiera('puppet-cinder-iscsi_ip_address'),
}
