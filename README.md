#Ogone for Rails


##What is it

A Ruby gem to simplify the use of [Ogone](http://www.ogone.com) online payments service.


##Usage

### Installation
	gem install ogone-rails
	# or include in a gemfile
	gem 'ogone-rails'

### Configuration
Define ogone parameters in a yaml config file:
		
		# config/ogone.yml
		development:
  			pspid: "hoetmaaiers"
  			sha_in: "0123456789abcdefghijklmnopqrstuv"
  			sha_out: "vutsrqponmlkjihgfedcba9876543210"
  			currency: "EUR"
  			language: "nl_NL"
  			mode: 'test'
  		production:
  			pspid: "hoetmaaiers"
  			sha_in: "0123456789abcdefghijklmnopqrstuv"
  			sha_out: "vutsrqponmlkjihgfedcba9876543210"
  			currency: "EUR"
  			language: "nl_NL"
  			mode: 'live'

Configure ogone-rails in an initializer:
		
		# initializers/ogone.rb
		ogone_config = YAML.load_file('config/ogone.yml')[Rails.env].symbolize_keys
		OgoneRails::config (ogone_config)
		

#### Parameters	
__required__

* PSPID
* sha_in
* sha_out

__optional__

* currency,  _default: "EUR"_
* language, _default: "nl_NL"_
* mode, _default = "live"_



### Helpers

#### New syntax

Generate an **ogone_form** whith the new syntax.


**Full example**
	
	ogone_form_tag({:id => "form"}) do 
		form_content = ogone_fields({  
	        :parameter => value
	        ...
	      })
	
		# add custom submit
		form_content << '<input type="submit" value="pay now" />'
	end

**ogone_form_tag** example
	
	ogone_form_tag({ :html_attribute => "value" }) do 
		...
		# everything in here must be in one variable
		form_content = "…"
		form_content << "…"		
		...
	end

**ogone_fields** example

Generate hidden input fields with ogone parameters.


	ogone_fields({
		:parameter => "value",
		...
	}

#### Parameters

      ogone_fields_options = {
        # General parameters
        :order_id           => 'orderID',
        :amount             => 'amount',
        :customer_name      => 'CN',
        :customer_email     => 'EMAIL',
        :customer_address   => 'owneraddress',
        :customer_zip       => 'ownerZIP',
        :customer_city      => 'ownertown',
        :customer_country   => 'ownercty',
        :customer_phone     => 'ownertelno',
        # Feedback url's    
        :accept_url         => 'accepturl',
        :decline_url        => 'declineurl',
        :exception_url      => 'exceptionurl',
        :cancel_url         => 'cancelurl',
        # Look and feel     
        :title              => 'TITLE',
        :bg_color           => 'BGCOLOR',
        :text_color         => 'TXTCOLOR',
        :table_bg_color     => 'TBLBGCOLOR',
        :table_text_color   => 'TBLTXTCOLOR',
        :button_bg_color    => 'BUTTONBGCOLOR',
        :button_text_color  => 'BUTTONTXTCOLOR',
        :font_family        => 'FONTTYPE',
        :logo               => 'LOGO'       
      }



####No worry, old syntax is still enabled...


	ogone_form({
		:paramater => "value"
   	}, { :html_attribute => "" })

### Check Ogone feedback

Create a new object to check the feedback Ogone gives you:

	# app/controllers/feedback_controller.rb
    @check = OgoneRails::CheckAuth.new( request )

Check valid authorization:
	
	@check.valid?
	#return true or false

Get parameters:
	
	@check.get_params
	
… returns the Ogone feedback in a hash format. The keys are made more readable then Ogone provides them: …

	{
		:order_id => 46185, 
		:amount => 299.38, 
		:currency => "EUR", 
		:payment_method => "CreditCard",
		:acceptance => "test123", 
		:status => "Authorized", 
		:card_number => "XXXXXXXXXXXX1111",
		:pay_id => "14838904", 
		:error => nil, 
		:brand => "VISA",
		:sha_sign => "51AF71351E79DD0186816289AD53C57213978E32"
	}
	
### Copyright
Copyright &copy; 2012 Robin Houdmeyers