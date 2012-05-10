module OgoneRails
  module Helpers
    extend self

    def ogone_form options={}
      form = ""
      
      if OgoneRails::Config.debug
        form = "<form method='post' action='#{OgoneRails::Config::TEST_SERVICE_URL}'>\n"
      else
        form = "<form method='post' action='#{OgoneRails::Config::LIVE_SERVICE_URL}'>\n"
      end
      
      # REQUIRED VALUES
      StringToHash::reset
      # pspid
      form << "\t<input type='hidden' name='PSPID' value='#{OgoneRails::Config.pspid}'>\n"
      StringToHash::add_parameter 'PSPID', OgoneRails::Config.pspid
      # currency
      form << "\t<input type='hidden' name='currency' value='#{OgoneRails::Config.currency}'>\n"
      StringToHash::add_parameter 'currency', OgoneRails::Config.currency
      # language
      form << "\t<input type='hidden' name='language' value='#{OgoneRails::Config.language}'>\n"
      StringToHash::add_parameter 'language', OgoneRails::Config.language
      
      
      
      # OPTIONAL VALUES
      options.each do |option, value|
        case option
        when :order_id
          form << "\t<input type='hidden' name='orderID' value='#{value}'>\n"
          StringToHash::add_parameter 'orderID', value
        when :amount
          #amount 15.00 -> 1500
          value = (value.to_f * 100).to_i
          form << "\t<input type='hidden' name='amount' value='#{value}'>\n"
          StringToHash::add_parameter 'amount', value
        when :customer_name
          form << "\t<input type='hidden' name='CN' value='#{value}'>\n"
          StringToHash::add_parameter 'CN', value
        when :customer_email
          form << "\t<input type='hidden' name='EMAIL' value='#{value}'>\n"
          StringToHash::add_parameter 'EMAIL', value
        when :customer_address
          form << "\t<input type='hidden' name='owneraddress' value='#{value}'>\n"
          StringToHash::add_parameter 'owneraddress', value
        when :customer_zip
          form << "\t<input type='hidden' name='ownerZIP' value='#{value}'>\n"
          StringToHash::add_parameter 'ownerZIP', value
        when :customer_city
          form << "\t<input type='hidden' name='ownertown' value='#{value}'>\n"
          StringToHash::add_parameter 'ownertown', value
        when :customer_country
          form << "\t<input type='hidden' name='ownercty' value='#{value}'>\n"          
          StringToHash::add_parameter 'ownercty', value
        when :customer_phone
          form << "\t<input type='hidden' name='ownertelno' value='#{value}'>\n"
          StringToHash::add_parameter 'ownertelno', value
        else
          form << "\t<input type='hidden' name='#{option}' value='#{value}'>\n"
        end
      end
      
      # shasign
      sha_in = StringToHash.generate_sha_in
      form << "\t<input type='hidden' name='SHASign' value='#{sha_in}'>\n"

      #submit
      form << "\t<input type='submit' value='ga verder naar ogone' id='submit2' name='submit2'>\n"
      
      form << "</form>"
      form.html_safe
    end
  end
end