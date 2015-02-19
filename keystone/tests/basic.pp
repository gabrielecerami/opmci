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
$db_host = hiera('puppet-keystone-db_host')
$db_user = hiera('puppet-keystone-db_user')
$db_password = hiera('puppet-keystone-db_password')

remote_database { 'keystone':
  ensure      => 'present',
  db_host     => $db_host,
  db_user     => $db_user,
  db_password => $db_password,
  provider    => 'mysql',
} ->
remote_database_grant { "${db_user}@%%/keystone":
  privileges  => 'all',
  db_host     => $db_host,
  db_user     => $db_user,
  db_password => $db_password,
  provider    => 'mysql',
}

class { '::keystone':
  admin_token         => hiera('puppet-keystone-admin_token'),
  database_connection => "mysql://${db_user}:${db_password}@${db_host}/keystone",
  rabbit_host         => hiera('puppet-keystone-rabbit_host'),
  rabbit_userid       => hiera('puppet-keystone-rabbit_userid'),
  rabbit_password     => hiera('puppet-keystone-rabbit_password'),
  service_name        => 'keystone',
}
