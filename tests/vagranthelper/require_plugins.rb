# -*- mode: ruby -*-
# vi: set ft=ruby :

# Function for checking if a set of plugins is installed
def require_plugins (context, allnames)
  missingnames = allnames.is_a?(String) ? [allnames]: allnames
  missingnames.reject! { |name| Vagrant.has_plugin?(name) }
  return if missingnames.empty?

  context.trigger.before :up do |trigger|
    trigger.info = "Check for required vagrant plugins ..."
    trigger.warn = "#{missingnames.join ' '} plugin/s is/are not installed for Vagrant."\
          "\nPlease install with `vagrant plugin install #{missingnames.join ' '}`."
    trigger.run = {inline: "false"}
  end

  return
end
