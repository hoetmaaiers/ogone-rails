# -*- encoding : utf-8 -*
# load yaml configuration for current environment && symbolize_keys
ogone_config = YAML.load_file('config/ogone.yml')[Rails.env].symbolize_keys
OgoneRails::config (ogone_config)