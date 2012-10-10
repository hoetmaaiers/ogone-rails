module OgoneRails
  class Form
    attr_reader :form_tag, :form_fields
    
    def initialize action, options
      @form_fields = ""
      
      # parse form atributes
      form_attributes = ""
      options.each do |key, value|
        form_attributes << "#{key}=\"#{value}\" "
      end
      
      @form_tag = "<form method='post' action='#{action}' #{ form_attributes }>\n"
    end
    
    def add_input name, value
      @form_fields << "\t<input type='hidden' name='#{name}' value='#{value}' />\n"
    end
  end
end