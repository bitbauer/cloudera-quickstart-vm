require_relative 'spec_helper'
require 'yaml'

configpath = Pathname.new(__FILE__).dirname.join('..', 'configuration.yml')
configuration = YAML.load_file configpath

master_container = "jenkins-#{configuration['localdev']['team']}"
master_path = "/var/jenkins/#{configuration['localdev']['team']}"
master_port = configuration['localdev']['port']
slave_service = "jenkins-slave"
slave_path = "/var/slave/#{configuration['localdev']['team']}"

describe file( master_path ) do
  it { should be_directory }
end

describe docker_container( master_container ) do
  it { should exist }
  it { should be_running }
end

describe port( master_port ) do
  it { should be_listening }
end

describe file( slave_path ) do
  it { should be_directory }
end

describe service( slave_service ) do
  it { should be_enabled }
  it { should be_running }
end
