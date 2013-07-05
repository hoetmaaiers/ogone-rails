# -*- encoding : utf-8 -*-

require 'digest'

require 'ogone-rails/config'
require 'ogone-rails/rails'
require 'ogone-rails/form'
require 'ogone-rails/string-to-hash'
require 'ogone-rails/helpers'
require 'ogone-rails/check-auth'


module OgoneRails
	ASSET_ROOT     = File.expand_path((defined?(Rails) && Rails.root.to_s.length > 0) ? Rails.root : ENV['RAILS_ROOT'] || '.') unless defined?(ASSET_ROOT)
	DEFAULT_CONFIG = File.join( ASSET_ROOT, 'config', 'ogone.yml')

	class MissingConfiguration < NameError; end

	def self.load!
		load_config DEFAULT_CONFIG
	end

	def self.load_config config_path	
		exists = config_path && File.exists?(config_path)
		raise  MissingConfiguration, "Could not find the #{ config_path } configuration file" unless exists

		# deprecated RAILS_ENV won't get hurt this way
		environment = Rails.env.split('=').last

		# load ogone configuration
		config = YAML.load_file(DEFAULT_CONFIG)[environment].symbolize_keys
		OgoneRails::config (config)
	end
end

OgoneRails.load!
