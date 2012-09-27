require "rails/generators/base"

module Ogone  
  class ConfigGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)
    
    desc "generate yaml and initializer config for ogone-rails.gem usage"

    def copy_files
      say_status "", "time to put configuration files in place... \n", :blue
      copy_file "ogone.yml", "config/ogone.yml"
      copy_file "ogone.rb", "config/initializers/ogone.rb"
    end
      
    def print_manual
      say_status "OK", "...configuration files are in place.", :green
      say "\nNow it's time to change the example documentation in 'config/ogone.yml' to your ogone details.", :bold
      say "More information can be found on https://github.com/robinhoudmeyers/ogone-rails or http://www.ogone.com.\n"
    end
  end
end

    
# def yaml_config
#   # create settings directory
#   settings_path = File.join(::Rails.root.to_s, "config/settings")
#   unless File.directory?(settings_path)
#     p "CREATING 'config/settings/ directory ..." 
#     Dir.mkdir(settings_path)
#   end
# 
#   # # write yaml file
#   p "WRITING yaml.config..."
# 
#   # create a configuration file
#   snap_up_yaml_original = File.join(File.dirname(__FILE__), '../../..', 'install', 'snap_up.yml')
#   snap_up_yaml_filepath = File.join(::Rails.root.to_s, 'config/settings', 'snap_up.yml')
# 
# 
# 
#   if FileUtils.cp_r snap_up_yaml_original, snap_up_yaml_filepath
#       puts "A configuration file has been CREATED at #{ snap_up_yaml_filepath }"
#   else
#       puts "Can't create #{ snap_up_yaml_filepath }"
#   end
# end