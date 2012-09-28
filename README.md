#Ogone for Rails


##What is it
<br/>
A Ruby gem to simplify the use of [Ogone](http://www.ogone.com) online payments service.


### Installation
	gem install ogone-rails
	# or include in a gemfile
	gem 'ogone-rails'

### Configuration

#### Use the generator
		
		rails generate ogone:config
		
This creates 2 files. Change te example configruation in **ogone.yml** to your own configuration.


	
#### or configure manually

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
Generate an **ogone_form**:

	ogone_form({
		#transaction information
    	:order_id => 12345, 
    	:amount => 299.99, 
    	:customer_name => "Jan Janssen",
    	:customer_email => "jan@email.com",
   		:customer_address => "highstreet 101",
   		:customer_zip => "1000",
    	:customer_city => "Brussel",
    	:customer_country => "Belgium",
    	:customer_phone => "0412345678",
    	
    	# feedback url's
    	:accept_url => "www.example.com/ogone/accept",
    	:decline_url => "www.example.com/ogone/decline",
    	:exception_url => "www.example.com/ogone/exception",
    	:cancel_url => "www.example.com/ogone/cancel",
    	
    	# look and feel
    	:title => "lorem ipsum",
    	:bg_color => "FFFFFF",
    	:text_color => "000000",
    	:table_bg_color => "000000",
    	:table_text_color => "000000",    	
    	:button_bg_color => "CCCCCC",
    	:button_text_color => "000000",
    	:font_family => "Helvetica",
    	:logo => "www.example.com/images/logo.png",
    	
    	# default ogone parameter
    	'PARAM' => "example"
   	})

### Check Ogone feedback

Create a new object to check the feedback Ogone gives you:

	# app/controllers/feedback_controller.rb
    @check = OgoneRails::CheckAuth.new( request )

Check valid authorization:
	
	@check.valid?
	#return true or false

Get parameters:
	
	@check.get_parameters
	
… returns the Ogone feedback in a hash format. The keys are made more readable then Ogone provides them: …

	{
		"order_id" => 46185, 
		"amount" => 299.38, 
		"currency" => "EUR", 
		"payment_method" => "CreditCard",
		"acceptance" => "test123", 
		"status" => "Authorized", 
		"card_number" => "XXXXXXXXXXXX1111",
		"pay_id" => "14838904", 
		"error" => nil, 
		"brand" => "VISA",
		"sha_sign" => "51AF71351E79DD0186816289AD53C57213978E32"
	}
	
### Helper use for Subscrioptions billing after every end of Month

<%= ogone_form ({
         :order_id => 123456,
         :amount => 2.99,
         :customer_name => 'Jan Jansdfsdfssen',
         :customer_email => 'jsdfsdfan@email.com',
         :customer_address => 'highstreet 101',
         :customer_zip => '1000',
         :customer_city => 'Brussel',
         :customer_country => 'Belgium',
         :customer_phone => '0412345678',


        :subscription_id => '452343',
        :sub_amount => '49',
        :sub_com => '23423423',
        :sub_orderid => '2343243',
        :sub_period_unit => 'm',
        :sub_period_number => '1',
        :sub_period_moment => '31',
        :sub_startdate => '2012-09-28',
        :sub_enddate => '2013-09-28',
        :sub_status => '1',
        :sub_comment => 'test',

         :accept_url => 'example.com/ogon/accept',
         :decline_url => 'example.com/ogon/decline',
         :exception_url => 'example.com/ogon/exception',
         :cancel_url => 'example.com/ogon/cancel',

        })%>

### Copyright
Copyright &copy; 2012 Robin Houdmeyers. See LICENSE.txt for further details.
