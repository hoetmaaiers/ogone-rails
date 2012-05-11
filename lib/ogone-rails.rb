# -*- encoding : utf-8 -*-

require 'digest'

# require 'ogone-rails/config'
require 'ogone-rails/rails'
require 'ogone-rails/string_to_hash'
require 'ogone-rails/helpers'


module OgoneRails
  extend self
  
  TEST_SERVICE_URL = 'https://secure.ogone.com/ncol/test/orderstandard.asp'
  LIVE_SERVICE_URL = 'https://secure.ogone.com/ncol/prod/orderstandard.asp'  
  STATUS_CODES = {
    0   => "Incomplete or invalid",
    1	  => "Cancelled by client",
    2	  => "Authorization refused",
    4	  => "Order stored",
    40  => "Stored waitingexternal result",
    41  => "Waiting client payment",
    5	  => "Authorized",
    50  => "Authorized waiting external result",
    51  => "Authorization waiting",
    52  => "Authorization not known",
    55  => "Stand-by",
    56  => "OK with scheduled payments",
    57  => "Error in scheduled payments",
    59  => "Authoriz. to get manually",
    6   => "Authorized and cancelled",
    61  => "Author. deletion waiting",
    62  => "Author. deletion uncertain",
    63  => "Author. deletion refused",
    64  => "Authorized and cancelled",
    7   => "Payment deleted",
    71  => "Payment deletion pending",
    72  => "Payment deletion uncertain",
    73  => "Payment deletion refused",
    74  => "Payment deleted",
    75  => "Deletion processed by merchant",
    8   => "Refund",
    81  => "Refund pending",
    82  => "Refund uncertain",
    83  => "Refund refused",
    84  => "Payment declined by the acquirer",
    85  => "Refund processed by merchant",
    9   => "Payment requested",
    91  => "Payment processing",
    92  => "Payment uncertain",
    93  => "Payment refused",
    94  => "Refund declined by the acquirer",
    95  => "Payment processed by merchant",
    99  => "Being processed"
  }
  
  @pspid    = nil
  @sha_in   = nil
  @sha_out  = nil
  @currency = "EUR"
  @language = "nl_NL"
  @mode    = "live"
  
  def config c = {}
    
    c.each do |key, value|
      case key
      when :pspid
        @pspid = value
      when :sha_in
        @sha_in = value
      when :sha_out
        @sha_out = value
      when :currency
        @currency = value
      when :language
        @language = value
      when :mode
        @mode = value
      end
    end
  end
    

  def self.sha_in
    @sha_in
  end

  def self.sha_out
    @sha_out
  end

  def self.pspid
    @pspid
  end

  def self.currency
    @currency
  end

  def self.language
    @language
  end

  def self.mode
    @mode
  end
  
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
      sha_out_phrase << "#{key.upcase}=#{value}#{OgoneRails::sha_out}"
    end
    
    sha_check = Digest::SHA1.hexdigest(sha_out_phrase).upcase
    
    if sha_check == sha_sign
      # return values in readable format
      {
        'order_id' => (feedback['orderID']).to_i,
        'amount' => (feedback['amount']).to_f,
        'currency' => feedback['currency'],
        'payment_method' => feedback['PM'],
        'acceptance' => feedback['ACCEPTANCE'],
        'status' => STATUS_CODES[feedback['STATUS'].to_i],
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