# -*- encoding : utf-8 -*-

require 'digest'

require 'ogone-rails/config'
require 'ogone-rails/rails'
require 'ogone-rails/string_to_hash'
require 'ogone-rails/helpers'

# require 'digest'
# 
# module OgoneRails
# 
#   module Config
# 
#     TEST_SERVICE_URL = 'https://secure.ogone.com/ncol/test/orderstandard.asp'
#     LIVE_SERVICE_URL = 'https://secure.ogone.com/ncol/prod/orderstandard.asp'
#         
#     # passphrase
#     def self.passphrase= phrase
#       @passphrase = phrase
#     end
#     
#     def self.passphrase
#       @passphrase
#     end
#     
#     
#     # PSPID
#     def self.pspid= id
#       @pspid = id
#     end
#     
#     def self.pspid
#       @pspid
#     end
#     
#     
#     # currency
#     def self.currency= currency
#       @currency = currency
#     end
#     
#     def self.currency
#       @currency
#     end
#     
#     
#     # language
#     def self.language= language
#       @language = language
#     end
#     
#     def self.language
#       @language
#     end
#     
#     # debug
#     def self.debug= bool = false  # default to production url 
#       @test = bool
#     end
#     
#     def self.debug
#       @test
#     end    
#   end
#   
#   
#   module Helpers
#     extend self
#     
#     def ogone_form options={}
#       
#       if OgoneRails::Config.debug
#         form = "<form method='post' action='#{OgoneRails::Config::TEST_SERVICE_URL}'>\n"
#       else
#         form = "<form method='post' action='#{OgoneRails::Config::LIVE_SERVICE_URL}'>\n"
#       end
#       
#       # REQUIRED VALUES
#       # pspid
#       form << "\t<input type='hidden' name='PSPID' value='#{OgoneRails::Config.pspid}'>\n"
#       StringToHash::add_parameter 'PSPID', OgoneRails::Config.pspid
#       # currency
#       form << "\t<input type='hidden' name='currency' value='#{OgoneRails::Config.currency}'>\n"
#       StringToHash::add_parameter 'currency', OgoneRails::Config.currency
#       # language
#       form << "\t<input type='hidden' name='language' value='#{OgoneRails::Config.language}'>\n"
#       StringToHash::add_parameter 'language', OgoneRails::Config.language
#       
#       
#       
#       # OPTIONAL VALUES
#       options.each do |option, value|
#         case option
#         when :order_id
#           form << "\t<input type='hidden' name='orderID' value='#{value}'>\n"
#           StringToHash::add_parameter 'orderID', value
#         when :amount
#           #amount 15.00 -> 1500
#           value = (value.to_f * 100).to_i
#           form << "\t<input type='hidden' name='amount' value='#{value}'>\n"
#           StringToHash::add_parameter 'amount', value
#         when :customer_name
#           form << "\t<input type='hidden' name='CN' value='#{value}'>\n"
#           StringToHash::add_parameter 'CN', value
#         when :customer_email
#           form << "\t<input type='hidden' name='EMAIL' value='#{value}'>\n"
#           StringToHash::add_parameter 'EMAIL', value
#         when :customer_address
#           form << "\t<input type='hidden' name='owneraddress' value='#{value}'>\n"
#           StringToHash::add_parameter 'owneraddress', value
#         when :customer_zip
#           form << "\t<input type='hidden' name='ownerZIP' value='#{value}'>\n"
#           StringToHash::add_parameter 'ownerZIP', value
#         when :customer_city
#           form << "\t<input type='hidden' name='ownertown' value='#{value}'>\n"
#           StringToHash::add_parameter 'ownertown', value
#         when :customer_country
#           form << "\t<input type='hidden' name='ownercty' value='#{value}'>\n"          
#           StringToHash::add_parameter 'ownercty', value
#         when :customer_phone
#           form << "\t<input type='hidden' name='ownertelno' value='#{value}'>\n"
#           StringToHash::add_parameter 'ownertelno', value
#         else
#           form << "\t<input type='hidden' name='#{option}' value='#{value}'>\n"
#         end
#       end
#       
#       # shasign
#       sha_in = StringToHash.generate_sha_in
#       form << "\t<input type='hidden' name='SHASign' value='#{sha_in}'>\n"
# 
#       form << "</form>"
#       form.html_safe
#     end
#   end
#   
#   
#   module StringToHash
#     extend self
#     @params = {}
#     @sha_phrase = ""
#     
#     def add_parameter key, value
#       @params[key.upcase] = value
#     end
#     
#     def generate_sha_in
#       @params.sort.each do |key, value|
#         @sha_phrase << "#{key.upcase}=#{value}#{OgoneRails::Config.passphrase}"
#       end
#       
#       Digest::SHA1.hexdigest(@sha_phrase).upcase
#     end
#     
#     def self.params
#       @params
#     end
#     
#     def self.sha_phrase
#       @sha_phrase
#     end
#   end
# end