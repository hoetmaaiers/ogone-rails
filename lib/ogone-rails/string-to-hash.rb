module OgoneRails
  class StringToHash
    attr_accessor :sha_in_phrase
    
    def initialize
      @params = {}
      @sha_in_phrase = ""
    end
    
    def add_parameter key, value
      @params[key.upcase] = value
    end
    
    def generate_sha_in
      @params.sort.each do |key, value|
        @sha_in_phrase << "#{key.upcase}=#{value}#{OgoneRails::sha_in}"
      end
      
      Digest::SHA1.hexdigest(@sha_in_phrase).upcase
    end
    
    def get_string
      string = ""
      @params.each do |key, value|
        string << "#{key}=#{value}"
      end
    end
    
    #-D unused since Module transformed to Class
    #-D def reset
    #-D   @sha_in_phrase = ""
    #-D   @params = {}
    #-D end
  end
end
