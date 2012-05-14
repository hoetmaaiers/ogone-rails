module OgoneRails
  module Helpers
    extend self

    def ogone_form options={}
      
      OgoneRails::mode == "live" ? action = OgoneRails::LIVE_SERVICE_URL : action = OgoneRails::TEST_SERVICE_URL
      form = Form.new(action)
      
      # REQUIRED VALUES
      StringToHash::reset
      # pspid
      form.add_input('PSPID', OgoneRails::pspid)
      StringToHash::add_parameter 'PSPID', OgoneRails::pspid
      # currency
      form.add_input('currency', OgoneRails::currency)
      StringToHash::add_parameter 'currency', OgoneRails::currency
      # language
      form.add_input('language', OgoneRails::language)
      StringToHash::add_parameter 'language', OgoneRails::language
      
      
      
      # OPTIONAL VALUES
      options.each do |option, value|
        case option
        
        
        # ------------------
        # General parameters
        
        when :order_id
          form.add_input('orderID', value)
          StringToHash::add_parameter 'orderID', value
          
        when :amount
          #amount 15.00 -> 1500
          value = (value.to_f * 100).to_i
          form.add_input('amount', value)
          StringToHash::add_parameter 'amount', value
          
        when :customer_name
          form.add_input('CN', value)
          StringToHash::add_parameter 'CN', value
          
        when :customer_email
          form.add_input('EMAIL', value)
          StringToHash::add_parameter 'EMAIL', value
          
        when :customer_address
          form.add_input('owneraddress', value)
          StringToHash::add_parameter 'owneraddress', value
          
        when :customer_zip
          form.add_input('ownerZIP', value)
          StringToHash::add_parameter 'ownerZIP', value
          
        when :customer_city
          form.add_input('ownertown', value)
          StringToHash::add_parameter 'ownertown', value
          
        when :customer_country
          form.add_input('ownercty', value)
          StringToHash::add_parameter 'ownercty', value
          
        when :customer_phone
          form.add_input('ownertelno', value)
          StringToHash::add_parameter 'ownertelno', value
        
        
        # --------------
        # Feedback url's
        
        when :accept_url
          form.add_input('accepturl', value)
          StringToHash::add_parameter 'accepturl', value
          
        when :decline_url
          form.add_input('declineurl', value)
          StringToHash::add_parameter 'declineurl', value
        
        when :exception_url
          form.add_input('exceptionurl', value)
          StringToHash::add_parameter 'exceptionurl', value
          
        when :cancel_url
          form.add_input('cancelurl', value)
          StringToHash::add_parameter 'cancelurl', value
        
        
        # --------------
        # Look and feel
        
        when :title
          form.add_input('TITLE', value)
          StringToHash::add_parameter 'TITLE', value

        when :bg_color
          form.add_input('BGCOLOR', value)
          StringToHash::add_parameter 'BGCOLOR', value


        when :text_color
          form.add_input('TXTCOLOR', value)
          StringToHash::add_parameter 'TXTCOLOR', value


        when :table_bg_color
          form.add_input('TBLBGCOLOR', value)
          StringToHash::add_parameter 'TBLBGCOLOR', value

        when :table_text_color
          form.add_input('TBLTXTCOLOR', value)
          StringToHash::add_parameter 'TBLTXTCOLOR', value
        
        
        when :button_bg_color
          form.add_input('BUTTONBGCOLOR', value)
          StringToHash::add_parameter 'BUTTONBGCOLOR', value
        
        
        when :button_text_color
          form.add_input('BUTTONTXTCOLOR', value)
          StringToHash::add_parameter 'BUTTONTXTCOLOR', value
        
        
        when :font_family
          form.add_input('FONTTYPE', value)
          StringToHash::add_parameter 'FONTTYPE', value
        
        when :logo
          form.add_input('LOGO', value)
          StringToHash::add_parameter 'LOGO', value
        
        
        else
          form.add_input(option, value)
        end
      end
      
      # shasign
      sha_in = StringToHash.generate_sha_in
      form.add_input('SHASign', sha_in)

      form.get_form
    end
  end
  
  
  
  class Form
    def initialize action
      @form = ""
      @form << "<form method='post' action='#{action}'>\n"
    end
    
    def add_input name, value
      @form << "\t<input type='hidden' name='#{name}' value='#{value}'>\n"
    end

    
    def get_form
      @form << "\t<input type='submit' value='ga verder naar ogone' id='submit2' name='submit2'>\n"
      @form << "</form>"
      @form.html_safe
    end
  end
end