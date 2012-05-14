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
end