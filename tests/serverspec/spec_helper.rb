# Set target host OS explicitly to current AWS Linux sibling
set :os, :family => 'redhat', :release => '6', :arch => 'x86_64'

# Disable sudo
# set :disable_sudo, true

# Set environment variables
# set :env, :LANG => 'C', :LC_MESSAGES => 'C'

# Set PATH
# set :path, '/sbin:/usr/local/sbin:$PATH'

# Suppress full backtraces on failing tests
RSpec.configure do |config|
  config.formatter = :documentation
  config.warnings = false
  config.backtrace_exclusion_patterns << /vagrant/
end
