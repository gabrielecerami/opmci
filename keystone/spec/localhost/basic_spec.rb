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
require 'spec_helper'

describe package('openstack-keystone') do
  it { should be_installed }
end

describe package('python-openstackclient') do
  it { should be_installed }
end

describe user('keystone') do
  it { should exist }
end

describe group('keystone') do
  it { should exist }
end

describe file('/etc/keystone') do
  it { should be_directory }
  it { should be_mode 750 }
  it { should be_owned_by 'keystone' }
  it { should be_grouped_into 'keystone' }
end

describe file('/var/log/keystone') do
  it { should be_directory }
  it { should be_mode 750 }
  it { should be_owned_by 'keystone' }
  it { should be_grouped_into 'keystone' }
end

describe file('/var/lib/keystone') do
  it { should be_directory }
  it { should be_mode 750 }
  it { should be_owned_by 'keystone' }
  it { should be_grouped_into 'keystone' }
end

describe file('/etc/keystone/keystone.conf') do
  it { should be_file }
  it { should be_mode 600 }
  it { should be_owned_by 'keystone' }
  it { should be_grouped_into 'keystone' }
end

describe service('openstack-keystone') do
  it { should be_enabled }
  it { should be_running }
end

describe port(5000) do
  it { should be_listening.with('tcp') }
end

describe port(35357) do
  it { should be_listening.with('tcp') }
end
