require_relative 'spec_helper'

deploy_user = "cloudera"
deploy_home = "/home/cloudera"

describe user(deploy_user) do
  it { should exist }
  it { should have_home_directory deploy_home }
end
