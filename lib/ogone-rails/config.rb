module OgoneRails
  
  module Config

    TEST_SERVICE_URL = 'https://secure.ogone.com/ncol/test/orderstandard.asp'
    LIVE_SERVICE_URL = 'https://secure.ogone.com/ncol/prod/orderstandard.asp'
        
    # sha_in
    def self.sha_in= sha
      @sha_in = sha
    end
    
    def self.sha_in
      @sha_in
    end
    
    # sha_out
    def self.sha_out= sha
      @sha_out = sha
    end
    
    def self.sha_out
      @sha_out
    end
    
    
    # PSPID
    def self.pspid= id
      @pspid = id
    end
    
    def self.pspid
      @pspid
    end
    
    
    # currency
    def self.currency= currency
      @currency = currency
    end
    
    def self.currency
      @currency
    end
    
    
    # language
    def self.language= language
      @language = language
    end
    
    def self.language
      @language
    end
    
    # debug
    def self.debug= bool = false  # default to production url 
      @test = bool
    end
    
    def self.debug
      @test
    end    
  end
end