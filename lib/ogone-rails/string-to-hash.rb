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
    
    def generate_sha_out
      
    end
    
    # unused since Module transformed to Class
    def reset
      @sha_in_phrase = ""
      @params = {}
    end
  end
end
