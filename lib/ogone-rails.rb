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

	def load!
		load_config DEFAULT_CONFIG
	end

	def load_config config_path
		exists = config_path && File.exists?(config_path)
		return false if !exists
		raise  MissingConfiguration, "Could not find the #{ config_path } configuration file" unless exists

		# load ogone configuration
		config = YAML.load_file('config/ogone.yml')[Rails.env].symbolize_keys
		OgoneRails::config (config)
	end
end

OgoneRails.load!