#Ogone for Rails


##What is it

A Ruby gem to easy use [Ogone](http://www.ogone.com) online payments service


##Usage

### Installation
	gem install ogone-rails

### Configuration
Define in:

* PSPID
* currency
* language
* sha_in
* sha_out 
* debug (default = true)


		# config/initializers/ogone-rails.rb
		
		OgoneRails::Config.pspid = "myPSPID"
		OgoneRails::Config.currency = "EUR"
		OgoneRails::Config.language = "nl_NL"
		OgoneRails::Config.sha_in = "********************************"
		OgoneRails::Config.sha_out = "********************************"
		OgoneRails::Config.debug = true


### Helpers
Generate an **ogone_form**

	ogone_form({
    	:order_id => 12345, 
    	:amount => "299.99", 
    	:customer_name => "Jan Janssen",
    	:customer_email => "jan@email.com",
   		:customer_address => "highstreet 101",
   		:customer_zip => "1000",
    	:customer_city => "Brussel",
    	:customer_country => "Belgium",
    	:customer_phone => "0412345678"
 	 })

### Check Ogone feedback

Check the accept feedback Ogone sends you:
	
	# app/controllers/feedback_controller.rb
	@check = OgoneRails::check_auth( request.GET )

On **true** a hash with all parameters returned. On **false** the check returns false.
The returned values are made much more readable then Ogone's naming:

	{
		"order_id" => "46185", 
		"amount" => "299.38", 
		"currency" => "EUR", 
		"payment_method" => "CreditCard",
		"acceptance" => "test123", 
		"status" => "5", 
		"card_number" => "XXXXXXXXXXXX1111",
		"pay_id" => "14838904", 
		"error" => nil, 
		"brand" => "VISA",
		"sha_sign" => "51AF71351E79DD0186816289AD53C57213978E32"
	}
	
### Copyright
Copyright &copy; 2012 Robin Houdmeyers