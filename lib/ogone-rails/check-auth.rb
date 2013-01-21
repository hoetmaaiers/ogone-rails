# -*- encoding : utf-8 -*-
module OgoneRails  
  
  class CheckAuth 
    
    def initialize request
      @request = request.GET
      # clear empty keys
      @request.delete_if { |k,v| v.empty? }

      @params = {}
      get_params
    end
    
    
    def valid?
      # Check authentication
      # sha_sign == sha_out_phrase
      sha_sign, sha_out_phrase, ogone_return = @request['SHASIGN'], "", {}
      
      # Upcase and sort paramaters to params
      @request.each do |key, value|
        ogone_return[key.upcase] = value unless key == 'SHASIGN' # exclude SHASIGN
      end

      # Generate sha_out_hash
      ogone_return.sort.each do |key, value|
        sha_out_phrase << "#{key.upcase}=#{value}#{OgoneRails::sha_out}"
      end      
      
      # Digest sha_out_phrase
      sha_check = Digest::SHA1.hexdigest(sha_out_phrase).upcase
    
      # Compare sha_sign with digested phrase
      if sha_check == sha_sign
        return true
      else
       return false
      end
    end
    

    def get_params
      # return values in readable format
      @params = {
        :order_id => (@request['orderID']).to_i,
        :amount => (@request['amount']).to_f,
        :currency => @request['currency'],
        :payment_method => @request['PM'],
        :acceptance => @request['ACCEPTANCE'],
        :status => STATUS_CODES[@request['STATUS'].to_i],
        :card_number => @request['CARDNO'],
        :pay_id => @request['PAYID'],
        :error => @request['NC ERROR'],
        :brand => @request['BRAND'],
        :sha_sign => @request['SHASIGN']
      }
    end
  end
end
