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

describe service('mariadb-server') do
  it { should be_enabled }
  it { should be_running }
end

describe port(3306) do
  it { should be_listening.with('tcp') }
end

describe port(4567) do
  it { should be_listening.with('tcp') }
end
