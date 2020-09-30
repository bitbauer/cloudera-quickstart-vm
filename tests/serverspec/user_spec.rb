require_relative 'spec_helper'
require 'yaml'

configpath = Pathname.new(__FILE__).dirname.join('..', 'configuration.yml')
configuration = YAML.load_file configpath

deploy_user = configuration['techuser']['NAME']
deploy_home = configuration['techuser']['HOME']

describe user(deploy_user) do
  it { should exist }
  it { should have_home_directory deploy_home }
end
