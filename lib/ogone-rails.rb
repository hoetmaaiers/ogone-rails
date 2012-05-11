# -*- encoding : utf-8 -*-

require 'digest'

require 'ogone-rails/config'
require 'ogone-rails/rails'
require 'ogone-rails/string_to_hash'
require 'ogone-rails/helpers'


module OgoneRails
  extend self
  
  def check_auth feedback
    sha_sign = feedback['SHASIGN']
        
    params = {}
    
    # upcase and sort paramaters to params
    # exclude SHASIGN
    feedback.each do |key, value|
      params[key.upcase] = value unless key == 'SHASIGN'
    end
        
    
    sha_out_phrase = ""
    # generate sha_out_hash
    params.sort.each do |key, value|
      sha_out_phrase << "#{key.upcase}=#{value}#{OgoneRails::Config.sha_out}"
    end
    
    sha_check = Digest::SHA1.hexdigest(sha_out_phrase).upcase
    
    if sha_check == sha_sign
      # return values in readable format
      {
        'order_id' => feedback['orderID'].to_s,
        'amount' => feedback['amount'],
        'currency' => feedback['currency'],
        'payment_method' => feedback['PM'],
        'acceptance' => feedback['ACCEPTANCE'],
        'status' => feedback['STATUS'],
        'card_number' => feedback['CARDNO'],
        'pay_id' => feedback['PAYID'],
        'error' => feedback['NC ERROR'],
        'brand' => feedback['BRAND'],
        'sha_sign' => feedback['SHASIGN']
      }
    else
      false
    end
  end
end