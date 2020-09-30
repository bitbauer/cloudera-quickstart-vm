## -*- mode: ruby -*-
# vi: set ft=ruby :

# Function for reading YAML file with configuration details
require 'yaml'
def load_configuration (environment, filename)
  keyvaluemap = YAML.load_file(filename)[environment]
  abort "No environment #{environment} was found in #{filename}" unless keyvaluemap
  keyvaluemap.merge( {"environment" => environment} )
end
