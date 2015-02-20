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

describe package('openstack-cinder') do
  it { should be_installed }
end

describe package('python-cinderclient') do
  it { should be_installed }
end

describe package('targetcli'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

describe package('scsi-target-utils'), :if => os[:family] == 'fedora' do
  it { should be_installed }
end

describe user('cinder') do
  it { should exist }
end

describe group('cinder') do
  it { should exist }
end

describe file('/etc/cinder/cinder.conf') do
  it { should be_file }
  it { should be_mode 600 }
  it { should be_owned_by 'cinder' }
  it { should be_grouped_into 'cinder' }
  its(:content) do
    should match /enabled_backends\s*=\s*lvm/
    should match /volume_backend_name\s*=\s*lvm/
    should match /volume_group\s*=\s*cinder-volumes/
    should match /volume_driver\s*=\s*cinder.volume.drivers.lvm.LVMISCSIDriver/
  end
end

describe file('/etc/cinder/api-paste.ini') do
  it { should be_file }
  it { should be_mode 600 }
  it { should be_owned_by 'cinder' }
  it { should be_grouped_into 'cinder' }
end

describe service('openstack-cinder-api') do
  it { should be_enabled }
  it { should be_running }
end

describe service('openstack-cinder-scheduler') do
  it { should be_enabled }
  it { should be_running }
end

describe service('openstack-cinder-volume') do
  it { should be_enabled }
  it { should be_running }
end

describe service('target'), :if => os[:family] == 'redhat' do
  it { should be_enabled }
  it { should be_running }
end

describe service('tgtd'), :if => os[:family] == 'fedora' do
  it { should be_enabled }
  it { should be_running }
end

describe port(5000) do
  it { should be_listening.with('tcp') }
end
