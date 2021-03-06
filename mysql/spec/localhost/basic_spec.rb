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

describe package('mariadb-galera-server') do
  it { should be_installed }
end

describe user('mysql') do
  it { should exist }
end

describe group('mysql') do
  it { should exist }
end

describe service('mariadb') do
  it { should be_enabled }
  it { should be_running }
end

describe port(3306) do
  it { should be_listening.with('tcp') }
end
