require_relative 'spec_helper'
require 'yaml'

configpath = Pathname.new(__FILE__).dirname.join('..', 'configuration.yml')
configuration = YAML.load_file configpath

agent_service = "cloudera-scm-agent"
server_service = "cloudera-scm-server"
server_path = "/usr/lib64/cmf/cloudera"
server_port = configuration['localdev']['port']

describe service( agent_service ) do
  it { should be_enabled }
  it { should be_running }
end

describe service( server_service ) do
  it { should be_enabled }
  it { should be_running }
end

describe file( server_path ) do
  it { should be_directory }
end

describe port( server_port ) do
  it { should be_listening }
end
